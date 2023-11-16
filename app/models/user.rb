class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  has_many :bills

  devise :database_authenticatable,
      :jwt_authenticatable,
      :registerable,
      jwt_revocation_strategy: JwtDenylist

  def full_name
      "#{first_name} #{last_name}"
  end
end
