defmodule OnepgEx.AboutMePage do
  @moduledoc """
  The container for your about me banner
  """

  @colors ["red", "light blue", "orange"]

  defstruct html: "", colors: @colors, header_size: 2, nodes: []

  def create(phrase, header_size \\ 2) do
    html_document = %Onepg.HtmlDocument{}
    buttons = OnepgEx.SandwichButtons.buttons().button_nodes
    header = OnepgEx.BanneredIntroduction.create_headered_span_words(phrase, 2).nodes
    buttons ++ header
  end
end
