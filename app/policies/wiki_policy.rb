class WikiPolicy < ApplicationPolicy
	#belongs_to :user

  #scope :visible_to, -> (user) { user && ((user.role == 'premium') || (user.role == 'admin')) ? all : where("private IS NULL or private = ?", false) }	

def index?
	true
end

def show?
	user.present?
end

def update?
	show?
end

def create?
  	user.present?
  end

  def new?
  	create?
  end

  class Scope
     attr_reader :user, :scope
 
     def initialize(user, scope)
       @user = user
       @scope = scope
     end
  end

end
