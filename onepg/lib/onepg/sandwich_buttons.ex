defmodule Onepg.SandwichButtons do
  @button_nodes ["<button onclick=\"document.body.background = ''\">Sandwich Off</button>", "<button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n"]

  defstruct [html: Enum.join(@button_nodes, "\n"), nodes: @button_nodes]
end
