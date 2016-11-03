class ChargesController < ApplicationController
# The ChargesController class creates charge to users when upgrading via Stripe API  

before_action :authenticate_user!

# Create a Stripe customer object to associate with charge
#   @param: email, the string representation of the person's email
#   @param: card, an integer representation of a credit card number 
def create
  customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
   )
  # Changes the user role to premium
  charge = Stripe::Charge.create(
    customer: customer.id, 
    amount: amount_for_upgrade,
    description: "Premium Membership! - #{current_user.email}",
    currency: 'usd'
   )

  # @param: customer, the string representation of the customer id
  # @param: amount, an integer represenation of amount 
  # @param: description, the string representation of description 
  # @param: currency, the string representation of currancy

  current_user.update_attribute(:role, 'premium')
  flash[:notice] = "Thanks for upgrading your account!, #{current_user.email}! "
  redirect_to wikis_path(current_user) 

# Rescue block catches and displays error 
  rescue Stripe::CardError => e
   flash[:error] = e.message
   redirect_to new_charge_path
end

# Initalize payment and pass to Stripe
#   @param: key, the stirng respresentation of key
#   @param: description, the string representation of description 
#   @param: amount, an integer represenation of amount 
 
  def new  
  @stripe_btn_data = {
    key: "#{ Rails.configuration.stripe[:publishable_key] }",
    description: "Premium Membership - #{current_user.name}",
    amount: amount_for_upgrade
   }
  end

  private
  
  # Upgrade amount
  def amount_for_upgrade
    15_00
  end
end