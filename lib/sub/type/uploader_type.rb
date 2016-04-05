module Sub
  module Type
    class UploaderType < ActiveRecord::Type::Value

      def cast(value)
        args = Array(value)
        return nil unless args.any?
        begin
          @results = []
          args.each do |arg|
            raise TypeError unless arg.instance_of?(ActionDispatch::Http::UploadedFile)
            Sub::Middleware::Item.init_from_file(arg) do |result|
              @results << result
            end
          end
          super @results
        rescue TypeError
          super nil
        end
      end

      def serialize(value)
        value.map(&:key).join(',')
      end

      def deserialize(value)
        return nil if value.nil?
        args = value.split(',')
        return nil unless args.any?
        return Sub::Middleware::Item.init_from_key(args[0]).url if args.size.eql?(1)
        return args.map { |key|   Sub::Middleware::Item.init_from_key(key) }
                   .map { |item|  item.url }
      end

    end
  end
end
