require 'spec_helper'
require_relative '../lib/html_document'

describe HtmlDocument do
  context "as a string" do
    it 'has a series of string nodes' do
      doc = HtmlDocument.new

      expect(doc.nodes.first).to eq "<!DOCTYPE html>"
      # the defaults, just html/open close and the essentialsd
      expect(doc.nodes.count).to eq 6
      expect(doc.nodes.last).to eq "</html>"
    end

    it 'updates the document as a whole when nodes as added' do
      doc = HtmlDocument.new
      doc.add_nodes(["<div>hey</div>", "<div>there</div>"])
      expect(doc.body.include?("hey")).to eq true
      expect(doc.body.include?("there")).to eq true
    end
  end

  context "as a series of nodes" do
    it "can add a node to the list of nodes" do
      doc = HtmlDocument.new
      doc.add_node("<div>hey</div>")
      expect(doc.nodes.include?("<div>hey</div>")).to eq true
    end

    it "can add several nodes to the list of nodes" do
      doc = HtmlDocument.new
      doc.add_nodes(["<div>hey</div>", "<div>there</div>"])

      expect(doc.nodes.include?("<div>hey</div>")).to eq true
      expect(doc.nodes.include?("<div>there</div>")).to eq true
    end
  end
end
