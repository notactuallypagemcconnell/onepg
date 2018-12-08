require 'rdiscount'

require_relative 'blog_post'
require_relative 'about_me_page'

class OnePageSite
  attr_reader :intro
  attr_accessor :html_document

  def initialize(intro, posts_directory = "/posts")
    @intro = intro
    @posts_directory = posts_directory
  end
  def generate
    # TODO this is where we really wanna start adding more nodes to the document as blog posts...
    post_html = `ls posts`.split("\n").map { |post| post_to_html(post) }.join("#{'</br>' * 75}\n")
    html_document = about_me.html + "#{'</br>' * 75}" + post_html + "</body>\n</html>"
    copy_to_clipboard(html_document)
    html_document
  end

  def copy_to_clipboard(document)
    pbcopy document
  end

  def post_to_html(post)
    BlogPost.new(post).html
  end

  def posts
    `ls posts`.split("\n")
  end

  def about_me
    AboutMePage.new(intro)
  end

  def pbcopy(text)
    IO.popen('pbcopy', 'w') { |f| f << text }
  end
end
