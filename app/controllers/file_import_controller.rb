class FileImportController < ApplicationController
  def new
    @file_import = FileImport.new
  end

  def index
    @file_imports = FileImport.all
  end

  def show
    @file_import = FileImport.where(id: params[:id]).first!
  end

  def upload
    @upload = params['file_import']['file_import']
    if @upload.content_type == 'text/tab-separated-values'
      @file_import = FileImport.create(user: current_user, filename: @upload.original_filename)
      importer = FileImporter.new @upload.tempfile, @file_import
      importer.import
      redirect_to file_import_show_path(id: @file_import.id)
    else
      render status: 415
    end
  end
end
