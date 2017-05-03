class Wiki < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  scope :visible_to, -> (user) { user ? all : where(private: false) }
end
