defmodule OnepgEx.OnePageSite do
  @base_page %Onepg.HtmlDocument{}

  def create(phrase, header_size \\ 2) do
    result = OnepgEx.AboutMePage.create("Hi I'm bobby I'm a software developer in New York")
    blogs = OnepgEx.BlogPost.all
    base = %Onepg.HtmlDocument{}
    {:ok, page} = Onepg.HtmlDocument.add_nodes(base, result ++ blogs)
    page.body
  end
end
