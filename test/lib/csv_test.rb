require_relative '../test_helper'

class CsvLibTest < ActionController::TestCase
  test "should generate csv" do
 	
		contents_json = JSON.parse(File.read("test/resources/tweets.json"))
		csv = CsvGenerate.new
		string_csv = csv.convert_json(contents_json)
		assert_not_nil(string_csv)

  end

  test "should write file" do
 	
		contents_json = JSON.parse(File.read("test/resources/tweets.json"))
		csv = CsvGenerate.new
		string_csv = csv.convert_json(contents_json)
		path = csv.write(string_csv)
		assert(true, File.exist?(path))
		
  end
end



