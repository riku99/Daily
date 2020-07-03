class Diary < ApplicationRecord
  has_one_attached :image
  attr_accessor :base_image

  validates :title, presence: true
  default_scope -> { order(created_at: :desc) }

  def parse_base64(image)
    if image.present?
      content_type = create_extension(image)  # ファイルデータの拡張子を調べる
      contents = image.sub %r/data:((image|application)\/.{3,}),/, '' # data:image/png;base64の部分を抜く。ここはbase64じゃない
      decoded_data = Base64.decode64(contents)  # デコードしバイナリにする
      filename = Time.zone.now.to_s + '.' + content_type  # ファイル名をタイムゾーンから作成
      File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f| # tmpにファイル名filrnameでファイルを作成。
        f.write(decoded_data) # ファイルの中身にデコードしたデータを反映(画像)。
      end
      attach_image(filename) # active_storageを使い関連付け。
    end
  end

  def create_extension(image)
    content_type = rex_image(image)
    content_type[%r/\b(?!.*\/).*/]
  end

  def rex_image(image)
    image[%r/(image\/[a-z]{3,4})|(application\/[a-z]{3,4})/]
  end

  def attach_image(filename)
    self.image.attach(io: File.open("#{Rails.root}/tmp/#{filename}"), filename: filename)
    FileUtils.rm("#{Rails.root}/tmp/#{filename}")
  end
end
