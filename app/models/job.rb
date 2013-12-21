class Job < ActiveRecord::Base
  belongs_to :user
  has_many :applications

  validates :title, presence: true
  validates :description, presence: true
  validates :contact, presence: true
  validates :company, presence: true
end
