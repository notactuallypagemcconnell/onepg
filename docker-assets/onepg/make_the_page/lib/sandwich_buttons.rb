require_relative 'html_document'

class SandwichButtons
  attr_reader :button_nodes, :buttons_html, :html_document

  def initialize(document = HtmlDocument.new)
    @html_document = document
    @button_nodes = [
       "<button onclick=\"document.body.background = ''\">Sandwich Off</button>\n",
       "<button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n"
      ]

    @html_document.add_nodes(button_nodes)
    @buttons_html = @button_nodes.join
  end
end

