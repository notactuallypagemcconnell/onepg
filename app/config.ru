app = proc do |env|
  resp = File.read("index.html")
  page = `ruby ../lib/main.rb`
  [200, {"Content-Type" => "text/html"}, [resp]]
end

run app
