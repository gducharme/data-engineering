require 'spec_helper'

describe FileImportController do
  include Devise::TestHelpers

  before :each do
    @file_import = FactoryGirl.create(:file_import)
    sign_in @file_import.user
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end

    it "renders the :new view" do
      get 'new'
      expect(response).to render_template :new
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

    it "renders the :index view" do
      get 'index'
      expect(response).to render_template :index
    end

    it "gets an array of uploaded tabulated files" do
      get 'index'
      expect(assigns(:file_imports)).to match_array([@file_import])
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: @file_import.id
      expect(response).to be_success
    end
  end

  describe "POST 'upload'" do
    context 'with a tab file' do
      before do
        @file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/example_input.tsv'), 'text/tab-separated-values')
        @file.stub(:tempfile).and_return(@file.instance_variable_get(:@tempfile))
      end

      it "redirects to file import show" do 
        post 'upload', file_import: {file_import: @file}
        fi = FileImport.last
        expect(response).to redirect_to(action: 'show', id: fi.id)
      end
    end

    context 'with any other file format' do
    before :each do
      @file = Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/bad_example_input.jpg'), 'image/jpeg')
    end

    it "returns http failure" do
      post 'upload', file_import: {file_import: @file}
      expect(response).to_not be_success
    end
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      expect(response).to be_success
    end
  end

end
