
# DeviceKit

     This framework is used to get device information in the encrypt formate and allows you to decrypt the encrypted device information data. 

# Installation

      Download the application expand the product menu and drag the framwork to your application.
      Add the framwork to the Embedded framwork tab in Generaal tab.
      Import the DeviceKit to your class and use it.
      
# Usage
      
          let device = DeviceInfo()
          device.getDeviceInfo { (device) in
            //It returns the device model take it what ever you need.
            Ex:
            print(device.name)
          }
