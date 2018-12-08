app = proc do |env|
  resp = File.read("index.html")
  [200, {"Content-Type" => "text/html"}, [resp]]
end

run app
