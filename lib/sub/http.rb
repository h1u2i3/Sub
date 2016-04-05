module Sub
  class Http
    delegate :host, :port, :path, :authentication, to: Sub.adapter

    def initialize
    end

    def upload(item)
      conn = Net::HTTP.new(host, port)
      req = Net::HTTP::Put.new("#{path}/#{item.file_key}")
      req.add_field("Content-Length", item.file.size)
      puts "file_size:#{item.file.size}"
      req.add_field("Date", Time.now.gmtime)
      puts "Date:#{Time.now.gmtime}"
      # req.add_field("Authorization", authentication)
      req.basic_auth("imconfused","h1u2i3_gan")
      # puts "Authorization:#{authentication}"
      req.body = item.file.to_io.read
      puts "file_key: #{item.file_key}"

      response = conn.request(req)

      if block_given?
        yield response
      else
        response
      end
    end

  end
end
