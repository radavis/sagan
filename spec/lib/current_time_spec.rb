RSpec.describe CurrentTime do
  subject { CurrentTime.new }

  it "sets the time zone to 'America/New_York'" do
    expect(subject.zone).to eq("America/New_York")
  end

  describe "private methods" do
    describe "#nine_am" do
      it "returns a Time object set to 9:00 AM" do
        nine_am = subject.send(:nine_am)
        expect(nine_am).to be_a(Time)
        expect(nine_am.to_s).to include("09:00:00")
      end
    end

    describe "#five_pm" do
      it "returns a Time object set to 5:00 PM" do
        five_pm = subject.send(:five_pm)
        expect(five_pm).to be_a(Time)
        expect(five_pm.to_s).to include("17:00:00")
      end
    end
  end

  describe "#working_hours?" do
    it "returns false in the eary morning" do
      allow(subject).to receive(:now) { Time.parse("8:30") }
      expect(subject.working_hours?).to eq(false)
    end

    it "returns true after 9 AM" do
      allow(subject).to receive(:now) { Time.parse("9:05 AM") }
      expect(subject.working_hours?).to eq(true)
    end

    it "returns true before 5 PM" do
      allow(subject).to receive(:now) { Time.parse("4:55 PM") }
      expect(subject.working_hours?).to eq(true)
    end

    it "returns false after 5 PM" do
      allow(subject).to receive(:now) { Time.parse("5:05 PM") }
      expect(subject.working_hours?).to eq(false)
    end
  end
end
