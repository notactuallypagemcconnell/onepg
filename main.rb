#!/bin/ruby

require 'kramdown'

class OnePageSite
  def initialize(posts_directory = "/posts")
    @posts_directory = posts_directory
  end

  def generate
    puts full_page
  end

  def full_page
    "#{base}#{page_break}#{html_posts.join(page_break)}"
  end

  def html_posts
    posts.map { |post| post_to_html(post) }
  end

  def post_to_html(post)
    Kramdown::Document.new(File.read("posts/#{post}")).to_html
  end

  def posts
    `ls posts`.split("\n")
  end

  def base
    File.read("index.html")
  end

  def page_break
    "</br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br>"
  end
end

html = OnePageSite.new.generate

puts html
