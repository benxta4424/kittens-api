class KittensController < ApplicationController
  require "rest-client"
  def index
    @kittens=Kitten.all
    respond_to do |format|
      format.json { render json: @kittens }
    end
  end

  def new
    @kitten=Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:creation_success]="Sucesfully created a kitten!"
      redirect_to kitten_path(@kitten.id)
    else
      flash[:unsucessful_creation]="Unsuccesful in the creation of the kitten! Try again!"
      render :new
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
  end

  def edit
    @kitten=Kitten.find(params[:id])
  end

  def update
    @kitten=Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash[:update_success]="Successfully updated the kitten!"
      redirect_to kitten_path(@kitten.id)
    else
      flash[:unsuccessful_update]="Unsuccessful in updating the kitten! Try again!"
      render :edit
    end
  end

  def destroy
    @kitten=Kitten.find(params[:id])
    @kitten.destroy

    flash[:succesfully_deleted]="Kitten deleted succesfully!"
    redirect_to root_path
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
