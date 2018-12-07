#!/bin/ruby
require 'pry'
require 'kramdown'

class OnePageSite
  # I feel like this is reasonable enough for now
  def initialize(posts_directory = "/posts")
    @posts_directory = posts_directory
  end
  def generate
    post_html = `ls posts`.split("\n").map { |post| post_to_html(post) }.join("#{'</br>' * 75}\n")
    html_document = base + "#{'</br>' * 75}" + post_html + "</body>\n</html>"
    copy_to_clipboard(html_document)
    puts html_document
    html_document
  end

  def copy_to_clipboard(document)
    pbcopy document
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
    AboutMePage.new("Hi I'm Bobby. I'm a programmer in New York").html
  end

  def pbcopy(text)
    IO.popen('pbcopy', 'w') { |f| f << text }
  end
end

class AboutMePage
  # this however, not so much.
  attr_reader :html

  def initialize(phrase, header_size = 2)
    words = phrase.split(" ")
    tags = words.map do |word|
      colors = ["red", "light blue", "orange"] # i know light blue isnt a color to the browser in this string form, I just like it there
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
      a
    end
    a = base_doc + buttons + "<div>" + tags.join + "</div>"
    @html = a
  end

  def base_doc
    "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"UTF-8\"\n</head>"
  end

  def buttons
    "<button onclick=\"document.body.background = ''\">Sandwich Off</button><button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n"
  end
end

OnePageSite.new.generate
