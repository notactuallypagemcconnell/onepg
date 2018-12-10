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
  def create(phrase, header_size \\ 2) do
    result = OnepgEx.AboutMePage.create("Hi I'm bobby I'm a software developer in New York")
    blogs = OnepgEx.BlogPost.all()
    base = %Onepg.HtmlDocument{}
    {:ok, page} = Onepg.HtmlDocument.add_nodes(base, result ++ blogs)
    page
  end
end
