class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
has_many :wikis
has_many :collaborators

after_initialize :set_role

 def standard?
	role == 'standard'
 end

 def admin?
  role == 'admin'
 end

 def premium?
 	role == 'premium'
 end

 def set_role
   role == 'standard'
 end

end