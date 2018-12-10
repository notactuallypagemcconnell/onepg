defmodule Onepg.HtmlDocument do
  @moduledoc """
  Our generic representation of an HTML document using a linked list
  """

  @base_document [
    "<!DOCTYPE html>",
    "<html>",
    "<head>",
    "<meta charset=\"UTF-8\">",
    "</head>",
    "</html>"
  ]

  defstruct body: Enum.join(@base_document, "\n"), nodes: @base_document

  def add_node(%Onepg.HtmlDocument{nodes: current_nodes, body: _body}, node)
      when is_binary(node) and is_list(current_nodes) do
    [html_close | rest] = Enum.reverse(current_nodes)
    nodes = Enum.reverse(rest) ++ [node] ++ [html_close]
    html = Enum.join(nodes, "\n")
    doc = %__MODULE__{body: html, nodes: nodes}
    {:ok, doc}
  end

  def add_nodes(%__MODULE__{body: _old_html, nodes: nodes}, new_nodes)
      when is_list(new_nodes) and is_list(nodes) do
    [html_close | rest] = Enum.reverse(nodes)
    final_nodes = Enum.reverse(rest) ++ new_nodes ++ [html_close]
    html = Enum.join(final_nodes, "\n")
    doc = %__MODULE__{nodes: final_nodes, body: html}
    {:ok, doc}
  end
end
