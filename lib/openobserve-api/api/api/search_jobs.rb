# frozen_string_literal: true

module OpenObserve::Api
  class Api::SearchJobs
    def initialize(connection)
      @connection = connection
    end

    def call_retry(org_id:, job_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'job_id is required' if job_id.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/search_jobs/{job_id}/retry'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{job_id}', ERB::Util.url_encode(job_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def cancel(org_id:, job_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'job_id is required' if job_id.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/search_jobs/{job_id}/cancel'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{job_id}', ERB::Util.url_encode(job_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def create(org_id:, search_sql_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'search_sql_request is required' if search_sql_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/search_jobs'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: search_sql_request
      )
    end

    def delete(org_id:, job_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'job_id is required' if job_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/search_jobs/{job_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{job_id}', ERB::Util.url_encode(job_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def get(org_id:, job_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'job_id is required' if job_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/search_jobs/{job_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{job_id}', ERB::Util.url_encode(job_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/search_jobs'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def result(org_id:, job_id:, from: nil, size: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'job_id is required' if job_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/search_jobs/{job_id}/result'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{job_id}', ERB::Util.url_encode(job_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'from' => from, 'size' => size }
      )
    end
  end
end
