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
    Kramdown::Document.new(File.read("posts/#{post}")).to_html
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

class BasePageBuilder
  def initialize(phrase, header_size = 2)
    words = phrase.split(" ")
    tags = words.map do |word|
      colors = ["red", "blue", "green"]
      chars = word.split("")
      result =
        chars.map.with_index do |char, i|
          if i == chars.length - 1
            # add a space if its the end of the word for the next one
            "<span style='color: #{colors.sample}'>#{char}</br></span>\n"
          else
            "<span style='color: #{colors.sample}'>#{char}</span>\n"
          end
        end.join
      a = "<h#{header_size}>#{result}</h#{header_size}>"
      binding.pry
      a
    end
  end

  def to_colored_banner
  end
end
# a = BasePageBuilder.new("I'm Bobby")
# b = BasePageBuilder.new("I'm a programmer in New York")
# binding.pry
html = OnePageSite.new.generate
 
puts html
File.write("out.html", html)

