require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  before { User.delete_all }
  before { Wiki.delete_all }

  before(:each) do
   @user = FactoryGirl.create(:user)
   sign_in @user
   @wiki = FactoryGirl.create(:wiki)
   @user.wikis << @wiki
  end

  describe "signed in user" do
    it "signed in current user should not be nil" do
      @user = FactoryGirl.build(:user)
      @user.save!
      sign_in @user
      subject.current_user.should_not be_nil
    end
  end

  describe "show for wikis" do
    it "shows an wiki" do
      get :show, id: @wiki
      response.should be_success
    end
  end

  describe "editing an wiki" do
    it "edits an wiki" do
      get :edit, id: @wiki
      response.should be_success
    end
  end

  describe "indexing wikis" do
    it "shows an index of wikis" do
      get :index
      response.should be_success
    end
  end

  # put in a test for deleting wikis!
end
