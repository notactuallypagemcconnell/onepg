defmodule OnepgTest do
  use ExUnit.Case
  doctest Onepg


  test "greets the world" do
    assert Onepg.hello() == :world
  end

  test "can add single nodes" do
    base = ["<!DOCTYPE html>", "<html>", "<head>", "<meta charset=\"UTF-8\">", "</head>", "</html>"]
    result = Onepg.HtmlDocument.add_node(base, "<div>foo</div>")
    assert [_doctype, _html_open, _head_open, _meta, _head_close, "<div>foo</div>", _html_close] = result.nodes
    assert result.body == "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"UTF-8\">\n</head>\n<div>foo</div>\n</html>"
  end

  test "can add many nodes" do
    base = ["<!DOCTYPE html>", "<html>", "<head>", "<meta charset=\"UTF-8\">", "</head>", "</html>"]
    result = Onepg.HtmlDocument.add_nodes(base, ["<div>foo</div>", "<div>bar</div>"])
    assert [_doctype, _html_open, _head_open, _meta, _head_close, "<div>foo</div>", "<div>bar</div>", _html_close] = result.nodes
    assert result.body == "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"UTF-8\">\n</head>\n<div>foo</div>\n<div>bar</div>\n</html>"
  end

  test "sandwich buttons" do
    %Onepg.SandwichButtons{nodes: [off_button, on_button], html: html} = %Onepg.SandwichButtons{}
    assert off_button == "<button onclick=\"document.body.background = ''\">Sandwich Off</button>"
    assert on_button == "<button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n"
  end
end
