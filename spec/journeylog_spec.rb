require "journeylog"
require "journey"

describe JourneyLog do
  let!(:kings_cross) { instance_double(Station, :name => :kings_cross) }
  let!(:victoria) { instance_double(Station, :name => :victoria) }
  describe "#initialize" do
    it "initializes with a journey class parameter" do
      expect(subject.instance_variable_get(:@journey_class).new).to be_a Journey
    end

    it "has no journeys to begin with" do
      expect(subject.journeys).to be_empty
    end
  end

  describe "#start" do
    it "starts a new journey with a given entry station" do
      subject.start(kings_cross)
      new_journey = subject.instance_variable_get(:@current_journey)
      expect(new_journey.entry_station).to eq kings_cross
    end
  end

  describe "#finish" do
    it "records the finished journey" do
      subject.start(kings_cross)
      subject.finish(victoria)
      finished_journey = subject.(:@current_journey).finish(victoria)
      expect(subject.journeys).to include finished_journey
    end

    it "returns the journeys fare" do
      subject.start(kings_cross)
      finished_journey = subject.instance_variable_get(:@current_journey).finish(victoria)
      expect(subject.finish(victoria)).to eq finished_journey.fare
    end
  end
end
