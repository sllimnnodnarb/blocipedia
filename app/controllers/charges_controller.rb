class ChargesController < ApplicationController

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: amount,
      description: "Exclusive Membership - #{current_user.email}",
      currency: 'usd'
    )
    current_user.vip!
    flash[:notice] = "Thank you, #{current_user.email}! Ejoy Exclusive VIP access."
    redirect_to users_show_path(current_user) # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.email}",
     amount: amount
   }
 end

  def upgrade
    if current_user
      current_user.vip!
      flash[:alert] = "You are now upgraded to VIP status."
      current_user.wikis.update_all(private: true)
      redirect_to users_show_path(current_user)
    end
  end

  def downgrade
    current_user.user!
    current_user.wikis.update_all(private: false)
    flash[:alert] = "You are now downgraded to User status."
    redirect_to users_show_path(current_user)
  end

  private

  def amount
    15_00
  end

end
