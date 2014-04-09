class Purchase < ActiveRecord::Base
  belongs_to :purchaser
  belongs_to :item
  belongs_to :file_import
  belongs_to :merchant

  def self.calculate_purchases import
    sum = 0
    Purchase.where(file_import: import).all.each do |purchase|
      next if !purchase.count or purchase.count <= 0
      next if !purchase.item or !purchase.item.price or purchase.item.price <= 0
      sum += sum + purchase.count * purchase.item.price
    end
    return sum
  end
end
