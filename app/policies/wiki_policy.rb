class WikiPolicy < ApplicationPolicy

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
