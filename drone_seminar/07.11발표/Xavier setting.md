# Xavier Setting
---

### Xavier OS install with SDK Manager
1) Install SDK Manager(1.8) on Host(Ubuntu) PC 
![image](https://user-images.githubusercontent.com/79160507/178177881-d2d78b1d-b81a-4033-b03c-68830eb27fdf.png)
    - DownloadLink : [NVIDIA SDK Manager](https://developer.nvidia.com/nvidia-sdk-manager)
    - Need Nvidia deloper account

2) Run SDK Manager on Host PC and connect Host PC with Xavier, 
![image](https://user-images.githubusercontent.com/79160507/178177977-075d5919-0a22-46d0-83c5-38ad9a1ba631.png)

3) Do 1step, 2step, ~ 4step
    - 1step : Check the connection with xavier with Target Hardware 
    - 2step : Check ("I accept the terms and conditions of the license agreements."), leave ("Download now. Install later")
    - 3step : select Manual Setup, check the IPv4 on Xavier, Set the Username and Password of Xavier
    - 4step : after install, finish.
---

### SSD install
1) Power off the Xavier and Open the board.
    ![image](https://user-images.githubusercontent.com/79160507/178179045-10194f13-67db-495a-87e8-4b012804f06d.png)
    - image reference : https://medium.com/@ramin.nabati/installing-an-nvme-ssd-drive-on-nvidia-jetson-xavier-37183c948978
2) Insert SSD on board
    ![image](https://user-images.githubusercontent.com/79160507/178179676-70d39303-ea75-40d3-bd57-238be0d9f113.png)
    - image reference : https://medium.com/@ramin.nabati/installing-an-nvme-ssd-drive-on-nvidia-jetson-xavier-37183c948978
3) Disk Format with Gnome GUI & Set partition(16GB) for swap files
    ![image](https://user-images.githubusercontent.com/79160507/178179574-bf3e8cb7-5146-4683-9841-cefff19dd87b.png)
4) Mount SSD & copy all rootfs files with easy sheel script made by Jetsonhacks
```
$ git clone https://github.com/jetsonhacks/rootOnNVMe.git 
$ cd rootOnNVMe
$ ./copy-rootfs-ssd.sh
```
5) SSD priority 1 boot activate
```
$ ./setup-service.sh
```
6) reboot
---
### Ros noetic install on Xavier
1) setup sources.list
```
$ sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```
2) setup keys
```
$ sudo apt install curl # if you haven't already installed curl 
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
```
3) install ros after apt update
```
$ sudo apt update
$ sudo apt install ros-noetic-desktop-full
```
4) Environment setup
```
$ source /opt/ros/noetic/setup.bash
```
5) Get dependencies for building packages
```
$ sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
```
6) intialize rosdep & rosdep update
```
$ sudo apt install python3-rosdep
$ sudo rosdep init
$ rosdep update
```
7) Create ros workspace
```
$ mkdir -p ~/catkin_ws/src
$ cd ~/catkin_ws
$ catkin_make or catkin build (Recommend catkin build)
```
8) Source workspace package
```
in directory :d $ /home/usr/catkin_ws
$ source devel/setup.bash
```
9) Edit bashrc
```
$ sudo gedit ~/.bashrc (gedit, nano, vim, vi, ... any editor)
Add two lines in bashrc and save
source /opt/ros/noetic/setup.bash
source /home/jh/catkin_ws/devel/setup.bash
```
---

### Mavros install on Xavier
1) install catkin-tools
```
$ sudo apt install python3-catkin-tools python3-rosinstall-generator python3-osrf-pycommon -y
```

2) in directory : /home/usr/catkin_ws/
```
$ catkin init
$ wstool init src
```

3) install MAVLInk
```
$ rosinstall_generator --rosdistro noetic mavlink | tee /tmp/mavros.rosinstall
```

4) get source
```
$ rosinstall_generator --upstream mavros | tee -a /tmp/mavros.rosinstall
```
5) create workspace & deps
```
$ wstool merge -t src /tmp/mavros.rosinstall
$ wstool update -t src -j4
$rosdep install --from-paths src --ignore-src -y
```
6) install geographic lib datasets
```
$  ./src/mavros/mavros/scripts/install_geographiclib_datasets.sh
```
7) build & source
```
$ catkin build
$ source devel/setup.bash
```
---
### Connect pixhawk and Xavier
- need lists : pixhawk, USB gender hub, USB to TTL usb 
1) insert USB to TTL line in 'telem2' port
2) connect pixhawk and xavier through usb hub
![pixhawk_awdawdf](https://user-images.githubusercontent.com/79160507/178191958-cd028a63-92a6-47ea-8bd9-c5644824dedc.png)
3) check the connection with command
```
$ ls /dev/tty*
```

