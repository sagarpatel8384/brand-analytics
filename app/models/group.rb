class Group < ActiveRecord::Base
  has_many :users
  has_many :documents
  has_many :twitter_searches

  validates :name, :street_address, :city, :state, :zip_code, :domain, presence: true
  validates :name, :domain, uniqueness: true
  # validates :domain, format: { with: /\A@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
