const String allDevicesquery = """query
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
  `""";