### Roslaunch autostart with rc.local
- there are many ways to set autostarting : Contrap, rc.local, bashrc, init.d, systemd and we will use rc.local

1) go to /etc directory & make rc.local file
```
$ cd /etc
$ sudo gedit rc.local
```
2) edit rc.local 
The format of rc.local is like below
```
#! /bin/bash

source ~/.bashrc

sleep 3

roslaunch packge_name launchfile_name.launch
```
If you want to run apm.launch, rc.local will be like this
```
#! /bin/bash

source ~/.bashrc
source /opt/ros/noeitc/setup.bash
source /home/jh/catkin_ws/devel/setup.bash

sleep 3

roslaunch mavros apm.launch fcu_url:=/dev/ttypixhawk &
```
_The '&'mark behind ttypixhawk means launch that file in background._

3) give authority to execute rc.local file
```
$ sudo chmod +x rc.local
```
_chmod +rwx (r : read, w : write, x : execute)_

4) edit service file
```
$ cd /lib/systemd/system
$ sudo gedit rc-local.service
```
In rc-local.service
```
Description=/etc/rc.local Compatibility
Documentation=man:systemd-rc-local-generator(8)
ConditionFileIsExecutable=/etc/rc.local
After=network.target

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
RemainAfterExit=yes
GuessMainPID=no

[Install]
WantedBy=multi-user.target
```
5) activate service file with systemctl
```
$ sudo systemctl enable rc-local.service
$ sudo systemctl start rc-local.service
$ sudo systemctl status rc-local.service // check 
```
![image](https://user-images.githubusercontent.com/79160507/178189719-e21ee181-a304-4780-a521-628d7dce1ca1.png)

`If the service get activated with green circle, it's finished.`

6) reboot

##### +) rc.local, service trouble shooting
if rc-local.service doesn't get active, edit the rc.local in /etc and restart rc-local.service
```
1) edit rc.local
2) $ sudo systemctl stop rc-local.service
3) $ sudo systemctl daemon-reload
4) $ sudo systemctl start rc-local.service
5) $ sudo systemctl status rc-local.service
```

---
### USB devide fix
before fix the device, firstable you should connect the usb device to Xavier.
1) check the Vender ID and Product ID with command below
```
$ lsusb
```
2) find the serial name of usb device
```
$ udevadm info -a -n /dev/ttyUSB* | grep '{serial}' | head -n1
``` 
![image](https://user-images.githubusercontent.com/79160507/178190649-d4952067-24ba-4826-b228-b7ff1b3e2686.png)

3) Now we know the vender id, product id, serial of device. Let's make rules to fix the device
```
$ cd /etc/udev/rules.d
$ sudo gedit 99-usb-serial-rules
```
99-usb-serial-rules format : 
```
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="your_serial", SYMLINK+="tty_name"
```
if you want to give authority to device, edit like below
```
SUBSYSTEM=="tty", MODE=="0666" ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="your_serial", SYMLINK+="tty_name"
```
You have give authority and made a symbolic link which acts like a device name. 
![image](https://user-images.githubusercontent.com/79160507/178192200-317b0342-8275-4083-8a76-a4138bc08a66.png)
<br>
I have set the symlink as "ttypixhawk" as seen like below


### Opencv install & build
1) if opencv is installed, remove it becuase it can cause trouble
```
$ sudo apt-get purge libopencv* python-opencv
```

2) apt update
```
$ sudo apt-get update
$ sudo apt-get upgrade
```
3) cmake package install, install libraries and tools
```
$ sudo apt-get install build-essential cmake
$ sudo apt-get install pkg-config
$ sudo apt-get install libjpeg-dev libtiff5-dev libpng-dev
$ sudo apt-get install ffmpeg libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev libx264-dev libxine2-dev
$ sudo apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 
$ sudo apt-get install libv4l-dev v4l-utils
$ sudo apt-get install libgtk-3-dev
```
4) OpenGL, OpenCV library
```
$ sudo apt-get install mesa-utils libgl1-mesa-dri libgtkgl2.0-dev libgtkglext1-dev
$ sudo apt-get install libatlas-base-dev gfortran libeigen3-dev
$ sudo apt-get install python3-dev python3-numpy
```
5) make directory to get opencv
```
$ mkdir opencv
$ cd opencv
```

