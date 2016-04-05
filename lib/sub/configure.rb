module Sub
  class Configure
    # pool size for the http connection
    attr_accessor :pool_size

    # adapter for upload, it's where the operation defined.
    attr_accessor :adapter
  end
end
