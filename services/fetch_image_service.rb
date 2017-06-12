require 'uri'
require 'rmagick'
include Magick

class FetchImageService
  def initialize(image_uid)
    @image_uid, @image_format = image_uid.split('.')
  end 

  def run
    { 
      file: file,
      header: header
    }
  end 

  private

  attr_reader :image_uid, :image_format

  def file
    @file ||= fetch_file
  end

  def fetch_file
    if image_format.nil? 
      File.open(image_file)
    elsif File.exists?(image_path)
      File.open(image_path)
    else
      image = Image.read(image_file).first
      image.write(image_path)
      File.open(image_path)
    end
  end

  def image_file
    image_store.grep(/#{image_uid}/).first    
  end

  def image_store
    Dir["#{image_store_path}/*"]
  end

  def image_store_path
    ENV['IMAGE_STORE']
  end

  def image_path
    "#{image_store_path}/#{image_uid}.#{image_format}"
  end

  def header
    ['Content-Disposition', "attachment; filename*=UTF-8''#{URI.escape(file_name)}"]
  end 

  def file_name
    File.basename(file)
  end
end
