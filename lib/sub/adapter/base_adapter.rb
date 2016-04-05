module Sub
  module Adapter
    class BaseAdapter
      class << self
        delegate :http,
                 :host,
                 :port,
                 :path,
                 :authentication,
                 :generate_key,
                 :remote_url,
                 :upload,
                 :remote_destroy, to: :instance

        def instance
          return @@instance if defined?(@@instance)
          @@instance = new
          @@instance
        end
      end

      def http
        Sub::Http.new
      end

      # this can be initialize in the subclass
      # different adapter should have different host and port
      %i(host port path).each do |name|
        define_method(name) do
          Sub.adapter.const_get(name.upcase)
        end
      end

      # the method also should be set in the subclass
      # different adapter should have different initialize method

      def authentication
        raise NotImplementedError
      end

      def generate_key(file_type)
        raise NotImplementedError
      end

      def remote_url(file_key)
        raise NotImplementedError
      end

      def upload(item)
        yield http.upload(item)
      end

      def remote_destroy(file_key)
        raise NotImplementedError
      end
    end
  end
end
