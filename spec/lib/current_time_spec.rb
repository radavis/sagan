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
    it "returns false in the early morning" do
      eight_am_monday = "2017-05-29 8:00:00 -0400"  # time.to_s
      allow(subject).to receive(:now) { Time.parse(eight_am_monday) }
      expect(subject.working_hours?).to eq(false)
    end

    it "returns true after 9 AM" do
      nine_am_monday = "2017-05-29 9:05:00 -0400"
      allow(subject).to receive(:now) { Time.parse(nine_am_monday) }
      expect(subject.working_hours?).to eq(true)
    end

    it "returns true before 5 PM" do
      almost_five_pm = "2017-05-29 16:55:00 -0400"
      allow(subject).to receive(:now) { Time.parse(almost_five_pm) }
      expect(subject.working_hours?).to eq(true)
    end

    it "returns false after 5 PM" do
      after_five_pm = "2017-05-29 17:05:00 -0400"
      allow(subject).to receive(:now) { Time.parse(after_five_pm) }
      expect(subject.working_hours?).to eq(false)
    end

    it "returns false if day is Saturday" do
      saturday = "2017-06-03 12:00:00 -0400"
      allow(subject).to receive(:now) { Time.parse(saturday) }
      expect(subject.working_hours?).to eq(false)
    end

    it "returns false if day is Sunday" do
      saturday = "2017-06-04 12:00:00 -0400"
      allow(subject).to receive(:now) { Time.parse(saturday) }
      expect(subject.working_hours?).to eq(false)
    end
  end
end
