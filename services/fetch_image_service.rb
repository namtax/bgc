require 'uri'

class FetchImageService
  def initialize(image_uid)
    @image_uid = image_uid
  end 

  def run
    { 
      file: file,
      header: header
    }
  end 

  private

  attr_reader :image_uid

  def file
    @file ||= File.open("#{image_store_path}/#{image_uid}.jpg")
  end

  def image_store_path
    ENV['IMAGE_STORE']
  end

  def header
    ['Content-Disposition', "attachment; filename*=UTF-8''#{URI.escape(file_name)}"]
  end 

  def file_name
    File.basename(file)
  end
end
