require "journey"

describe Journey do
  let!(:kings_cross) { instance_double(Station, :zone => 1, name: "Kings Cross") }
  let!(:victoria) { instance_double(Station, :zone => 1, name: "Victoria") }
  describe "#enter_at" do
    it "stores an entry station" do
      subject.enter_at(kings_cross)
      expect(subject.entry_station).to eq kings_cross
    end
  end
  describe "#exit_at" do
    it "stores an exit station" do
      subject.exit_at(victoria)
      expect(subject.exit_station).to eq victoria
    end
  end
  describe "#create_record" do
    it "creates a journey record" do
      subject.enter_at(kings_cross)
      subject.exit_at(victoria)
      expected_journey = { entry: kings_cross, exit: victoria }
      expect(subject.create_record).to eq expected_journey
    end
  end
end
