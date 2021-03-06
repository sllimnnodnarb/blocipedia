class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable

  before_save { self.email = email.downcase }
  before_save { self.role ||= :user }

  has_many :wikis, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :shared_wikis, through: :collaborators, source: :wiki

  enum role: [:user, :vip, :admin]

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
