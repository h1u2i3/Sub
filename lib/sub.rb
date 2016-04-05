require "active_record/type"
require "active_model/model"
require "net/http"

require "sub/version"
require "sub/engine"

require "sub/adapter/base_adapter"
require "sub/adapter/upyun"

require "sub/concerns/uploader_attribute"
require "sub/type/uploader_type"
require "sub/worker_pool"
require "sub/configure"


module Sub
  class << self
    delegate :pool_size, :adapter, to: :config
    delegate :schedule, :shutdown, to: :pool

    def config
      return @config if defined?(@config)
      @config = Sub::Configure.new
      @config.pool_size = 5
      @config.adapter = Sub::Adapter::Upyun
      @config
    end

    def pool
      return @pool if defined?(@pool)
      @pool = Sub::WorkerPool.new(pool_size)
      @pool
    end
  end
end

require "sub/http"
require "sub/middleware/item"

# active record plugin include
ActiveRecord::Type.register(:uploader, Sub::Type::UploaderType)
ActiveRecord::Base.send(:include, Sub::Concerns::UploaderAttribute)
