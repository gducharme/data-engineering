require 'spec_helper'

describe Purchase do
  context 'with file import' do
    it 'calculates the sum' do
      purchase = FactoryGirl.create(:purchase)
      expect(Purchase.calculate_purchases(purchase.file_import)).to eql(8.0)
    end
  end
  # More negative tests should be here as well (ie 0 and negative count and price)
end
