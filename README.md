# RoombaObstacleAvoidance
This is a project for Digital Control course by Dr. Li Bai at Temple University. Simulink is utilized to control a Roombra and navigate it through an obstacle course using Stateflow. 

## **Intro**
The Simulink library for this project is for controlling a Roomba iRobot via a wifi remote (roowifi). The RooWifi can be bought from(http://www.roowifi.com/products-page/embeddeds/roowifi-roomba-wifi-remote/). The RooWifi is set to the default IP Address (10.0.0.1).
The library has the following blocks:

<img width="530" alt="library blocks" src="https://user-images.githubusercontent.com/31410235/32812257-160d18f4-c972-11e7-9c3a-82db6ff44bd1.PNG">

## **Simulink Library Blocks**


### **init block**

This is the main block that connects the Roomba to Simulink in order to read from the roomba (i.e. sensors) and write to it (i.e. set speed of wheels).
The output of this block `Out1` should be connected to every `in1` input in the other blocks.

### **irv block**
This block reads and displays the 6 IR sensors located in the front of the Roomba.
The irv block outputs a 1x6 vector for the sensors. Where the output is 1 or 0. Where 1 means an obstacle is detected and 0 means no obstacle is detected.
For this project the `Out1` output is connected to the `IR` input in the `WheelV` block.

### **WheelV block**
This block is connected to the init block through the in1 input, the irv block through the IR input, and finally the Temperature block through the Temp input. 



### **Instructions on Adding Roomba Libraries to Simulink library**

1. Download Roomba libraries and unzip the whole folders to the MATLAB document folder
2. In Command window: enter `addpath('directory')` in which directory is the directory of the .m file
3. In command window: enter `savepath`
4. In command window: enter `path` to ensure that the MATLAB path adds the path to the directories
5. Open Simulink library browser and refresh the browser. The Roomba library should be seen and blocks can be dragged or copied into models.


