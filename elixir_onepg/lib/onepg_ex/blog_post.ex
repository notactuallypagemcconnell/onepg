defmodule OnepgEx.BlogPost do

  def all do
    {:ok, files} = File.ls("posts")
    html_docs =
      Enum.reject(files, fn(file) ->
        case file do
          "." <> _ -> true
          _ -> false
        end
      end)
      |> Enum.map(fn(file) ->
           md = File.read!("posts/#{file}")
           {:ok, html, _} = Earmark.as_html(md)
           html <> "</br></br></br></br></br></br></br></br></br></br></br></br>"
         end)
  end
end
