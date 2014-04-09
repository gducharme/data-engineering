class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :openid_authenticatable
  def self.build_from_identity_url(identity_url)
    User.new(:identity_url => identity_url)
  end

  def openid_fields=(fields)
  end

  def self.openid_required_fields
    ["fullname", "email", "http://axschema.org/namePerson", "http://axschema.org/contact/email"]
  end
end
