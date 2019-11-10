require "stripe"

class RunnersController < ApplicationController
  before_action :authenticate_runner!
  # before_action :authorize!, only: [:show]

  def show
    @runner = Runner.find(params[:id])
    redirect_to(profile_path(@runner.profile))
  end

  # def new
  #   @runner = Runner.new
  #   @runner.build_profile
  #   #Is this okay above? Needed. What do?
  # end
  #causes a redirction if after checking the parameters, is shown that the boolean for paid is not set to true
  def edit
    @runner = Runner.find(params[:id])
    runner_paid
  end
  #if edit is fond and update is valid, will update parameters in the database. 
  def update
    @runner = Runner.find(params[:id])
    respond_to do |format|
      if @runner.update(runner_params)
        @runner.profile.image.attach(image_params[:image]) if image_params[:image]
        # set_runner_username
        format.html { redirect_to root_path, notice: "Profile was successfully updated. I think" }
        format.json { render :show, status: :ok, location: @runner }
      else
        format.html { render :edit }
        format.json { render json: @runner.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    @runner = Runner.find(params[:id])
    destroy
  end
  #removes runner profile and associated children from the database (through dependent destroys)
  def destroy
    @runner = Runner.find(params[:id])
    @runner.destroy
    respond_to do |format|
      format.html { redirect_to runners_url, notice: "Runner was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def runner_paid
    redirect_to "/payment" unless @runner.paid
  end

  def payment
    Stripe.api_key = "sk_test_asrWm1BBv0Ha7judqem07xBT00BiFiyMgo"
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: [{
        name: "Runnerfy Subscription",
        description: "Lifetime subscription to Runnerfy",
        amount: 1000,
        currency: "aud",
        quantity: 1,
      }],
      success_url: "#{root_url}/runners/complete",
      cancel_url: "#{root_url}/runners/cancel",
    )
  end

  #adds a true to the paid boolean in the parameters of the runner
  def complete
    @runner = current_runner
    @runner.update_attributes(paid: true)
    flash[:notice] = "Your purchase is complete!"
    redirect_to(root_path)
  end

  def cancel
    flash[:notice] = "Purchase not completed."
    redirect_to(root_path)
  end

  # def set_runner_username
  #   @runner = Runner.find(params[:id])
  #   @runner.update_attributes(username: runner.profile.username))
  #   @runner.save
  # end
  private

  def runner_params
    params.require(:runner).permit(:username, :email, :paid, profile_attributes: [:username, :age, :gender, :pace, :image, :runningregion])
  end

  def image_params
    params.require(:runner).permit(:username, :email, profile_attributes: [:image])
  end

  # def authorize!
  #   unless current_runner.has_role? :admin
  #     redirect_to runners_path, alert: 'You are not authorized.' and return
  #   end
  # end

end
