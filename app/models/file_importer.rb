require 'csv'

class FileImporter
  attr_accessor :tsv_data

  Hash={"purchaser name" => 0,
        "item description" => 1,
        "item price" => 2,
        "purchase count" => 3,
        "merchant address" => 4,
        "merchant name" => 5}

  def initialize data, import
    validate_tsv data
    @import = import
  end

  def validate_tsv data
    begin
      @tsv_data ||= CSV.parse data, col_sep: "\t", headers: true
    rescue CSV::MalformedCSVError, ArgumentError
      @tsv_data = []
    end
  end

  def import
    tsv_data.each do |row|
      merchant = Merchant.where(name: row[Hash['merchant name']], address: row[Hash['merchant address']]).first_or_create
      purchaser = Purchaser.where(name: row[Hash['purchaser name']]).first_or_create
      item = Item.where(price: row[Hash['item price']], description: row[Hash['item description']]).first_or_create
      purchase = Purchase.create(merchant: merchant, item: item, purchaser: purchaser, count: row[Hash['purchase count']], file_import: @import)
    end
  end
end
