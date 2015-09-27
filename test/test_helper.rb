$LOAD_PATH.unshift("./app")

require "minitest/autorun"
require "webmock"
require "erb"

WebMock.disable_net_connect!

def fixture(fixture_file)
  path = Pathname.new(File.dirname(__FILE__)).join("fixtures/#{fixture_file}.yml")
  YAML.load(ERB.new(File.read(path)).result(binding))
end
