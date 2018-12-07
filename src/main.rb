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
  attr_reader :html, :colors, :header_size

  def initialize(phrase, header_size = 2)
    # i know light blue isnt a color to the browser in this string form, I just like it there
    @colors = ["red", "light blue", "orange"]
    @header_size = header_size
    words = phrase.split(" ")
    headered_span_words = create_headered_span_words(words)
    about_me_page_that_needs_closing_html_and_body_tags = base_doc + buttons + "<div>" + headered_span_words + "</div>"
    # simple api, documenting by name. so clever. lol
    @html = about_me_page_that_needs_closing_html_and_body_tags
  end

  def create_headered_span_words(words)
    words.map do |word|
      chars         = word.split("")
      spans         = chars.map.with_index { |char, i| span_for_character(char, chars, i) }.join
      headered_span = "<h#{header_size}>#{spans}</h#{header_size}>"
    end.join
  end

  def span_for_character(char, chars, index)
    if index == chars.length - 1
      # add a break if its the end of the word for the next one
      "<span style='color: #{colors.sample}'>#{char}</br></span>\n"
    else
      "<span style='color: #{colors.sample}'>#{char}</span>\n"
    end
  end

  def base_doc
    "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"UTF-8\"\n</head>"
  end

  def buttons
    "<button onclick=\"document.body.background = ''\">Sandwich Off</button><button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n"
  end
end

OnePageSite.new.generate
