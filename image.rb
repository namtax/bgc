require 'grape'
require_relative 'services/image_service'
require_relative 'services/fetch_image_service'
require 'dotenv/load'

class Image < Grape::API
  resources :image do
    post do
      output = ::ImageService.new(params[:image_file]).run
      { image_uid: output }
    end

    route_param :uid, type: String do 
      get do
        output = ::FetchImageService.new(params[:uid]).run

        env['api.format'] = :binary
        content_type 'image/jpg'
        header output[:header]

        output[:file].read
      end
    end
  end
end
