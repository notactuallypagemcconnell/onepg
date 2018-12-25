class BlogPost
  attr_accessor :blog_nodes, :markdown, :html_nodes

  def initialize(post_file)
    # these dont have nodes because they generate the HTML and we dont control it
    # so we treat each one as one giant node even though its made of more real
    # html nodes
    @markdown = File.read("posts/#{post_file}")
    @html_nodes = [html]
  end

  def html
   "#{'</br>' * 100}" + RDiscount.new(markdown).to_html
  end
end
