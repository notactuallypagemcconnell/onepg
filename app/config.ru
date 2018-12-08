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
      [200, headers, [File.read("index.html")]]
    when '/bezier'
      [200, headers, [File.read("bezier.html")]]
    else
      [404, headers, ["Uh oh, path not found!"]]
    end
  end
end
app = App.new
run app
