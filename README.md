# Appium Docker

##Real Device

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

7. Run the android docker image which consists of all the android tools

    ```
    docker run -it --rm -v $(pwd)/sdk:/sdk thenishant/android bash -c 'cp -a $ANDROID_HOME/. /sdk'
    ```
    
8. Run the appium docker image which will be used to dockerizing the appium test

    ```
    docker run --privileged -d -p 5901:5901 -p 2222:22 -p 5037:5037 -p 4723:4723 -v $(pwd)/sdk:/opt/android-sdk -v /dev/kvm:/dev/kvm -v /dev/bus/usb:/dev/bus/usb thenishant/appium-copy
    ```

9. Run adb devices command to verify adb can detect the connected android device.
   
   ```
   docker exec -it container adb devices
   ```

10. Copy the apk file from host machine to the container

    ```
    docker cp /Users/local_path_to_apk/appName.apk container:/opt
    ```

11. Run this command to get the ip address of the docker machine

    ```
    docker-machine ip <your-docker-container-name>
    ```

12. Now Run your appium test by using the app location from `step 10` and with from `step 11`.

---

### Emulator

---

1. Create a `vmware Fusion` machine
    
    ```
    docker-machine create --driver vmwarefusion appium
    ```
    
2. Regenerate certificate for your docker-machine only if get `certificate signed by unknown authority` error 
    
    ```
    docker-machine regenerate-certs appium
    ```

3. Stop the docker in order to enable `virtualization` on vmware machine

        ```
        docker-machine stop appium
        ```
        
4. Enable virtualization on VmWare machine

5. Start the Vm machine and ssh into docker-machine

    ```
    docker-machine start android
    docker-machine ssh android
    ```

6. Install `kvm_intel` into your VmMachine

    ```
    sudo modprobe kvm_intel
    ```
        
7. Run the android docker image which consists of all the android tools

    ```
    docker run -it --rm -v $(pwd)/sdk:/sdk thenishant/android bash -c 'cp -a $ANDROID_HOME/. /sdk'
    ```
    
8. Run the appium docker image which will be used to dockerizing the appium test

    ```
    docker run --privileged -d -p 5901:5901 -p 2222:22 -p 5037:5037 -p 4723:4723 -v $(pwd)/sdk:/opt/android-sdk -v /dev/kvm:/dev/kvm -v /dev/bus/usb:/dev/bus/usb thenishant/appium-copy
    ```
    
9. SSH into the the running container
    
    ```
    docker exec -it <container name> bash
    ```
    
10. Run below commands to download emulator components

    ```
    echo y | sdkmanager "platform-tools" "platforms;android-24" "emulator"
    echo y | sdkmanager "system-images;android-24;default;x86"
    
    ```
    Different images avilable for android-24 version  
    ```system-images;android-24;android-tv;x86
     system-images;android-24;default;arm64-v8a
     system-images;android-24;default;armeabi-v7a
     system-images;android-24;default;x86
     system-images;android-24;default;x86_64
     system-images;android-24;google_apis;arm64-v8a
     system-images;android-24;google_apis;armeabi-v7a
     system-images;android-24;google_apis;x86
     system-images;android-24;google_apis;x86_64
     system-images;android-24;google_apis_playstore;x86
     ```
     
11. Create emulator with the above used system image
    
    ```
    echo no | avdmanager create avd -n emuTest -k "system-images;android-24;default;x86"
    ```
    
12. Now run the emulator by running this command

    ```
    emulator/emulator -avd emuTest -noaudio -gpu off
    ```
    
    **Note:** You may want to run these commands only if you get error regarding `/dev/kvm` inside the container.
    
    ```
    umount /dev/kvm
    rm -rf /dev/kvm
    mknod /dev/kvm c 10 232
    ```
13. Copy the apk file from host machine to the container

    ```
    docker cp /Users/local_path_to_apk/appName.apk container:/opt
    ```

14. Run this command to get the ip address of the docker machine

    ```
    docker-machine ip <your-docker-container-name>
    ```
    
15. Now Run your appium test by using the app location from `step 13` and with from `step 14`.