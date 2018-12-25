require 'spec_helper'

require_relative '../lib/bannered_introduction'

describe BanneredIntroduction do
  it "makes a banner of span tags of alternating colors for a given input phrase of block words" do
    intro = BanneredIntroduction.new("Hi I'm Bobby")
    nodes = intro.banner_nodes
    nodes.each do |node|
      # each one gets a random of 2 real colors (1 isnt a real html color lol)
      expect(node.include?("style='color:")).to eq true
    end
  end
  it 'can customize the header size of the banner text'
  it 'randomizes the color of each letter based off the colors list'
  it 'composes an html document if not provided one'
  it 'adds to an html document if provided one'
end
