require "oystercard"

describe Oystercard do
  describe "#balance" do
    it "creates a new card with a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end
  describe "#top_up" do
    it "allows topping up balance by amount given" do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end
    it "prevents topping up if amount not given" do
      message = "Please provide a valid amount"
      expect { subject.top_up("five") }.to raise_error message
    end
  end
end

# NameError without Oystercard class
# Error occurred at ./spec/oystercard_spec.rb
# Error occurred at line 1
# NameError: Raised when a given name is invalid or undefined.
# Error can be solved by creating a class called Oystercard
