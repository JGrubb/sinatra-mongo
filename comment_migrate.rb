require 'nokogiri'
require 'mongo'

@doc = Nokogiri::XML(File.open("/Users/therealjohnnygrubb/Downloads/ignoredbydinosaurs-61254a16944abb40a0e5759caf210fe7.xml"))

counter = 0
urls = []

puts @doc.xpath("//*[@dsq:id]").first

#puts urls
