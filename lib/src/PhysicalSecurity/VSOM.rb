require_relative '../APIBase'
class VSOM < APIBase

    def post!
      Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do | http |
        @request =  Net::HTTP::Post.new(@uri)
        add_headers
        @request.body = @body.to_json
        @response = http.request @request
        #File.open("image.jpg", 'w') { |file| file.write(@response.body) }
        @results = JSON.parse(@response.body)
      end
    end

    def get!
      Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do | http |
        @request = Net::HTTP::Get.new(@uri)
        add_headers
        @response = http.request @request 
        @results = @response.body
      end 
    end
  
    def post_to_file(image_name)
      Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do | http |
        @request =  Net::HTTP::Post.new(@uri)
        add_headers
        @request.body = @body.to_json
        @response = http.request @request
        File.open("Resources/media/images/#{image_name}", 'w') { |file| file.write(@response.body) }
        @results = {
          "status": @response.code
        }
      end
    end


end