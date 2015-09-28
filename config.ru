if ENV["RACK_ENV"] == "development"
  require "dotenv"
  Dotenv.load
end

require "./app/server.rb"

run Cuba
