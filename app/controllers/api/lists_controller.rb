class Api::ListsController < ApiController
  def index
    lists = List.all
    render json: lists
  end

  def show
    list = List.find(params[:id])
    render json: list
  end

  def create
    list = List.new(list_params)
    if list.save

    else
      render json: list.errors
    end
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
  end

  def update
    list = List.find(params[:id])
    if list.update(list_params)
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :content, :priority)
  end
end
