# RoombaObstacleAvoidance
This is a project for Digital Control course by Dr. Li Bai at Temple University. Simulink is utilized to control a Roombra and navigate it through an obstacle course using Stateflow. 

## **Intro**
The Simulink library for this project is for controlling a Roomba iRobot via a wifi remote (roowifi). The RooWifi can be bought from(http://www.roowifi.com/products-page/embeddeds/roowifi-roomba-wifi-remote/). The RooWifi is set to the default IP Address (10.0.0.1).

## **Simulink Library Blocks**

### **init block**
RoombaObstacleAvoidance/Figures/initilization.PNG
![ScreenShot](RoombaObstacleAvoidance/Figures/initilization.PNG)




















### **Instructions on Adding Roomba Libraries to Simulink library**

1. Download Roomba libraries and unzip the whole folders to the MATLAB document folder
2. In Command window: enter `addpath('directory')` in which directory is the directory of the .m file
3. In command window: enter `savepath`
4. In command window: enter `path` to ensure that the MATLAB path adds the path to the directories
5. Open Simulink library browser and refresh the browser. The Roomba library should be seen and blocks can be dragged or copied into models.


