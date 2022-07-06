### Nvidia SDK Manager를 통해 Xavier OS설치 및 mavros, pixhawk, IMU, Lidar연결 with ROS
---

<em> test_em </em> <br>
<strong> test_strong </strong> <br>

- Xavier, Host PC(Ubuntu) 연결시 필요한 것들 : USB젠더, 키보드.마우스, Xavier 파워선, Usb(C to USB), HDMI 선
    
1. Host PC(Host)와 Xavier연결, Xavier 파워 연결하고 키보드마우스, 모니터 연결 
2. Host PC에 SDK Manager 설치 1.8 version(Download Link:https://developer.nvidia.com/nvidia-sdk-manager) 
3. SDK Manager 실행 $ sdkmanager
4. SDK Manager에서 NVIDIA login 후 Xavier에 OS flash, flash 후 install
    - SDK Manager에서 Manual setup으로 진행, recovery 버튼을 먼저 누르고있는 상태에서 power버튼 같이 2초정도 눌렀다가 떼기, Xavier에 인터넷연결(LAN or Wifi)하고 ifconfig통해 ip확인해서 ip, Xavier id, pw 입력 => 설치 시작
    - https://jstar0525.tistory.com/58 (설치 참고 링크)
    - 설치 후 Xavier에서 설치 완료 확인 
    -   $ cd ~/VisionWorks-SFM-0.90-Samples,   $ ./bin/aarch64/linux/release/nvx_sample_sfm (xavier base visionwork check)
    -   $ nvcc -V (cuda version check)
    -   설치 완료확인 됐으면 xavier 업데이트 ($ sudo apt-get update && sudo apt-get upgrade)
    + option) : 
        - 한글설치 (https://velog.io/@ddubbu/%EC%9A%B0%EB%B6%84%ED%88%AC-20.04-%ED%95%9C%EA%B8%80-%EC%9E%85%EB%A0%A5-%EB%B0%A9%EB%B2%95-feat.-fcitx)
        - terminator install : $ apt install terminator
        - chrome browser 설치 : $ apt install chromium-browser

4-1) SSD 설치(option) : https://semotube.tistory.com/98 <br>
4-2) ROS설치 (Reference Link : http://wiki.ros.org/noetic/Installation/Ubuntu)
    - 
    
    - ROS설치과정에서 sudo apt update에서 오류가 나거나 sudo apt-get install ros-noetic-(.. 생략)에서 package가 없다는 오류가 발생한다. 이 경우 
        - 1) sudo apt --fix borken install -o Dpkg::Options::="--force overwrite" => fix broken 안될경우
        - or 2) $ sudo sed -i -e 's|disco|focal|g' /etc/apt/sources.list , $ sudo apt update

5) Mavros source 설치 및 Ros와 연결(mavlink. mavros, geographic lib설치)


        sudo apt-get install python-catkin-tools python-rosinstall-generator -y
        # For Noetic use that:
        # sudo apt install python3-catkin-tools python3-rosinstall-generator python3-osrf-pycommon -y

        # 1. Create the workspace: unneeded if you already has workspace
        mkdir -p ~/catkin_ws/src
        cd ~/catkin_ws
        catkin init
        wstool init src

        # 2. Install MAVLink
        #    we use the Kinetic reference for all ROS distros as it's not distro-specific and up to date
        rosinstall_generator --rosdistro kinetic mavlink | tee /tmp/mavros.rosinstall

        # 3. Install MAVROS: get source (upstream - released)
        rosinstall_generator --upstream mavros | tee -a /tmp/mavros.rosinstall
        # alternative: latest source
        # rosinstall_generator --upstream-development mavros | tee -a /tmp/mavros.rosinstall
        # For fetching all the dependencies into your catkin_ws, just add '--deps' to the above scripts
        # ex: rosinstall_generator --upstream mavros --deps | tee -a /tmp/mavros.rosinstall

        # 4. Create workspace & deps
        wstool merge -t src /tmp/mavros.rosinstall
        wstool update -t src -j4
        rosdep install --from-paths src --ignore-src -y

        # 5. Install GeographicLib datasets:
        ./src/mavros/mavros/scripts/install_geographiclib_datasets.sh

        # 6. Build source
        catkin build

        # 7. Make sure that you use setup.bash or setup.zsh from workspace.
        #    Else rosrun can't find nodes from this workspace.
        source devel/setup.bash


7) Pixhawk와 Xavier 연결
8) Xavier부팅 후 자동실행(rc.rocal, init.d, system중 하나 사용) 설정
    - 자동부팅 참고링크( : https://blog.naver.com/PostView.naver?blogId=hdh7485&logNo=221915486713&parentCategoryNo=&categoryNo=69&viewDate=&isShowPopularPosts=false&from=postView
    - 자동 부팅후 ROSCORE 자동실행 :
        - https://dhpark1212.tistory.com/entry/JetsonNano-%EB%B6%80%ED%8C%85-%EC%8B%9C-%EC%9E%90%EB%8F%99-%EC%8B%A4%ED%96%89-%EB%B0%A9%EB%B2%95
        - https://ahnbk.com/?p=1329

8) Usb Port고정
    - USB 포트고정(Raspberry pi : https://jinoan.com/raspberry_pi/2020-08-06-Raspberry-Pi-3-B+-USB-%ED%8F%AC%ED%8A%B8-%EA%B3%A0%EC%A0%95/)

8-1) Usb 속도제한 해제
9) Lidar, IMU를 ROS와 연결
