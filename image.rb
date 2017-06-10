require 'grape'
require_relative 'services/image_service'
require 'dotenv/load'

class Image < Grape::API
  post 'upload' do
    output = ::ImageService.new(params[:image_file]).run
    { image_uid: output }
  end
end
