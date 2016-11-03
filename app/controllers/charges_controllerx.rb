class ChargesController < ApplicationController

before_action :authenticate_user!

def create
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
   )
 
  charge = Stripe::Charge.create(
    customer: customer.id, 
    amount: amount_for_upgrade,
    description: "Premium Membership! - #{current_user.email}",
    currency: 'usd'
   )

  current_user.update_attribute(:role, 'premium')
   flash[:notice] = "Thanks for upgrading your account!, #{current_user.email}! "
   redirect_to wikis_path(current_user) 
 
  rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
end

def new
  @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "Premium Membership - #{current_user.name}",
    amount: amount_for_upgrade
   }
  end

  private

  def amount_for_upgrade
    15_00
  end
end