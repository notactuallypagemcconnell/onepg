#!/bin/ruby
require 'pry'
require 'kramdown'
require_relative 'one_page_site'

OnePageSite.new("Hi I'm Bobby. I'm a programmer in New York. My github username is @notactuallypagemcconnell.").generate
puts "Site copied to clipboard"
