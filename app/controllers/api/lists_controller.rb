class Api::ListsController < ApiController
  def index
    lists = List.all
    render json: lists
  end

  def show
    list = List.find(params[:id])
    date = list.created_at.strftime('%Y/%m/%d')
    list = list.attributes
    list["date"] = date
    render json: list
  end

  def create
    list = List.new(list_params)
    if list.save
    else
      render json: list.errors.full_messages[0]
    end
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
  end

  def update
    list = List.find(params[:id])
    if list.update(list_params)
    else
      render json: list.errors.full_messages[0]
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :content, :priority)
  end
end
