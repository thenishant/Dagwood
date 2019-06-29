# Appium_Docker

### Why
- Helps in quick & easier setup of automation environment for Appium + Android

#### Setting up Android real device test on Docker macOSX
---
1. Make sure you have latest docker installed on mac.
 
     ```
     docker-machine --version
     docker-machine version 0.16.1, build cce350d7
     ```
2. Create a docker-machine

    ```
    docker-machine create --driver virtualbox appium-machine
    ```
    
3. Enable USB in created docker-machine

    ```
    docker-machine stop appium-machine
    vboxmanage modifyvm appium-machine --usb on --usbehci on
    docker-machine start appium-machine
    ```
    
    ***Note:***
	You need to install [Extension Pack](https://download.virtualbox.org/virtualbox/6.0.8/Oracle_VM_VirtualBox_Extension_Pack-6.0.8.vbox-extpack) depends on your virtualbox version, in case you get an Error "Implementation of the USB 2.0 controller not found"

4. Open Virtual box, navigate to appium-machine created, select USB and add Android device.

    ![img](https://i.imgur.com/YsA751S.png)

5. Kill adb server from the base machine
    ```
    adb kill-server
    ```
6. SSH into the docker machine created
   
   ```
   docker-machine ssh appium-machine
   ```

7. Run the docker image on the newly created docker machine

    ```
    docker run --privileged -d -p 4723:4723  -v /dev/bus/usb:/dev/bus/usb --name container thenishant/appium-docker-devices
    ```

8. Run adb devices command to verify adb can detect the connected android device.
   
   ```
   docker exec -it container adb devices
   ```
   
9. Copy the apk file from host machine to the container

   ```
   docker cp /Users/loacl-macosx-path-to-apk/app-debug.apk container:/opt
   ```
   
10. Run this command to get the ip address of the docker machine

    ```
    docker-machine ip <your-docker-container-name>
    ```
