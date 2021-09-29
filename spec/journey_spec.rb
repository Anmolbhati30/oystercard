require "journey"
require "station"

describe Journey do
  let!(:kings_cross) { instance_double(Station, :zone => 1, name: "Kings Cross") }
  let!(:victoria) { instance_double(Station, :zone => 1, name: "Victoria") }
<<<<<<< HEAD
  
  describe "#start_at" do
    context "when valid journey" do 
      it "stores the entry station" do
        subject.start_at(kings_cross)
        expect(subject.start).to eq kings_cross
      end
    end 
  end

  describe "#end_at" do
    context "when valid journey" do
      it "stores the exit station" do
        expect(subject.finish_at(victoria)).to eq victoria
      end
    end
  end

  describe "#fare" do
    context "when invalid journey" do
      it "penalises if exiting without entering" do
        subject.finish_at(victoria)
        expect(subject.fare).to eq described_class::PENALTY_CHARGE
      end
=======
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
      expected_output = { start: kings_cross, finish: victoria }
      expect(subject.finish(victoria)).to eq expected_output
>>>>>>> bf3d88c9a87348a360e7be99d8b85bb475cdcd03
    end
  end

  describe "#create_record" do
    it "creates a journey record" do
<<<<<<< HEAD
      subject.start_at(kings_cross)
      subject.finish_at(victoria)
=======
      subject.enter_at(kings_cross)
      subject.exit_at(victoria)
>>>>>>> bf3d88c9a87348a360e7be99d8b85bb475cdcd03
      expected_journey = { start: kings_cross, finish: victoria }
      expect(subject.create_record).to eq expected_journey
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
          subject.enter_at(kings_cross)
          expect(subject.fare).to eq described_class::PENALTY_CHARGE
        end
      end

      context "and exit station" do
        it "returns minimum fare" do
          subject.enter_at(kings_cross)
          subject.exit_at(victoria)
          expect(subject.fare).to eq described_class::MIN_CHARGE
        end
      end
    end
  end
end
