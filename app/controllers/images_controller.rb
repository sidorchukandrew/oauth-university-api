class ImagesController < ApplicationController

    require "securerandom"
    require 'aws-sdk-s3'

    def get_presigned_url
        file_name = SecureRandom.uuid;
        s3 = Aws::S3::Resource.new
        
        obj =  s3.bucket(ENV['S3_BUCKET']).object(file_name)

        presigned_url = obj.presigned_url(:put, acl: 'public-read', expires_in: 3600 * 24)

        config = {presignedUrl: presigned_url, imageUrl: obj.public_url}
        render :json => config
    end

    def delete_image
        file_name = params[:imageUrl]
        file_name = file_name.sub("https://#{ENV['S3_BUCKET']}.s3.amazonaws.com/", "")
        client = Aws::S3::Client.new
        result = client.delete_object({key: file_name, bucket: ENV['S3_BUCKET']})
        render :status => 200
    end
end
