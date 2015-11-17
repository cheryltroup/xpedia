class Wiki < ActiveRecord::Base
  belongs_to :user

  has_many :collaborators
  has_many :collaborated_users, through: :collaborators, source: :user

  scope :visible_to, -> (user) { user && ((user.role == 'premium') || (user.role == 'admin')) ? all : where("private IS NULL or private = ?", false) }

  scope :public_only, -> { where private: [nil, false]}
  scope :private_only, -> { where private: true }

  def public?
  	!private?
  end
end
