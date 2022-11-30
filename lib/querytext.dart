const Map<String, String> allDevicesquery = {
  "query": """query
  getMyDevices {
    me {
      devices {
        edges{
          node {
            id
            displayName
            productInformation {
              description
              manufacturer
              model
              serialNumber
            }
          }
        }
      }
    }
  }
  """
};
