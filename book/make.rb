require 'rdiscount'

`ls | sort | grep md`.split("\n").map do |post|
  file = post.split(".md").first
  
  File.write("html/#{file}.html", RDiscount.new(File.read(post)).to_html + "#{'</br>' * 50}")
  `cat html/* > index.html`
end
