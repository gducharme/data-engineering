require 'csv'

class FileImport < ActiveRecord::Base
  belongs_to :user
end
