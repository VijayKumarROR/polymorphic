class BusinessesController < ApplicationController
def index
    @businesses = Business.all
  end

  def show
    @business = Business.find(params[:id])
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      redirect_to businesses_path, notice: "The business has been successfully created."
    end
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @business = Business.find(params[:id])
    if @business.update_attributes(business_params)
      redirect_to businesses_path, notice: "The business has been updated"
    end
  end

  def destroy
    @business = Business.find(params[:id])
    @business.destroy
  end
private
  def business_params
    params.require(:business).permit!
  end
end

Great, now lets add some code for the interactions controller. Open up the interactions controller and modify it so that it looks like the code listed below.
app/controllers/interactions_controller.rb:

class InteractionsController < ApplicationController
  def new
    @context = context
    @interaction = @context.interactions.new
  end

  def create
    @context = context
    @interaction = @context.interactions.new(interaction_params)

    if @interaction.save
      redirect_to context_url(context), notice: "The interaction has been successfully created."
    end
  end

  def edit
    @context = context
    @interaction = context.interactions.find(params[:id])
  end

  def update
    @context = context
    @interaction = @context.interactions.find(params[:id])
    if @interaction.update_attributes(interaction_params)
      redirect_to context_url(context), notice: "The interaction has been updated"
    end
  end

private
  def interaction_params
    params.require(:interaction).permit!
  end

  def context
    if params[:person_id]
      id = params[:person_id]
      Person.find(params[:person_id])
    else
      id = params[:business_id]
      Business.find(params[:business_id])
    end
  end 

  def context_url(context)
    if Person === context
      person_path(context)
    else
      business_path(context)
    end
  end
end
