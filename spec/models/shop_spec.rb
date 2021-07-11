require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe "#strip_attributes" do
    context "note" do
      subject do
        product = Shop.new(name: "TEST", email: "TEST", note: "TEST\n")
        product.valid?
        product.note
      end

      it { is_expected.to eq("TEST") }
    end
  end
end
