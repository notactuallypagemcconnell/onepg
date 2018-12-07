require_relative 'sandwich_buttons'
require_relative 'bannered_introduction'
class AboutMePage
  # this however, not so much.
  attr_reader :html, :colors, :header_size

  def initialize(phrase, header_size = 2)
    # i know light blue isnt a color to the browser in this string form, I just like it there
    @colors = ["red", "light blue", "orange"]
    @header_size = header_size
    headered_span_words = create_headered_span_words(phrase)
    about_me_page_that_needs_closing_html_and_body_tags = base_doc + buttons + "<div>" + headered_span_words + "</div>"
    @html = about_me_page_that_needs_closing_html_and_body_tags
  end

  def create_headered_span_words(words)
    BanneredIntroduction.new(words).banner_html
  end

  def base_doc
    HtmlDocument.new.html_document
  end

  def buttons
    SandwichButtons.new.buttons_html
  end
end
