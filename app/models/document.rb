# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  text       :text
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

class Document < ActiveRecord::Base
  belongs_to :group
  has_many :tweets
  has_many :document_keywords
  has_many :keywords, through: :document_keywords
  has_one :sentiment, as: :record

  validates :text, :title, presence: true
  validates :title, length: { minimum: 3 }
  validates :text, length: { minimum: 5 }

  accepts_nested_attributes_for :keywords



end
