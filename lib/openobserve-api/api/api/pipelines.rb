# frozen_string_literal: true

module OpenObserve::Api
  class Api::Pipelines
    def initialize(connection)
      @connection = connection
    end

    def backfill(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/pipelines/backfill'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def backfill_delete(org_id:, pipeline_id:, job_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'pipeline_id is required' if pipeline_id.nil?
      raise ArgumentError, 'job_id is required' if job_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/pipelines/{pipeline_id}/backfill/{job_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{pipeline_id}', ERB::Util.url_encode(pipeline_id.to_s))
          .gsub('{job_id}', ERB::Util.url_encode(job_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def backfill_enable(org_id:, pipeline_id:, job_id:, value:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'pipeline_id is required' if pipeline_id.nil?
      raise ArgumentError, 'job_id is required' if job_id.nil?
      raise ArgumentError, 'value is required' if value.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/pipelines/{pipeline_id}/backfill/{job_id}/enable'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{pipeline_id}', ERB::Util.url_encode(pipeline_id.to_s))
          .gsub('{job_id}', ERB::Util.url_encode(job_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'value' => value }
      )
    end

    def backfill_get(org_id:, pipeline_id:, job_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'pipeline_id is required' if pipeline_id.nil?
      raise ArgumentError, 'job_id is required' if job_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/pipelines/{pipeline_id}/backfill/{job_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{pipeline_id}', ERB::Util.url_encode(pipeline_id.to_s))
          .gsub('{job_id}', ERB::Util.url_encode(job_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def backfill_post(org_id:, pipeline_id:, backfill_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'pipeline_id is required' if pipeline_id.nil?
      raise ArgumentError, 'backfill_request is required' if backfill_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/pipelines/{pipeline_id}/backfill'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{pipeline_id}', ERB::Util.url_encode(pipeline_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: backfill_request
      )
    end

    def backfill_put(org_id:, pipeline_id:, job_id:, backfill_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'pipeline_id is required' if pipeline_id.nil?
      raise ArgumentError, 'job_id is required' if job_id.nil?
      raise ArgumentError, 'backfill_request is required' if backfill_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/pipelines/{pipeline_id}/backfill/{job_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{pipeline_id}', ERB::Util.url_encode(pipeline_id.to_s))
          .gsub('{job_id}', ERB::Util.url_encode(job_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: backfill_request
      )
    end

    def bulk_enable(org_id:, value:, enable_alert_bulk_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'value is required' if value.nil?
      raise ArgumentError, 'enable_alert_bulk_request is required' if enable_alert_bulk_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/pipelines/bulk/enable'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'value' => value },
        body: enable_alert_bulk_request
      )
    end

    def bulk_update(org_id:, update_pipeline_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'update_pipeline_request is required' if update_pipeline_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/pipelines'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: update_pipeline_request
      )
    end

    def create(org_id:, update_pipeline_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'update_pipeline_request is required' if update_pipeline_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/pipelines'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: update_pipeline_request
      )
    end

    def delete(org_id:, pipeline_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'pipeline_id is required' if pipeline_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/pipelines/{pipeline_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{pipeline_id}', ERB::Util.url_encode(pipeline_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def enable(org_id:, pipeline_id:, value:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'pipeline_id is required' if pipeline_id.nil?
      raise ArgumentError, 'value is required' if value.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/pipelines/{pipeline_id}/enable'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{pipeline_id}', ERB::Util.url_encode(pipeline_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'value' => value }
      )
    end

    def get(org_id:, pipeline_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'pipeline_id is required' if pipeline_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/pipelines/{pipeline_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{pipeline_id}', ERB::Util.url_encode(pipeline_id.to_s)),
        type: OpenObserve::Api::Models::GetPipeline200Response,
        auth: ['Authorization']
      )
    end

    def history(org_id:, pipeline_id: nil, start_time: nil, end_time: nil, from: nil, size: nil, sort_by: nil, sort_order: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/pipelines/history'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::PipelineHistoryResponse,
        auth: ['Authorization'],
        query: { 'pipeline_id' => pipeline_id, 'start_time' => start_time, 'end_time' => end_time, 'from' => from, 'size' => size, 'sort_by' => sort_by, 'sort_order' => sort_order }
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/pipelines'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::ListPipelines200Response,
        auth: ['Authorization']
      )
    end

    def streams(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/pipelines/streams'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::ListPipelines200Response,
        auth: ['Authorization']
      )
    end
  end
end
