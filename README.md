# DeviceKit

     This framework allows you to read the device information from which this is used.

# Installation

      Please download the application
      Expand the product menu and drag the framework to your application.
      Import the DeviceKit to your class and use it.
      
# Usage
      
      let device = DeviceInfo()
      device.getDeviceInfo { (device) in
         //It returns the device model take it what ever you need.
         Ex:
         print(device.name)
      }

# Approach
      
      Initially i tried Encrypting deviceInfo, Later i decided to change the approach to send it as model object.
    
      Also created the struct to pass the deviceInfo as a model object in a block. 
      
      Added test case for the getDeviceInfo function wether the model returns the object.
      
# Results
      
      While calling the function it returns the model object and we can use it.
      
