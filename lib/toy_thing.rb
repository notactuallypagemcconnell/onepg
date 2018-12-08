class ToyThing
  attr_accessor :toy_nodes
  TOYS = [
    {link: "bezier.html", name: "Bezier Curve Weird Fun"}
  ]
  def initialize
    @toy_nodes = TOYS.map do |toy|
                   link = toy[:link]
                   name = toy[:name]
                   ["</br></br></br></br></br></br></br>", "<div>", "<a href=\"#{link}\">#{name}</a>", "</div>"]
                 end
  end
end
