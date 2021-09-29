require "journeylog"

describe JourneyLog do
  describe "#initialize" do
    it "initializes with a journey class parameter" do
      expect(subject.journey_class.new.class).to eq Journey
    end
  end
end