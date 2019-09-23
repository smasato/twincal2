#! /usr/bin/ruby
# coding: utf-8

require_relative '../functions.rb'

describe "CONFIG" do
  describe "TERM" do
    it { expect(TERM_BEGIN["春"]["A"]).to be < TERM_BEGIN["春"]["B"] }
    it { expect(TERM_BEGIN["春"]["B"]).to be < TERM_BEGIN["春"]["C"] }
    it { expect(TERM_BEGIN["春"]["C"]).to be < TERM_BEGIN["夏"] }
    it { expect(TERM_BEGIN["夏"]).to be < TERM_BEGIN["秋"]["A"] }
    it { expect(TERM_BEGIN["秋"]["A"]).to be < TERM_BEGIN["秋"]["B"] }
    it { expect(TERM_BEGIN["秋"]["B"]).to be < TERM_BEGIN["秋"]["C"] }
  end
end
