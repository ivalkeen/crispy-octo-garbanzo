class Config
  class << self
    def api_key
      ENV["API_KEY"]
    end

    def default_params
      {
        appid: ENV["APPID"],
        device_id: ENV["DEVICE_ID"],
        locale: ENV["LOCALE"],
        ip: ENV["IP"],
        offer_types: ENV["OFFER_TYPES"],
      }
    end
  end
end
