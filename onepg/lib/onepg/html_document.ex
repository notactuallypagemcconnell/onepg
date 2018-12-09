defmodule Onepg.HtmlDocument do
  @base_nodes ["<!DOCTYPE html>", "<html>", "<head>", "<meta charset=\"UTF-8\">", "</head>", "</html>"]

  defstruct [body: Enum.join(@base_nodes, ""), nodes: @base_nodes]

  def add_node(nodes, node) when is_list(nodes) and is_binary(node) do
    {html_close, nodes} = List.pop_at(nodes, -1)
    nodes = nodes ++ [node] ++ [html_close]
    body = Enum.join(nodes, "\n")
    %__MODULE__{body: body, nodes: nodes}
  end

  def add_nodes(existing_nodes, nodes_to_add) when is_list(existing_nodes) and is_list(nodes_to_add) do
    [html_close | existing_tags] = Enum.reverse(existing_nodes)
    tags_without_close = Enum.reverse(existing_tags)
    nodes = tags_without_close ++ nodes_to_add ++ [html_close]
    %__MODULE__{nodes: nodes, body: Enum.join(nodes, "\n")}
  end
end
