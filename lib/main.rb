#!/bin/ruby
require 'pry'
require 'kramdown'
require_relative 'one_page_site'

OnePageSite.new("I'm Bobby. I'm a programmer in New York. My github's @notactuallypagemcconnell. I like improvizational music, especially Phish.").generate
puts "Site copied to clipboard"
