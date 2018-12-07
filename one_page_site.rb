require 'redcarpet'
require 'rdiscount'

require_relative 'about_me_page'

class OnePageSite
  # I feel like this is reasonable enough for now
  def initialize(posts_directory = "/posts")
    @posts_directory = posts_directory
  end
  def generate
    post_html = `ls posts`.split("\n").map { |post| post_to_html(post) }.join("#{'</br>' * 75}\n")
    html_document = base + "#{'</br>' * 75}" + post_html + "</body>\n</html>"
    copy_to_clipboard(html_document)
    puts html_document
    html_document
  end

  def copy_to_clipboard(document)
    pbcopy document
  end

  def html_posts
    posts.map { |post| post_to_html(post) }
  end

  def post_to_html(post)
    markdown = File.read("posts/#{post}")
    # binding.pry
    # Kramdown::Document.new(File.read("posts/#{post}")).to_html
    # Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(File.read("posts/#{post}"))
    RDiscount.new(markdown).to_html
  end

  def posts
    `ls posts`.split("\n")
  end

  def base
    AboutMePage.new("Hi I'm Bobby. I'm a programmer in New York").html
  end

  def pbcopy(text)
    IO.popen('pbcopy', 'w') { |f| f << text }
  end
end


