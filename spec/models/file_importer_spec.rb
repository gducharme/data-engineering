require 'spec_helper'

describe FileImporter do
  describe '#validate_tsv' do
    context 'with a valid file' do
      it 'parses the data' do
        data = File.open( File.join( Rails.root, 'spec', 'fixtures', 'example_input.tsv'), 'r')
        fi = FileImporter.new data, stub_model(FileImport)
        expect(fi.tsv_data.size).to eql(4)
      end
    end

    context 'with an invalid file' do
      it 'returns an empty array' do
        expect(CSV).to receive(:parse).and_raise(CSV::MalformedCSVError)
        data = File.open( File.join( Rails.root, 'spec', 'fixtures', 'bad_example_input.tsv'), 'r')
        fi = FileImporter.new data, stub_model(FileImport)
        expect(fi.tsv_data).to eql([])
      end
    end
  end

  describe '#import' do
    context 'with a row of data' do
      row = ["Snake Plissken","$10 off $20 of food","10.0","2","987 Fake St","Bob's Pizza"]
      rows = [row]
      before :each do
        data = File.open( File.join( Rails.root, 'spec', 'fixtures', 'example_input.tsv'), 'r')
        @fi = FileImporter.new data, stub_model(FileImport)
        @fi.tsv_data = rows
      end

      it 'creates or finds a merchant' do
        stub1 = double
        expect(stub1).to receive(:first_or_create)
        expect(Merchant).to receive(:where).with(name: "Bob's Pizza", address: "987 Fake St").and_return(stub1)
        @fi.import
      end

      it 'creates or finds a purchaser' do
        stub1 = double
        expect(stub1).to receive(:first_or_create)
        expect(Purchaser).to receive(:where).with(name: "Snake Plissken").and_return(stub1)
        @fi.import
      end

      it 'creates or finds an item' do
        stub1 = double
        expect(stub1).to receive(:first_or_create)
        expect(Item).to receive(:where).with(price: "10.0", description: "$10 off $20 of food").and_return(stub1)
        @fi.import
      end

      it 'creates a purchase' do
        expect(Purchase).to receive(:create)
        @fi.import
      end
    end
  end
end
