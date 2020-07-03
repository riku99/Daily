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
    else
      render json: diary.errors.full_messages[0]
    end
  end

  def show
    diary = Diary.find(params[:id])
    diary_hash = diary.attributes
    if diary.image.attached?
      filename = diary.image.blob.attributes['filename']
      ext = File.extname(filename)
      image = diary.image.download
      en = Base64.encode64(image)
      diary_hash['ext'] = ext
      diary_hash['image'] = en
    else
      diary_hash['ext'] = ''
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
