class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

after_initialize :set_role

 def admin?
   role == 'admin'
 end
 
 def set_role
   role == 'standard'
 	#self.role ||= 'standard'
 end
end