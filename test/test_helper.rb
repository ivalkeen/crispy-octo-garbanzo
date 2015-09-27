$LOAD_PATH.unshift("./app")

require "minitest/autorun"
require "webmock/minitest"
require "yaml"

def fixture(fixture_file)
  path = Pathname.new(File.dirname(__FILE__)).join("fixtures/#{fixture_file}.yml")
  YAML.load_file(path)
end

def fixed_response(response_file)
  path = Pathname.new(File.dirname(__FILE__)).join("fixtures/#{response_file}.txt")
  File.read(path)
end