6) opencv get
```
$ wget -O opencv.zip https://github.com/opencv/opencv/archive/4.4.0.zip
$ unzip opencv.zip
$ wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.4.0.zip
$ unzip opencv_contrib.zip
```
7) go to opencv directory 
```
$ cd opencv-4.4.0
$ mkdir bulid
$ cd bulid
```
8) build 
```
$ sudo apt install cmake
$ cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=OFF -D WITH_IPP=OFF -D WITH_1394=OFF -D BUILD_WITH_DEBUG_INFO=OFF -D BUILD_DOCS=OFF -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=OFF -D BUILD_PACKAGE=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D WITH_QT=OFF -D WITH_GTK=ON -D WITH_OPENGL=ON -D BUILD_opencv_python3=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-4.4.0/modules -D WITH_V4L=ON  -D WITH_FFMPEG=ON -D WITH_XINE=ON -D OPENCV_ENABLE_NONFREE=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D OPENCV_SKIP_PYTHON_LOADER=ON -D OPENCV_GENERATE_PKGCONFIG=ON ../
```

9) install 
```
$ sudo make install
$ sudo ldconfig
```
10) check install and running
```
python3 /usr/local/share/opencv4/samples/python/facedetect.py --cascade "/usr/local/share/opencv4/haarcascades/haarcascade_frontalface_alt.xml" --nested-cascade "/usr/local/share/opencv4/haarcascades/haarcascade_eye_tree_eyeglasses.xml" /dev/video0
```
![178194113-50f3c137-16b6-41b6-b953-48fcf58ec5cc](https://user-images.githubusercontent.com/79160507/178194296-b2e620fb-2d82-4ec9-b30f-53ee72ff8ab2.gif)


### Lidar connect & install + build
1) Insert power to Lidar and connect lidar & xiaver with ethernet LAN  
![lidar_connection](https://user-images.githubusercontent.com/79160507/178194613-cd267a66-72d0-4535-bc24-6514fb0f0558.jpg)

2) When insert ethernet line, there will be network setting added.
3) Edit the IPv4 settings like below
![image](https://user-images.githubusercontent.com/79160507/178194691-63055e82-8931-41a6-9354-387d62c56602.png)
4) Open web browser and get to adress : 192.168.1.201 to check the connection
![image](https://user-images.githubusercontent.com/79160507/178194812-d314dab8-b2a3-4129-be8b-8cd644ddeea7.png)
5) install ROS dependencies
```
$ sudo apt-get install ros-VERSION-velodyne
```
6) install VLP16 driver
```
$ cd ~/catkin_ws/src/ && git clone https://github.com/ros-drivers/velodyne.git
$ rosdep install --from-paths src --ignore-src --rosdistro YOURDISTRO -y
$ cd ~/catkin_ws/ && catkin build
```
7) Run rviz to visualize the Pointcloud data
```
$ roslaunch velodyne_pointcloud VLP16_points.launch
$ rosnode list
$ rostopic echo /velodyne_points
$ rosrun rviz rviz -f velodyne
```
![lidar_running](https://user-images.githubusercontent.com/79160507/178195759-e6112397-7502-4190-8d38-00623af905f1.gif)



##### Lidar connect Troubleshooting
        If Lidar ip connection doesn't work, replace the USB Hub or Lidar device or Ethernet Lan line.
        Troubleshooting reference : http://wiki.ros.org/velodyne/Tutorials/Getting%20Started%20with%20the%20Velodyne%20VLP16

### Options

        - Hangul install : (https://velog.io/@ddubbu/%EC%9A%B0%EB%B6%84%ED%88%AC-20.04-%ED%95%9C%EA%B8%80-%EC%9E%85%EB%A0%A5-%EB%B0%A9%EB%B2%95-feat.-fcitx)
        - Terminator install : $ apt install terminator
        - Chrome browser install : $ apt install chromium-browser
