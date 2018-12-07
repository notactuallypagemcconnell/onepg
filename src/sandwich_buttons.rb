class SandwichButtons
  attr_reader :buttons, :buttons_html

  def initialize
    @buttons = ["<button onclick=\"document.body.background = ''\">Sandwich Off</button>", "<button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n"]
    @buttons_html = @buttons.join
  end
end

