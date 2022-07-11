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
Add two lines in bashrc
source /opt/ros/noetic/setup.bash
source /home/jh/catkin_ws/devel/setup.bash
```
---

### Mavros install on Xavier

### Connect pixhawk and Xavier

### Roslaunch autorun with rc.local

### USB devide fix

### Opencv install & build

### Lidar connect & install + build

### Options

        - Hangul install : (https://velog.io/@ddubbu/%EC%9A%B0%EB%B6%84%ED%88%AC-20.04-%ED%95%9C%EA%B8%80-%EC%9E%85%EB%A0%A5-%EB%B0%A9%EB%B2%95-feat.-fcitx)
        - Terminator install : $ apt install terminator
        - Chrome browser install : $ apt install chromium-browser
