# frozen_string_literal: true

require 'spec_helper'
require_relative 'support/instance'

# Ingest-then-search round-trip against a disposable dockerized OpenObserve 0.91.5.
#
# This is the e2e canary: it proves the real HTTP transport end to end — Authorization-header
# auth, POST ingestion, POST search, and model serialization — against a live REST API. It
# WRITES, so it runs exclusively against the throwaway instance `Instance` spins up and tears
# down.
#
# Opt-in only. The generated `spec_helper` cannot carry an `:e2e` exclusion (it is regenerated),
# so the suite self-gates on OPENOBSERVE_E2E: without it the group is never even defined,
# keeping the default `mise dev:spec` run network-free and write-free. The `mise run e2e` task
# sets OPENOBSERVE_E2E.
if ENV['OPENOBSERVE_E2E']
  RSpec.describe 'ingest then search', :e2e do
    # One expensive scenario: bring the disposable instance up, drive the whole round-trip, and
    # tear it down in `ensure` so a mid-flight failure never leaks containers. Kept in a single
    # example (no before/after :all hooks) on purpose.
    it 'ingests a log line and searches it back through the live REST API' do
      E2E::Instance.up
      client = E2E::Instance.client
      org    = E2E::Instance::ORG
      stream = 'canary'
      # Unique per run so a re-run against a warm volume cannot pass on a previous run's row.
      marker = "canary-#{Process.clock_gettime(Process::CLOCK_REALTIME, :nanosecond)}"

      # HEALTH — the instance answers before anything else is asserted.
      expect(client.healthz.list.status).to eq 200

      # INGEST — a raw Array body; the spec types this endpoint as free-form, so no model.
      expect(
        client.api._json(org_id: org, stream_name: stream, body: [{ level: 'info', message: marker }]).status
      ).to eq 200

      # SEARCH — ingestion is not synchronous and OpenObserve publishes no bound on visibility,
      # so poll rather than sleep: a fixed wait is either flaky or slow. This also exercises the
      # generated SearchSQLRequest / SearchQuery models on the way out.
      hits = E2E::Instance.wait_until(60, "#{marker} to become searchable") do
        found = E2E::Instance.search(client, stream, marker)
        found unless found.empty?
      end

      expect(hits.first['message']).to eq marker
    ensure
      E2E::Instance.down
    end
  end
end
