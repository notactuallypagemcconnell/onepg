defmodule OnepgEx.SandwichButtons do
  @moduledoc """
  Buttons for turning the sandwich background on and off. Essential.
  """
  @button_nodes [
    "<button onclick=\"document.body.background = ''\">Sandwich Off</button>",
    "<button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n"
  ]

  defstruct button_nodes: @button_nodes,
            html_document: %Onepg.HtmlDocument{
              nodes: @button_nodes,
              body: Enum.join(@button_nodes, "\n")
            }

  def buttons do
    %__MODULE__{}
  end
end
