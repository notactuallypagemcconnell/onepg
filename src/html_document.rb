class HtmlDocument
  attr_reader :html_document, :nodes
  def initialize
    start_nodes = ["<!DOCTYPE html>", "<html>", "<head>", "<meta charset=\"UTF-8\">", "</head>"]
    start_nodes << html_close
    @nodes = start_nodes
    @html_document = @nodes.join("\n")
  end

  def add_node(new_node)
    @nodes.pop # remove html close node
    @nodes << new_node
    @nodes << html_close
  end

  def add_nodes(nodes)
    nodes.each { |node| add_node(node) }
    @html_document = @nodes.join
  end

  def html_close
    "</html>"
  end
end
