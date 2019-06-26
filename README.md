
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

# Approach
      
      First i tried to convert the the device info into Encrypt formate.
   
      Write the Test case to check  the encryption & decryption is working fine or not .
 
      Then I planed the DeviceKit should  contains the function that returns the device info.

      So I created the struct and pass the device info to the struct and pass the model class in block.
      
      
# Results
      
      While calling the fuction it returns the model object and we can use it.
      
