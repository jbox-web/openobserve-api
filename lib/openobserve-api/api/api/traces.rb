# frozen_string_literal: true

module OpenObserve::Api
  class Api::Traces
    def initialize(connection)
      @connection = connection
    end

    def dag(org_id:, stream_name:, trace_id:, start_time:, end_time:, timeout: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'trace_id is required' if trace_id.nil?
      raise ArgumentError, 'start_time is required' if start_time.nil?
      raise ArgumentError, 'end_time is required' if end_time.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/{stream_name}/traces/{trace_id}/dag'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s))
          .gsub('{trace_id}', ERB::Util.url_encode(trace_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'start_time' => start_time, 'end_time' => end_time, 'timeout' => timeout }
      )
    end

    def latest(org_id:, stream_name:, from:, size:, start_time:, end_time:, filter: nil, timeout: nil, sort_by: nil, sort_order: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'from is required' if from.nil?
      raise ArgumentError, 'size is required' if size.nil?
      raise ArgumentError, 'start_time is required' if start_time.nil?
      raise ArgumentError, 'end_time is required' if end_time.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/{stream_name}/traces/latest'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'filter' => filter, 'from' => from, 'size' => size, 'start_time' => start_time, 'end_time' => end_time, 'timeout' => timeout, 'sort_by' => sort_by, 'sort_order' => sort_order }
      )
    end

    def service_graph_topology_current(org_id:, stream_name: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/traces/service_graph/topology/current'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'stream_name' => stream_name }
      )
    end

    def session(org_id:, stream_name:, from:, size:, start_time:, end_time:, filter: nil, timeout: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'from is required' if from.nil?
      raise ArgumentError, 'size is required' if size.nil?
      raise ArgumentError, 'start_time is required' if start_time.nil?
      raise ArgumentError, 'end_time is required' if end_time.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/{stream_name}/traces/session'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'filter' => filter, 'from' => from, 'size' => size, 'start_time' => start_time, 'end_time' => end_time, 'timeout' => timeout }
      )
    end

    def user(org_id:, stream_name:, from:, size:, start_time:, end_time:, filter: nil, timeout: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'from is required' if from.nil?
      raise ArgumentError, 'size is required' if size.nil?
      raise ArgumentError, 'start_time is required' if start_time.nil?
      raise ArgumentError, 'end_time is required' if end_time.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/{stream_name}/traces/user'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'filter' => filter, 'from' => from, 'size' => size, 'start_time' => start_time, 'end_time' => end_time, 'timeout' => timeout }
      )
    end
  end
end
