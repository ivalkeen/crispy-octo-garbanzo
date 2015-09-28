# Facade for the configuration
#
class Config
  # Fyber application API key (keep it private)
  API_KEY = ENV["API_KEY"].freeze

  # Rack secret for encoding session
  SECRET = ENV["SECRET"].freeze

  # Default request parameters, provided by Fyber
  DEFAULT_PARAMS = {
    appid: ENV["APPID"],
    device_id: ENV["DEVICE_ID"],
    locale: ENV["LOCALE"],
    ip: ENV["IP"],
    offer_types: ENV["OFFER_TYPES"],
  }.freeze
end
