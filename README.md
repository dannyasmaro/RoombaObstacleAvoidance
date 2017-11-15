# RoombaObstacleAvoidance
This is a project for Digital Control course by Dr. Li Bai at Temple University. Simulink is utilized to control a Roombra and navigate it through an obstacle course using Stateflow. This project involved using two parallel conditions (one for Obstacle avoidance & one for the temperature).

## **Introduction**

The library for the project is titled `DigiConLib.mdl` while the example model is titled `AsmaroProject2.slx.` The remaining files attached are those needed to run the model. It's important to save all the files in the same path. 

The Simulink library for this project is for controlling a Roomba iRobot via a wifi remote (roowifi). The RooWifi can be bought from(http://www.roowifi.com/products-page/embeddeds/roowifi-roomba-wifi-remote/). The RooWifi is set to the default IP Address (10.0.0.1).
The library has the following blocks:

<img width="530" alt="library blocks" src="https://user-images.githubusercontent.com/31410235/32812257-160d18f4-c972-11e7-9c3a-82db6ff44bd1.PNG">

## **Simulink Library Blocks**


### **Initilization block**

<img width="173" alt="initilization" src="https://user-images.githubusercontent.com/31410235/32812353-90c826ec-c972-11e7-9786-1c77d40295a9.PNG">

This is the main block that connects the Roomba to Simulink in order to read from the roomba (i.e. sensors) and write to it (i.e. set speed of wheels).
The output of this block `Out1` should be connected to every `in1` input in the other blocks.

### **Infrared Sensor block**

<img width="155" alt="ir 6 sensors" src="https://user-images.githubusercontent.com/31410235/32812377-aa811166-c972-11e7-888c-613cf3c4dd2c.PNG">

This block reads and displays the 6 IR sensors located in the front of the Roomba.
The irv block outputs a 1x6 vector for the sensors. Where the output is 1 or 0. Where 1 means an obstacle is detected and 0 means no obstacle is detected.
For this project the `Out1` output is connected to the `IR` input in the `WheelV` block.


### **Temperature Block**

<img width="151" alt="temperature" src="https://user-images.githubusercontent.com/31410235/32812451-065ca3a6-c973-11e7-8d29-f1de9cb5e5b1.PNG">

This block ensures that the Roomba turns off, if the Rommba's Temperature increases past 85%. If the Temperature exceeds 85, the Roombs stops moving and turns off. 

### **Controller block**

<img width="175" alt="wheel velocity" src="https://user-images.githubusercontent.com/31410235/32812402-c211c91a-c972-11e7-9f83-53e9f511cd4e.PNG">

This block is connected to the init block through the in1 input, the irv block through the IR input, and finally the Temperature block through the Temp input. 

## **Controller Flow Chart Logic**
The flow chart logic for the roomba is simple. It uses each sensor to determine whether to turn left, right, or straight. There are six logic blocks for each sensor for the roomba.
<img width="624" alt="flow chart" src="https://user-images.githubusercontent.com/31410235/32866272-e4c312ee-ca34-11e7-8ba4-98a508f5d8da.PNG">

### **Instructions on Adding Roomba Libraries to Simulink library**

1. Download Roomba libraries and unzip the whole folders to the MATLAB document folder
2. In Command window: enter `addpath('directory')` in which directory is the directory of the .m file
3. In command window: enter `savepath`
4. In command window: enter `path` to ensure that the MATLAB path adds the path to the directories
5. Open Simulink library browser and refresh the browser. The Roomba library should be seen and blocks can be dragged or copied into models.


