class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators

  scope :visible_to, -> (user) { user ? all : where(private: false) }
  default_scope { order('created_at DESC') }

  def collaborator_for(user)
    collaborators.find_by(user_id: user.id)
  end
end
