require 'pry'
require 'spec_helper'
require_relative '../lib/sandwich_buttons'

describe SandwichButtons do
  let(:buttons) { SandwichButtons.new }
  it 'has the buttons raw nodes' do
    nodes = buttons.button_nodes
    expect(buttons.button_nodes.count).to eq 2
    buttons.button_nodes.each do |node|
      expect(node.is_a?(String)).to eq true
      expect(node.include?("document.body.background")).to eq true
    end
  end

s it 'assembles an html document with the buttons if one isnt provided' do
    document = buttons.html_document
    expected = "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"></head><button onclick=\"document.body.background = ''\">Sandwich Off</button><button onclick=\"document.body.background = 'sandwich.jpg'\">Sandwich On</button>\n</html>"
    expect(document.body).to eq expected
  end
end
