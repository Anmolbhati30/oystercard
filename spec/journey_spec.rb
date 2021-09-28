require "journey"

describe Journey do
  let!(:kings_cross) { instance_double(Station, :zone => 1, name: "Kings Cross") }
  let!(:victoria) { instance_double(Station, :zone => 1, name: "Victoria") }
  
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
    end
  end

  describe "#create_record" do
    it "creates a journey record" do
      subject.start_at(kings_cross)
      subject.finish_at(victoria)
      expected_journey = { start: kings_cross, finish: victoria }
      expect(subject.create_record).to eq expected_journey
    end
  end
end
