module Sub
  module Concerns
    module UploaderAttribute
      extend ActiveSupport::Concern

      included do
      end

      module ClassMethods
        def upload_for(*attributes)
          args = Array(attributes)
          if args.any?
            define_method :sub_upload_attributes do
              args
            end
            args.each do |arg|
              instance_eval {
                attribute arg.to_sym, :uploader
              }
            end
          end
        end
      end

      def save
        remote_upload if sub_upload_attributes
        super
      end

      def remote_upload
        begin
          items = sub_upload_attributes.map{ |attribute| send(attribute)}.flatten
          items.map(&:save)
          loop do
            result = items.map(&:result).compact
            break if result.size == items.size
          end
          raise Net::HTTPError("", "upload failed!") if items.map(&:result).include?(false)
        rescue Net::HTTPError
          error.add(:base, "file upload failed!")
          return false
        end
      end
    end
  end
end
