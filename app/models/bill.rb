class Bill < ApplicationRecord
  validates :measure, presence: true
  validates :subject, presence: true
  validates :author, presence: true
  validates :status, presence: true
  validates :user_id, presence: true
  validates_associated :user
  belongs_to :user
end