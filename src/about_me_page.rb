require_relative 'sandwich_buttons'
require_relative 'bannered_introduction'
require_relative 'html_document'

class AboutMePage
  attr_reader :html, :colors, :header_size

  def initialize(phrase, header_size = 2)
    # i know light blue isnt a color to the browser in this string form, I just like it there
    @colors = ["red", "light blue", "orange"]
    @header_size = header_size
    @document = HtmlDocument.new
    @document.add_nodes(SandwichButtons.new.buttons)
    @document.add_nodes(BanneredIntroduction.new(phrase).banner_nodes)
    @html = @document.html_document
  end
end
