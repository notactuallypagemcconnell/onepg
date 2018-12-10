defmodule OnepgEx.BanneredIntroduction do
  defstruct nodes: [], body: "", words: []

  @colors ["red", "light blue", "orange"]

  def create_headered_span_words(words, header_size) do
    nodes =
      words
      |> String.split(" ")
      |> Enum.map(fn word ->
        chars = String.split(word, "")
        spans = spans_for_words(chars)

        "<h#{header_size}>#{spans}</h#{Integer.to_string(header_size)}>"
      end)

    html = Enum.join(nodes, "\n")
    %Onepg.HtmlDocument{body: html, nodes: nodes}
  end

  def spans_for_words(chars) do
    chars
    |> Enum.with_index()
    |> Enum.map(fn {char, i} ->
      span_for_character(char, chars, i)
    end)
  end

  def span_for_character(char, chars, index) do
    [color, _, _] = Enum.shuffle(@colors)
    is_last = index == Enum.count(chars) - 1

    case is_last do
      true -> "<span style='color: #{color}'>#{char}</br></span>\n"
      false -> "<span style='color: #{color}'>#{char}</span>\n"
    end
  end
end
