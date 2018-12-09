# app = proc do |env|
#   resp = File.read("index.html")
#   page = `ruby ../lib/main.rb`
#   [200, {"Content-Type" => "text/html"}, [resp]]
# end

# run app

require 'rack'

class App
  def call(env)
    request = Rack::Request.new(env)
    headers = { 'Content-Type' => 'text/html' }

    case request.path
    when '/'
      # we assemble the page fresh every time a request comes just for shits and giggles
      [200, headers, [`ruby ../lib/main.rb`]]
    when '/bezier'
      [200, headers, [File.read("bezier.html")]]
    when '/bartlebee'
      [200, headers, [`ruby text_poster.rb`]]
    else
      [404, headers, ["Uh oh, path not found!"]]
    end
  end
end
app = App.new
run app
