# OnepgEx

Make a single page index.html style site from some basic info: a greeting and some blog posts.

```
iex -S mix
IO.puts OnepgEx.OnePageSite.create("Hi I'm bobby, a developer in New York", 2).body # 2nd arg is header size of the banner it makes
# now copy it to the clipboard and paste it into whatever.
