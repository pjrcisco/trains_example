require_relative "../../VSOM"
require_relative "../../Utility/Methods"
module API

  def self.create_device_template_uri
    "/devicetemplate/createDeviceTemplate"
  end
  
  def self.get_device_template_uri
    "/devicetemplate/getDeviceTemplate"
  end

  def self.get_device_templates_uri
    "/devicetemplate/getDeviceTemplates"
  end

  module REST
  module DeviceTemplate


    def self.create(token, template_info)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.create_device_template_uri),
        headers: Utility.apply_token(token),
        body: { 
          "template": template_info 
        }
      })
      vsom.post!
      vsom.results
    end

    def self.get(token, template_reference)
      vsom = VSOM.new({
        uri: Utility.set_uri(API.get_device_template_uri),
        headers: Utility.apply_token(token),
        body: {
          "templateRef": template_reference
        }
      })
      vsom.post!
      vsom.results
    end

    def self.get_by_name(token, name)
      payload = { "filter": {"byExactName": name} }
      Utility.create_vsom(token, API.get_device_templates_uri, payload)
    end

  end
  end

end


