module Resources

  class PolicyParameter
    def initialize(url)
      @url = url
    end
  
    def to_hash
    {
    "policyType": "BASIC",
    "policys": [
      {
        "triggerConfig": {
          "triggerType": "MOTION_RECORDING",
          "type": "motion_start",
          "streamNum": 0,
          "uid": "s9768bf84-672f-4ea9-bf16-b9715be235fe"
        },
        "actionLists": [
          {
            "actions": [
              {
                "actionType": "URL_NOTIFY",
                "properties": [
                  {
                    "pName": "url_post_data",
                    "uid": "3s7592838-25a0-4369-ac78-50dd50ed5c48"
                  },
                  {
                    "pName": "url_method",
                    "pValue": "GET",
                    "uid": "40sa386e0-5a21-4475-925d-96dd854609b7"
                  },
                  {
                    "pName": "url",
                    "pValue": @url,
                    "uid": "2es186c80-78c3-42e6-991e-4faaf85ed6dc"
                  }
                ],
                "uid": "d2se1d975-273c-4ba1-b348-b34938abba84"
              }
            ],
            "uid": "9a31sd918-af27-4c37-8e3c-402d1a6fee4a"
          }
        ],
        "policyType": "BASIC",
        "name": "policy_MOTION_STARTED_URL_NOTIFY",
        "description": "",
        "vsomUid": "dbc3b4ac-491a-4f35-bb9e-7598c13fbfff",
        "objectType": "vs_policy",
        "uid": "sb4e0335b-c32c-42f2-a058-67ecbf7f61a9"
      },
      {
        "triggerConfig": {
          "triggerType": "NO_RECORDING",
          "streamNum": 1,
          "uid": "dsea7310b-1955-429b-a089-e1c7974251db"
        },
        "policyType": "BASIC",
        "name": "24x7 Recording-0-0",
        "description": "",
        "vsomUid": "dbc3b4ac-491a-4f35-bb9e-7598c13fbfff",
        "objectType": "vs_policy",
        "uid": "b59ds3702-d535-49b2-a4a3-e50d3d32102a"
      }
    ],
    "uid": "1510bsc6a8-776c-4215-8182-69131350bcea"
    }    
    end
    
    def self.default(url)
      policies = PolicyParameter.new(url)
      policies.to_hash
    end





  end

end