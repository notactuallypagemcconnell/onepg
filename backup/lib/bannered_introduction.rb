class BanneredIntroduction
  attr_reader :words, :banner_nodes, :colors

  def initialize(words)
    @words = words.split(" ")
    @colors = ["red", "light blue", "orange"]
    create_headered_span_words
  end

  def create_headered_span_words(header_size = 2)
    nodes = words.map do |word|
      chars         = word.split("")
      spans         = chars.map.with_index { |char, i| span_for_character(char, chars, i) }.join
      headered_span = "<h#{header_size}>#{spans}</h#{header_size}>"
    end

    @banner_nodes = nodes
  end

  def span_for_character(char, chars, index)
    if index == chars.length - 1
      "<span style='color: #{colors.sample}'>#{char}</br></span>\n"
    else
      "<span style='color: #{colors.sample}'>#{char}</span>\n"
    end
  end
end
