RSpec.describe Quote do

  describe "#to_s" do
    subject { Quote.new({ id: 42, content: "Some wise shit." }) }

    it "returns the content" do
      expect("#{subject}").to eq("Some wise shit.")
    end
  end

end
