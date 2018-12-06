#!/bin/ruby
require 'pry'
require 'kramdown'

class OnePageSite
  def initialize(posts_directory = "/posts")
    @posts_directory = posts_directory
  end
  def generate
    puts full_page
    a = `ls posts`.split("\n").map { |post| post_to_html(post) }.join("#{'</br>' * 75}\n")
    b = full_page + "#{'</br>' * 75}" + a
    pbcopy b
    b
  end

  def full_page
    "#{base}"
  end

  def html_posts
    posts.map { |post| post_to_html(post) }
  end

  def post_to_html(post)
    html = Kramdown::Document.new(File.read("posts/#{post}")).to_html
    binding.pry
  end

  def posts
    `ls posts`.split("\n")
  end

  def base
    File.read("index.html")
  end

  def pbcopy(text)
    IO.popen('pbcopy', 'w') { |f| f << text }
  end
end

html = OnePageSite.new.generate

puts html
File.write("out.html", html)
