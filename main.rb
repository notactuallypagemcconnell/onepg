#!/bin/ruby

require 'kramdown'

def main
  base = File.read("index.html")

  html_docs = `ls posts`.split("\n").map do |file|
                Kramdown::Document.new(File.read("posts/#{file}")).to_html
              end
  puts base + html_docs.join("\n")
end

main
