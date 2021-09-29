require "journey"
require "station"

describe Journey do
  let!(:kings_cross) { instance_double(Station, :zone => 1, name: "Kings Cross") }
  let!(:victoria) { instance_double(Station, :zone => 1, name: "Victoria") }
  let!(:start_at_kings) {described_class.new(kings_cross)}
  describe "#initialize" do
    it "defaults entry station to nil" do
      expect(subject.entry_station).to eq nil
    end
    it "takes an entry station" do
      subject = described_class.new(kings_cross)
      expect(subject.entry_station).to eq kings_cross
    end
  end
  describe "#finish" do
    it "finishes a journey at given station" do
      expect(subject.finish(victoria)).to eq subject
    end
  end

 

  describe "#fare" do
    context "if no entry station" do
      it "returns penalty charge" do
        expect(subject.fare).to eq described_class::PENALTY_CHARGE
      end
    end
    context "if entry station" do
      context "and no exit station" do
        it "returns penalty charge" do
          expect(start_at_kings.fare).to eq described_class::PENALTY_CHARGE
        end
      end

      context "and exit station" do
        it "returns minimum fare" do
          full_journey = described_class.new(kings_cross).finish(victoria)
          expect(full_journey.fare).to eq described_class::MIN_CHARGE
        end
      end
    end
  end
end
