require_relative '../lib/html_document'
require_relative '../lib/bannered_introduction'

doc = HtmlDocument.new
b = File.read("bartlebee.txt").split("\n").uniq

b.map do |l|
  doc.add_nodes(BanneredIntroduction.new(l, "\n").banner_nodes)
end

puts doc.body
