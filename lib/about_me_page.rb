require_relative 'sandwich_buttons'
require_relative 'bannered_introduction'
require_relative 'html_document'

class AboutMePage
  attr_accessor :html, :colors, :header_size, :html_document, :about_me_nodes

  def initialize(phrase, header_size = 2)
    # i know light blue isnt a color to the browser in this string form, I just like it there
    @colors = ["red", "light blue", "orange"]
    @header_size = header_size
    html_document = HtmlDocument.new
    @about_me_nodes = [SandwichButtons.new.button_nodes + BanneredIntroduction.new(phrase).banner_nodes]
    html_document.add_nodes(SandwichButtons.new.button_nodes)
    html_document.add_nodes(BanneredIntroduction.new(phrase).banner_nodes)
    @html = html_document.body
  end
end
