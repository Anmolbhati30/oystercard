require "oystercard"

RSpec.describe Oystercard do
  let(:journey_class) do
    class_double("Journey").tap do |double|
      stub_const("Journey", double, :transfer_nested_constants => true)
    end
  end

  it "Stubs Journey consts" do
    expect(journey_class::MIN_CHARGE).to eq Journey::MIN_CHARGE
  end
  # before(:each) do
  #   stub_const("Journey", journey_class, :transfer_nested_constants => true)
  # end
  # stub_const("Journey", journey_class, :transfer_nested_constants => true)

  # let(:subject) { described_class.new(journey_class) }

  let(:kings_cross) { instance_double(Station, :name => :kings_cross) }
  let(:victoria) { instance_double(Station, :name => :victoria) }

  let!(:complete_journey) {
    instance_double(Journey,
                    :entry_station => kings_cross,
                    :exit_station => victoria)
  }

  # before(:all) do
  #   allow(complete_journey).to receive_messages(finish: complete_journey)
  #   # let!(:complete_journey_class) { class_double(Journey, :new => complete_journey) }
  #   # let!(:station) { instance_double(Station, :zone => 1, id: :kings_cross)}
  # end
  describe "#initialize" do
    it "has an empty list of journeys" do
      expect(subject.instance_variable_get(:@journeys)).to eq []
    end
  end

  describe "#balance" do
    it "creates a new card with a balance of 0" do
      expect(subject.balance).to eq 0
    end
  end
  describe "#top_up" do
    it "allows topping up balance by integer amount given" do
      expect { subject.top_up(5) }.to change { subject.balance }.by (5)
    end
    it "allows topping up @balance by float amount given" do
      expect { subject.top_up(5.5) }.to change { subject.balance }.by (5.5)
    end
    it "prevents topping up if balance limit will be exceeded" do
      subject.top_up(described_class::BALANCE_LIMIT)
      message = "Sorry, you cannot exceed the balance limit of £" \
      "#{described_class::BALANCE_LIMIT}"
      expect { subject.top_up(1) }.to raise_error message
    end
    it "prevents topping up if amount not given" do
      message = "Please provide a valid amount"
      bad_amounts = ["five", 0, -2.5]
      bad_amounts.each do |amount|
        expect { subject.top_up(amount) }.to raise_error message
      end
    end
  end

  # it "doesn't allow the journey if balance lower than fare" do
  #   subject.top_up(3)
  #   message = "Sorry, your balance is not enough to cover the fare"
  #   expect { subject.deduct(3.50) }.to raise_error message
  # end

  describe "#touch_in" do
    context "when errors" do
      it "raises error when card with insufficient balance is touched in" do
        message = "Sorry, you don't have the minimum balance required of £" \
        "#{described_class::MIN_BALANCE}"
        expect { subject.touch_in(kings_cross) }.to raise_error message
      end

      # it "raises error when already in journey" do
      #   message = "You are already in a journey"

      #   subject.top_up(described_class::MIN_instance_variable_get(:@balance))
      #   subject.touch_in(kings_cross)

      #   expect { subject.touch_in(kings_cross) }.to raise_error message
      # end
    end

    context "when no errors" do
      before(:each) do
        subject.top_up(described_class::MIN_BALANCE)
        subject.touch_in(kings_cross)
      end

      it "updates oystercard to be in journey" do
        expect(subject).to be_in_journey
      end

      it "remembers entry station" do
        expect(subject.current_journey.entry_station).to eq kings_cross
      end
    end
  end

  describe "#touch_out" do
    # context "when errors" do
    #   it "raises error when not in journey" do
    #     message = "You are not in a journey"

    #     expect { subject.touch_out(victoria) }.to raise_error message
    #   end
    # end

    context "when no errors" do
      before(:each) do
        subject.top_up(described_class::MIN_BALANCE)
        subject.touch_in(kings_cross)
      end

      it "deducts fare from balance" do
        # stub_const("Journey", journey_class, :transfer_nested_constants => true)
        fare = journey_class::MIN_CHARGE
        expect { subject.touch_out(victoria) }.to change { subject.balance }.by(-fare)
      end

      it "stores the journey" do
        # subject = described_class.new(journey_class)
        allow(complete_journey).to receive_messages(finish: complete_journey)
        # p complete_journey.finish(kings_cross)
        previous_journey = subject.touch_out(victoria)
        returned_previous = subject.previous_journey
        p returned_previous
        expect(subject.previous_journey).to eq previous_journey
        expect(returned_previous.entry_station).to eq kings_cross
      end

      it "updates oystercard to not be in journey" do
        # subject = described_class.new(journey_class)
        subject.touch_out(victoria)
        expect(subject).not_to be_in_journey
      end
    end
  end
end
