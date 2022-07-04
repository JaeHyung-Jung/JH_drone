* 필요한 것들 : USB젠더, 키보드.마우스, Xavier 파워선, Usb(C to USB), HDMI 선

1) Ubuntu PC(Host)와 Xavier연결, Xavier 파워 연결하고 키보드마우스, 모니터 연결
2) Ubuntu에 SDK Manager 설치 (Ubuntu version에 맞게 설치)
3) SDK Manager 실행 $sdkmanager
4) SDK Manager에서 NVIDIA login 후 Xavier에 OS flash, flash 후 install
    - SDK Manager에서 Manual setup으로 진행, recovery 버튼을 먼저 누르고있는 상태에서 power버튼 같이 2초정도 눌렀다가 떼기, Xavier에 인터넷연결(LAN or Wifi)하고 ifconfig통해 ip확인해서 ip, Xavier desktop id, pw 입력 => 설치 시작
    - https://jstar0525.tistory.com/58 (설치 참고 링크)
    - 설치 후 Xavier에서 설치 완료 확인 
    -   $ cd ~/VisionWorks-SFM-0.90-Samples
    -   $ ./bin/aarch64/linux/release/nvx_sample_sfm
    -   $ nvcc -V
    -   설치 완료확인 됐으면 xavier 업데이트 ($ sudo apt-get update && sudo apt-get upgrade)
- 4-1) ROS설치
    - ROS설치과정에서 sudo apt update에서 오류가 나거나 sudo apt-get install ros-noetic-(.. 생략)에서 package가 없다는 오류가 발생한다. 이 경우 
        - 1) sudo apt --fix borken install -o Dpkg::Options::="--force overwrite" => fix broken 안될경우
        - or 2) $ sudo sed -i -e 's|disco|focal|g' /etc/apt/sources.list , $ sudo apt update
5) Xavier 자동실행 확인
    - 자동부팅 참고링크( : https://blog.naver.com/PostView.naver?blogId=hdh7485&logNo=221915486713&parentCategoryNo=&categoryNo=69&viewDate=&isShowPopularPosts=false&from=postView
    - 자동 부팅후 ROSCORE 자동실행 :
        - https://dhpark1212.tistory.com/entry/JetsonNano-%EB%B6%80%ED%8C%85-%EC%8B%9C-%EC%9E%90%EB%8F%99-%EC%8B%A4%ED%96%89-%EB%B0%A9%EB%B2%95
        - https://ahnbk.com/?p=1329

6) Usb Port고정
    - USB 포트고정(Raspberry pi : https://jinoan.com/raspberry_pi/2020-08-06-Raspberry-Pi-3-B+-USB-%ED%8F%AC%ED%8A%B8-%EA%B3%A0%EC%A0%95/)

7) Xavier 
8) Usb 속도제한 해제
9) Lidar 기본 세팅
10) IMU 세팅
