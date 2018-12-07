class HtmlDocument
  attr_reader :html_document, :nodes
  def initialize
    base_doc = "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"UTF-8\">\n</head>"
    @html_document = base_doc
    @nodes = []
  end
end
