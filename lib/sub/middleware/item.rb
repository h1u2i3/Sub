module Sub
  module Middleware

    class Item
      include ActiveModel::Model

      attr_accessor :file, :adapter, :result, :file_name, :file_type, :file_key

      delegate :generate_key, :remote_url, :upload, :remote_destroy, :target, to: :adapter

      class << self
        def init_from_key(key)
          new(Hash[[:file_name, :file_type, :file_key].zip(key.split('&'))]).init_adapter
        end

        def init_from_file(uploadedfile)
          instance = new( file_name:  uploadedfile.original_filename,
                          file_type:  uploadedfile.content_type,
                          file:       uploadedfile.tempfile ).init_adapter
          yield instance if block_given?
          instance
        end
      end

      def init_adapter
        self.adapter = Sub.adapter
        self
      end

      def save
        unless file.nil?
          self.file_key = generate_key(file_type) if file_key.nil?
          Sub.pool.schedule(self) do |item|
            adapter.upload(item) do |response|
              puts "response: #{response}"
              puts "self: #{self}"
              puts "response_code: #{response.code}"
              self.result = (response.code == "200") ? true : false
            end
          end
        end
      end

      def key
        "#{file_name}&#{file_type}&#{file_key}"
      end

      def url
        remote_url(file_key)
      end

    end

  end
end
