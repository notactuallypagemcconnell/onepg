defmodule OnepgEx.OnePageSite do
  @moduledoc """
  A module to create a one page website that has a brief introduction and some blog posts.

  Posts go in a `posts` directory and should be written in markdown.
  """

  @base_page %Onepg.HtmlDocument{}

  @doc """
  Generate a site for a given phrase and size of `h` tag.
  Returns a struct containing the nodes of HTML as well as body of the HTML document.

  site = OnepgEx.OnePageSite.create("Hi, I'm Bobby. I'm a software developer in New York", 2)
  # get the html
  IO.puts site.body
  """
  def create(about_me, twitter_handle, header_size \\ 2) do
    base = %Onepg.HtmlDocument{}
    nodes = OnepgEx.HtmlNodes.all(about_me, header_size)
    {:ok, page} = Onepg.HtmlDocument.add_nodes(base, nodes)
    page
  end

  def meta_create(about_me, twitter_handle \\ "@notactuallypagemcconnell", header_size \\ 2) do
    %{out: result} = Porcelain.shell("ruby ../lib/main.rb")
    IO.puts("File written by calling ruby from a Port in Elixir")
  end
end
