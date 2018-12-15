#!/bin/ruby
require 'pry'
require 'kramdown'
require_relative 'one_page_site'

default = "I'm Bobby. I'm a programmer in New York. My github's @notactuallypagemcconnell. I like improvizational music, especially Phish."

OnePageSite.new(default).generate

# puts "Site copied to clipboard, index.html written as well."
