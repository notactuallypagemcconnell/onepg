defmodule OnepgEx.HtmlNodes do
  @colors ["red", "light blue", "orange"]

  def all(greeting, twitter_handle, header_size \\ 2) do
    sandwich_buttons ++ create_banner(greeting, header_size) ++ twitter_handle(twitter_handle) ++ blog
    require IEx; IEx.pry
  end

  def sandwich_buttons do
    [
      "<button onclick=\"document.body.background = ''\">Sandwich Off</button>",
      "<button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n"
    ]
  end

  def twitter_handle(handle) do
    ["<h3><a href='https://twitter.com/#{handle}</h3>"]
  end

  def about(words, header_size \\ 2) do
    create_banner(words, header_size)
  end

  def blog do
    {:ok, files} = File.ls("posts")
    files 
    |> Enum.reject(&filter_swapfiles/1)
    |> Enum.map(&create_blog_post/1)
  end

  defp create_banner(words, header_size) do
    nodes = get_nodes(words, header_size)
    nodes
  end

  defp get_nodes(words, header_size) do
    words
    |> String.split(" ")
    |> Enum.map(fn word ->
      chars = String.split(word, "")
      spans = spans_for_words(chars)

      "<h#{header_size}>#{spans}</h#{Integer.to_string(header_size)}>"
    end)
  end

  defp spans_for_words(chars) do
    chars
    |> Enum.with_index()
    |> Enum.map(fn {char, i} ->
      span_for_character(char, chars, i)
    end)
  end

  defp span_for_character(char, chars, index) do
    [color, _, _] = Enum.shuffle(@colors)
    is_last = index == Enum.count(chars) - 1
    char_is_last(is_last, char, color)
  end

  defp char_is_last(true, char, color), do:
    "<span style='color: #{color}'>#{char}</br></span>\n"

  defp char_is_last(false, char, color), do:
    "<span style='color: #{color}'>#{char}</span>\n"

  defp filter_swapfiles(file), do:
    should_filter_swapfile(file)

  def should_filter_swapfile("." <> rest), do:
    true

  def should_filter_swapfile(_), do:
    false

  defp create_blog_post(file) do
    md = File.read!("posts/#{file}")
    {:ok, html, _} = Earmark.as_html(md)
    "</br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br>" <> html
  end
end
