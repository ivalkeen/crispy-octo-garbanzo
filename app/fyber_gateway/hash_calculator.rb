require "digest/sha1"

module FyberGateway
  class HashCalculator
    def initialize(params, api_key)
      @params = params
      @api_key = api_key
    end

    def calculate
      sorted_params = params.flat_map { |k, v| "#{k}=#{v}" }.sort
      buffer = sorted_params.join("&")
      buffer << "&#{api_key}"

      Digest::SHA1.hexdigest(buffer)
    end

    private

    attr_reader :params, :api_key
  end
end
