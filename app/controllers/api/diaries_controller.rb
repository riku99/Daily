class Api::DiariesController < ApiController
  def index
    diaries = Diary.with_attached_image
    diaries_array = []
    diaries.each do |d|
      hash = d.attributes
      if d.image.attached?
        image = Rails.application.routes.url_helpers.rails_blob_path(d.image)
        date = d.created_at.strftime('%Y/%m/%d')
        hash["image"] = image
        hash["date"] = date
      else
        hash["image"] = ''
        hash["date"] = date
      end
        diaries_array << hash
    end
    render json: diaries_array
  end

  def create
    diary = Diary.new(diary_params)
    if diary.save
      diary.parse_base64(params[:diary][:base_image])
    else
      render json: diary.errors.full_messages[0]
    end
  end

  def show
    diary = Diary.find(params[:id])
    diary_hash = diary.attributes
    if diary.image.attached?
      image = Rails.application.routes.url_helpers.rails_blob_path(diary.image)
      diary_hash['image'] = image
    else
      diary_hash['image'] = ''
    end
    render json: diary_hash
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.delete
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :content, :base_image)
  end
end
