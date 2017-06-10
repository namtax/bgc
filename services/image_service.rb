class ImageService
  def initialize(image)
    @image = image
    @uid   = generate_uid
  end 

  def run
    rename_image
    uid
  end 

  private

  attr_reader :image, :uid

  def rename_image
    %x|mv #{tempfile} #{image_store_path}/#{uid}.jpg|
  end

  def tempfile
    image['tempfile'].path
  end

  def generate_uid
    12.times.map do |x|
      ('A'..'Z').to_a[rand(26)]
    end.join
  end

  def image_store_path
    'tmp/image_destination/'
  end
end
