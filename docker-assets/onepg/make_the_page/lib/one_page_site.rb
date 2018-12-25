require 'rdiscount'

require_relative 'blog_post'
require_relative 'about_me_page'
require_relative 'bezier'

class OnePageSite
  attr_reader :intro
  attr_accessor :html_document

  def initialize(intro, posts_directory = "/posts")
    @intro = intro
    @posts_directory = posts_directory
  end

  def generate
    document = HtmlDocument.new
    bezier = Bezier.new
    document.add_node(bezier.bezier_node)
    document.add_node(bezier.off_button)
    document.add_node("<a href='http://computering.info'>Learn to code</a>")
    document.add_node("<div style='display: flex'>")
    document.add_node("<span id='farts'>")
    document.add_nodes(about_me.about_me_nodes)
    document.add_node("</span>")
    document.add_node("<canvas id='myCanvas'></canvas>")
    document.add_node("</div>")
    blog_posts = `ls posts`
                   .split("\n")
                   .map { |post| BlogPost.new(post) }
                   .map do |post| 
                     document.add_nodes(post.html_nodes)
                   end
    @html_document = document
    File.write("index.html", document.body)
    copy_to_clipboard(document.body)
  end

  def copy_to_clipboard(document)
    pbcopy document
  end

  def post_to_html(post)
    BlogPost.new(post)
  end

  def posts
    `ls posts`.split("\n")
  end

  def about_me
    AboutMePage.new(intro)
  end

  def pbcopy(text)
    IO.popen('pbcopy', 'w') { |f| f << text }
    puts text
  end
end
