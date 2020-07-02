class Api::DiariesController < ApiController
  def index
    diaries = Diary.all
    diaries_array = []
    diaries.each do |d|
      hash = d.attributes
      if d.image.attached?
        filename = d.image.blob.attributes["filename"]
        ext = File.extname(filename)
        ext = ext.delete('.')
        image = d.image.download
        en = Base64.encode64(image)
        date = d.created_at.strftime('%Y/%m/%d')
        hash["ext"] = ext
        hash["image"] = en
        hash["date"] = date
      else
        hash["ext"] = ''
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
      render json: diary
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :content, :base_image)
  end
end
