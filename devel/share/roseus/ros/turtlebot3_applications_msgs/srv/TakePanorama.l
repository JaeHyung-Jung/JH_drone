;; Auto-generated. Do not edit!


(when (boundp 'turtlebot3_applications_msgs::TakePanorama)
  (if (not (find-package "TURTLEBOT3_APPLICATIONS_MSGS"))
    (make-package "TURTLEBOT3_APPLICATIONS_MSGS"))
  (shadow 'TakePanorama (find-package "TURTLEBOT3_APPLICATIONS_MSGS")))
(unless (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMA")
  (make-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMA"))
(unless (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST")
  (make-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(unless (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMARESPONSE")
  (make-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMARESPONSE"))

(in-package "ROS")





(intern "*SNAPANDROTATE*" (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(shadow '*SNAPANDROTATE* (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(defconstant turtlebot3_applications_msgs::TakePanoramaRequest::*SNAPANDROTATE* 0)
(intern "*CONTINUOUS*" (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(shadow '*CONTINUOUS* (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(defconstant turtlebot3_applications_msgs::TakePanoramaRequest::*CONTINUOUS* 1)
(intern "*STOP*" (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(shadow '*STOP* (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(defconstant turtlebot3_applications_msgs::TakePanoramaRequest::*STOP* 2)
(intern "*STARTED*" (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(shadow '*STARTED* (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(defconstant turtlebot3_applications_msgs::TakePanoramaRequest::*STARTED* 0)
(intern "*IN_PROGRESS*" (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(shadow '*IN_PROGRESS* (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(defconstant turtlebot3_applications_msgs::TakePanoramaRequest::*IN_PROGRESS* 1)
(intern "*STOPPED*" (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(shadow '*STOPPED* (find-package "TURTLEBOT3_APPLICATIONS_MSGS::TAKEPANORAMAREQUEST"))
(defconstant turtlebot3_applications_msgs::TakePanoramaRequest::*STOPPED* 2)

(defun turtlebot3_applications_msgs::TakePanoramaRequest-to-symbol (const)
  (cond
        ((= const 0) 'turtlebot3_applications_msgs::TakePanoramaRequest::*SNAPANDROTATE*)
        ((= const 1) 'turtlebot3_applications_msgs::TakePanoramaRequest::*CONTINUOUS*)
        ((= const 2) 'turtlebot3_applications_msgs::TakePanoramaRequest::*STOP*)
        ((= const 0) 'turtlebot3_applications_msgs::TakePanoramaRequest::*STARTED*)
        ((= const 1) 'turtlebot3_applications_msgs::TakePanoramaRequest::*IN_PROGRESS*)
        ((= const 2) 'turtlebot3_applications_msgs::TakePanoramaRequest::*STOPPED*)
        (t nil)))

(defclass turtlebot3_applications_msgs::TakePanoramaRequest
  :super ros::object
  :slots (_mode _pano_angle _snap_interval _rot_vel ))

(defmethod turtlebot3_applications_msgs::TakePanoramaRequest
  (:init
   (&key
    ((:mode __mode) 0)
    ((:pano_angle __pano_angle) 0.0)
    ((:snap_interval __snap_interval) 0.0)
    ((:rot_vel __rot_vel) 0.0)
    )
   (send-super :init)
   (setq _mode (round __mode))
   (setq _pano_angle (float __pano_angle))
   (setq _snap_interval (float __snap_interval))
   (setq _rot_vel (float __rot_vel))
   self)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:pano_angle
   (&optional __pano_angle)
   (if __pano_angle (setq _pano_angle __pano_angle)) _pano_angle)
  (:snap_interval
   (&optional __snap_interval)
   (if __snap_interval (setq _snap_interval __snap_interval)) _snap_interval)
  (:rot_vel
   (&optional __rot_vel)
   (if __rot_vel (setq _rot_vel __rot_vel)) _rot_vel)
  (:serialization-length
   ()
   (+
    ;; uint8 _mode
    1
    ;; float32 _pano_angle
    4
    ;; float32 _snap_interval
    4
    ;; float32 _rot_vel
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _mode
       (write-byte _mode s)
     ;; float32 _pano_angle
       (sys::poke _pano_angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _snap_interval
       (sys::poke _snap_interval (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rot_vel
       (sys::poke _rot_vel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _mode
     (setq _mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _pano_angle
     (setq _pano_angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _snap_interval
     (setq _snap_interval (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rot_vel
     (setq _rot_vel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass turtlebot3_applications_msgs::TakePanoramaResponse
  :super ros::object
  :slots (_status ))

(defmethod turtlebot3_applications_msgs::TakePanoramaResponse
  (:init
   (&key
    ((:status __status) 0)
    )
   (send-super :init)
   (setq _status (round __status))
   self)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:serialization-length
   ()
   (+
    ;; uint8 _status
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _status
       (write-byte _status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass turtlebot3_applications_msgs::TakePanorama
  :super ros::object
  :slots ())

(setf (get turtlebot3_applications_msgs::TakePanorama :md5sum-) "51aa7cafe47f8d721c031cb234513c3b")
(setf (get turtlebot3_applications_msgs::TakePanorama :datatype-) "turtlebot3_applications_msgs/TakePanorama")
(setf (get turtlebot3_applications_msgs::TakePanorama :request) turtlebot3_applications_msgs::TakePanoramaRequest)
(setf (get turtlebot3_applications_msgs::TakePanorama :response) turtlebot3_applications_msgs::TakePanoramaResponse)

(defmethod turtlebot3_applications_msgs::TakePanoramaRequest
  (:response () (instance turtlebot3_applications_msgs::TakePanoramaResponse :init)))

(setf (get turtlebot3_applications_msgs::TakePanoramaRequest :md5sum-) "51aa7cafe47f8d721c031cb234513c3b")
(setf (get turtlebot3_applications_msgs::TakePanoramaRequest :datatype-) "turtlebot3_applications_msgs/TakePanoramaRequest")
(setf (get turtlebot3_applications_msgs::TakePanoramaRequest :definition-)
      "########################################
# CONSTANTS
########################################
uint8 SNAPANDROTATE=0 # mode: rotate, stop, snapshot, rotate, stop, snapshot, ...
uint8 CONTINUOUS=1    # mode: keep rotating while taking snapshots
uint8 STOP=2          # mode: stop an ongoing panorama creation

uint8 STARTED=0       # status
uint8 IN_PROGRESS=1   # status
uint8 STOPPED=2       # status

########################################
# Messages
########################################
uint8 mode            # mode for taking the pictures
float32 pano_angle    # total angle of panorama picture
float32 snap_interval # angle interval when creating the panorama picture in snap&rotate mode, time interval otherwise 
float32 rot_vel       # rotating velocity
---
uint8 status

")

(setf (get turtlebot3_applications_msgs::TakePanoramaResponse :md5sum-) "51aa7cafe47f8d721c031cb234513c3b")
(setf (get turtlebot3_applications_msgs::TakePanoramaResponse :datatype-) "turtlebot3_applications_msgs/TakePanoramaResponse")
(setf (get turtlebot3_applications_msgs::TakePanoramaResponse :definition-)
      "########################################
# CONSTANTS
########################################
uint8 SNAPANDROTATE=0 # mode: rotate, stop, snapshot, rotate, stop, snapshot, ...
uint8 CONTINUOUS=1    # mode: keep rotating while taking snapshots
uint8 STOP=2          # mode: stop an ongoing panorama creation

uint8 STARTED=0       # status
uint8 IN_PROGRESS=1   # status
uint8 STOPPED=2       # status

########################################
# Messages
########################################
uint8 mode            # mode for taking the pictures
float32 pano_angle    # total angle of panorama picture
float32 snap_interval # angle interval when creating the panorama picture in snap&rotate mode, time interval otherwise 
float32 rot_vel       # rotating velocity
---
uint8 status

")



(provide :turtlebot3_applications_msgs/TakePanorama "51aa7cafe47f8d721c031cb234513c3b")


