defmodule OnepgEx.Main do
  def main(args \\ []) do
    Application.start(:porcelain)
    OnepgEx.OnePageSite.meta_create("", "", 2)
  end
end

OnepgEx.Main.main
