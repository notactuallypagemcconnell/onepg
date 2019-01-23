class HtmlDocument
  attr_reader :body, :nodes
  def initialize
    start_nodes = ["<!DOCTYPE html>",
                   "<html>",
                   "<head>",
                   "<meta charset=\"UTF-8\">",
                   "</head>",
                   '<script src="https://unpkg.com/react@16/umd/react.development.js" crossorigin></script>',
                   '<script src="https://unpkg.com/react-dom@16/umd/react-dom.development.js" crossorigin></script>',
                   '<!-- Load our React component. -->',
                   '<script src="like_button.js"></script>']
    start_nodes << html_close
    @nodes = start_nodes
    @body = @nodes.join("\n")
  end

  def add_node(new_node)
    @nodes.pop # remove html close node
    @nodes << new_node
    @nodes << html_close
  end

  def add_nodes(nodes)
    nodes.each { |node| add_node(node) }
    @body = @nodes.join
  end

  def html_close
    "</html>"
  end

  def bezier
    File.read("bezier.html")
  end
end
