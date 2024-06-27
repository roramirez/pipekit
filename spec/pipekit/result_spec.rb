module Pipekit
  RSpec.describe Result do
    subject(:repository) { described_class.new(request) }
    let(:request) { instance_spy("Pipedrive::Request") }

    describe "pagination_data" do

      let(:response_data) do
        { "data" => [1, 2, 3], "success" => true,
          "additional_data" => { "pagination" => { "more_items_in_collection" => true, "next_start" => 3 } } }
      end
      let(:resource) { {} }

      it "returns the pagination data" do
        instance =  described_class.new(resource, response_data)
        expect(instance.send(:pagination_data)).to eq({ "more_items_in_collection" => true, "next_start" => 3 })
      end

      it "returns {} if there additional_data is nil" do
        response_data = { "data" => [1, 2, 3], "success" => true, "additional_data" => nil }
        instance = described_class.new(resource, response_data)
        expect(instance.send(:pagination_data)).to eq({})
      end
    end
  end
end
