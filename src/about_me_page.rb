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
    HtmlDocument.new.html_document
  end

  def buttons
    "<button onclick=\"document.body.background = ''\">Sandwich Off</button><button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n"
  end
end

class HtmlDocument
  attr_reader :html_document, :nodes
  def initialize
    base_doc = "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"UTF-8\">\n</head>"
    @html_document = base_doc
    @nodes = []
  end
end

class BanneredIntroduction
end

class BlogSection
end
