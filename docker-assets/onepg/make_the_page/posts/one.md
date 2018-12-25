# Let's make a Personal Page + Blog Generator

## The Motivation
When I got this sick domain with this sick free shared hosting, I needed to have a site I could paste into an index.html doc on Cpanel.
I began on a journey to build the most ~~complex~~ awesome tool possible to do this.
The end product: an executable that spins up a docker container that runs an elixir executable whose code opens a Port to use the BEAM to run the ruby script that writes out index.html and also get it set to a var for use in the elixir app.
This is utterly reasonable.

Let's start by designing the Ruby portion.
We can begin with an html document

```
class HtmlDocument
  attr_reader :body, :nodes
  def initialize
    start_nodes = ["<!DOCTYPE html>", "<html>", "<head>", "<meta charset=\"UTF-8\">", "</head>"]
    start_nodes << html_close
    @nodes = start_nodes
    @body = @nodes.join("\n")
  end

  def add_node(new_node)
    @nodes.pop # remove html close node
    @nodes << new_node
    @nodes << html_close
  end

  def add_nodes(nodes)
    nodes.each { |node| add_node(node) }
    @body = @nodes.join
  end

  def html_close
    "</html>"
  end
end
```

If we break this down the main idea is treating an html document as a list of string elements.
In a perfect world we would check them and parse/validate their form etc but we dont care for this.
We begin with a sane base document and add things by removing our closing `html` tag and then re-appending it.
We have a `body` which is the string that is the document itself, too.

Now, if we have a basic page, for our sick page + blog we will need an about me blurb.
A simple example start:


```
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
```

Here, we create an `<h>` tag of a given side with randomly chosen coloring and break them up per-word in the sentence given in.
Now that we have a great banner, we can move onto a full about me solution.
