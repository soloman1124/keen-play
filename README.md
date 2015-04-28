# keen-play

- bundle exec ruby run_events.rb
- bundle exec ruby run_query.rb

TODO: Before `keen-gem` (https://github.com/keenlabs/keen-gem) supports post query, we need to modify the file in the gem:

- keen-gem/lib/keen/client/querying_methods.rb
- please see the added post_query method.

```ruby
require 'uri'

module Keen
  class Client
    module QueryingMethods

      # Runs a count query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#count-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def count(event_collection, params={}, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a count unique query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#count-unique-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   target_property (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def count_unique(event_collection, params, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a minimum query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#minimum-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   target_property (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def minimum(event_collection, params, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a maximum query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#maximum-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   target_property (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def maximum(event_collection, params, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a sum query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#sum-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   target_property (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def sum(event_collection, params, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a average query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#average-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   target_property (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def average(event_collection, params, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a median query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#median-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   target_property (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def median(event_collection, params, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a percentile query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#percentile-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   target_property (required)
      #   percentile (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def percentile(event_collection, params, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a select_unique query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#select-unique-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   target_property (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def select_unique(event_collection, params, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a extraction query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#extraction-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   target_property (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      #   latest (optional)
      def extraction(event_collection, params={}, options={})
        query(__method__, event_collection, params, options)
      end

      # Runs a funnel query.
      # See detailed documentation here:
      # https://keen.io/docs/api/reference/#funnel-resource
      #
      # @param event_collection
      # @param params [Hash] (optional)
      #   steps (required)
      def funnel(params, options={})
        post_query(__method__, nil, params, options)
      end

      # Runs a multi-analysis query
      # See detailed documentation here:
      # https://keen.io/docs/data-analysis/multi-analysis/
      #
      # NOTE: why isn't multi-analysis listed in the
      #       API Technical Reference?
      #
      # @param event_collection
      # @param params [Hash]
      #   analyses [Hash] (required)
      #     label (required)
      #     analysis_type (required)
      #     target_property (optional)
      def multi_analysis(event_collection, params, options={})
        query(__method__, event_collection, params, options)
      end

      # Returns the URL for a Query without running it
      # @param event_colection
      # @param params [Hash] (required)
      #   analysis_type (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      # @param options
      #   exclude_api_key
      def query_url(analysis_type, event_collection, params={}, options={})
        str = _query_url(analysis_type, event_collection, params, options)
        str << "&api_key=#{self.read_key}" unless options[:exclude_api_key]
        str
      end

      # Run a query
      # @param event_colection
      # @param params [Hash] (required)
      #   analysis_type (required)
      #   group_by (optional)
      #   timeframe (optional)
      #   interval (optional)
      #   filters (optional) [Array]
      #   timezone (optional)
      def query(analysis_type, event_collection, params={}, options={})
        url = _query_url(analysis_type, event_collection, params, options)
        response = get_response(url)
        response_body = response.body.chomp
        api_result = process_response(response.code, response_body)
        api_result = api_result["result"] unless options[:response] == :all_keys
        api_result
      end

      def post_query(analysis_type, event_collection, params={}, options={})
        uri = URI.parse "#{self.api_url}#{api_query_resource_path(analysis_type)}"
        response = Keen::HTTP::Sync.new(self.api_url, self.proxy_url, self.read_timeout).post(
          path: "#{uri.path}?#{uri.query}",
          headers: api_headers(self.read_key, "sync"),
          body: params.to_json
        )

        response_body = response.body.chomp
        api_result = process_response(response.code, response_body)
        api_result = api_result["result"] unless options[:response] == :all_keys
        api_result
      end

      private

      def _query_url(analysis_type, event_collection, params={}, options={})
        ensure_project_id!
        ensure_read_key!

        query_params = params.dup
        query_params[:event_collection] = event_collection.to_s if event_collection
        "#{self.api_url}#{api_query_resource_path(analysis_type)}?#{preprocess_params(query_params)}"
      end

      def get_response(url)
        uri = URI.parse(url)
        Keen::HTTP::Sync.new(self.api_url, self.proxy_url, self.read_timeout).get(
          :path => "#{uri.path}?#{uri.query}",
          :headers => api_headers(self.read_key, "sync")
        )
      rescue Exception => http_error
        raise HttpError.new("Couldn't perform #{@analysis_type} on Keen IO: #{http_error.message}", http_error)
      end

      def api_query_resource_path(analysis_type)
        "/#{self.api_version}/projects/#{self.project_id}/queries/#{analysis_type}"
      end
    end
  end
end

```
