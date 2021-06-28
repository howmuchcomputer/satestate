require "net/http"
require "uri"

module Satellite
  class Connection
    def initialize(url)
      @url = URI.parse(url)
    end

    def fetch_data
      transform(Net::HTTP.get_response(url))
    end

    private

    attr_reader :url

    def transform(response)
      JSON.parse(response.body)
    end
  end
end

