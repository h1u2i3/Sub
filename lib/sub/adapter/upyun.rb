module Sub
  module Adapter
    class Upyun < BaseAdapter
      HOST = "v0.api.upyun.com".freeze
      PORT = "80".freeze

      BUCKET = "youyun".freeze
      PATH = "/#{BUCKET}".freeze

      def generate_key(file_type)
        file_extension = ""
        case file_type
        when "image/jpeg"
          file_extension = ".jpg"
        when "application/pdf"
          file_extension = ".pdf"
        end
        "#{Time.now.to_i}#{(10000..99999).to_a.sample}#{file_extension}"
      end

      def remote_url(file_key)
        "http://#{BUCKET}.b0.upaiyun.com/#{file_key}"
      end

      def remote_destroy(file_key)
      end

      def authentication
      end
    end
  end
end
