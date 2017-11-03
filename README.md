# RoombaObstacleAvoidance
This is a project for Digital Control course at Temple University. Simulink is utilized to control a Roombra and navigate it through an obstacle course. 

##**Intro**
The Simulink library for this project is for controlling a Roomba iRobot via a wifi remote (roowifi). The RooWifi can be bought from(http://www.roowifi.com/products-page/embeddeds/roowifi-roomba-wifi-remote/). The RooWifi is set to the default IP Address (10.0.0.1).

###**Instructions on Adding Roomba Libraries to Simulink library**

1. Download Roomba libraries and unzip the whole folders, including multiple .m files, to the MATLAB document folder
2. Locate the "slblocks.m" file in each custom library folder
3. In MATLAB command window, enter addpath('directory') in which directory is the directory of the slblocks.m file
4. In MATLAB command window, enter savepath
5. In MATLAB command window, enter path to make sure that the MATLAB path includes the path to these directories
6. Open Simulink library browser and refresh the browser. The Roomba library should be seen in the browser, and blocks can be dragged or copied into Simulink models like the inherent blocks
