require 'rdiscount'

require_relative 'blog_post'
require_relative 'about_me_page'
require_relative 'toy_thing'

class OnePageSite
  attr_reader :intro
  attr_accessor :html_document

  def initialize(intro, posts_directory = "/posts")
    @intro = intro
    @posts_directory = posts_directory
  end

  def generate
    document = HtmlDocument.new
    document.add_nodes(about_me.about_me_nodes)
    document.add_nodes(ToyThing.new.toy_nodes)
    blog_posts = `ls posts`
                   .split("\n")
                   .map { |post| BlogPost.new(post) }
                   .map do |post| 
                     document.add_nodes(post.html_nodes)
                   end
    @html_document = document
    copy_to_clipboard(document.body)
    puts @html_document.body
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
  end
end
