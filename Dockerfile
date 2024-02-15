# Under this line comand which define version of docker syntax. Common we can't use this. 
# syntax=docker/dockerfile:1

# Here base Docker image. We use for youbot linux ubuntu 16.04.
# More any images is access in Dockerhub.
FROM ubuntu:16.04

# Install app dependencies.

RUN apt-get update && apt-get install -y apt-utils		\
                                         lsb-release	\
                                         mesa-utils		\
                                         gnupg2			\
                                         net-tools		\
                                         build-essential	\
                                         wget	\
                                         unzip	\
                                         curl	\
                                         git	\
                                         gedit	\
                                         mc


# Install ros-kinetic-desktop-full
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y ros-kinetic-desktop-full &&	\
			rosdep init && rosdep update &&	\
			echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc


RUN apt-get install -y 	cmake	\
						libncurses5-dev	\
						ros-kinetic-catkin	\
						libbluetooth-dev	\
						ros-kinetic-joystick-drivers	\
						ros-kinetic-moveit-visual-tools	\
						ros-kinetic-joy	\
						ros-kinetic-ros-control \
						ros-kinetic-ros-controllers	\
						ros-kinetic-pr2-msgs 	\
						ros-kinetic-brics-actuator 	\
						ros-kinetic-moveit	\
						libncursesw5-dev	\
						make	\
						python3-pip	\
						python3

#RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
#RUN python get-pip.py
#RUN pip install ds4drv

COPY youbot_driver /root/youbot_driver
COPY youbot_description/ /root/youbot_description/
COPY youbot_diagnostics/ /root/youbot_diagnostics/
COPY youbot_applications/ /root/applications/
COPY youbot_navigation/ /root/youbot_navigation/
COPY youbot-ros-pkg/ /root/youbot-ros-pkg/
COPY youbot_simulation/ /root/youbot_simulation/
COPY cob_common/ /root/cob_common/
COPY ds4drv/ root/ds4drv

RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
RUN echo "export ROS_PACKAGE_PATH=\$ROS_PACKAGE_PATH:/root/youbot_driver:\
/root/youbot_ros_pkg:/root/applications" >> ~/.bashrc
RUN . ~/.bashrc


