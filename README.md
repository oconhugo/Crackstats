# CrackStats
Repository for CrackStats

## Introduction
The mobile application provides a system to manage soccer leagues. Each player, team owner or league owner needs to create a profile, which includes a password that is encrypted by the system. The profile will have stored the user information, stats, teams, leagues and administrative permissions. The system is self-sustainable, each player requests permission to be added to the team, which is accepted/rejected by the team owner and in the same manner, each time a team wants to be created, it requests permission to a league to be added to it. Leagues are created by application admins. All the information (stats, schedule, team, players, data, etc) is stored in a database. 

Cashier:<br/><br/>
<img src = "Images/csmain.PNG" width = "800" style = "margin-left:auto;margin-right:auto;" > <br/><br/>
Chef: <br/><br/>
<img src = "Images/Capture1.PNG" width = "800">

## Technologies
### Languages
-Python 3
### Libraries
-EasyTkinter 1.1.0<br/>
-PyInstaller 3.6<br/>
-XlsxWriter 1.2.8<br/>
-future 0.18.2<br/>
-openyxl 3.0.3<br/>
-threadsafe-tkinter 1.0.2<br/>

## Prerequisites
The following software is needed to install and run the system:<br/>
		-Python 2.7 or higher<br/>
		
The following hardware is needed to install and run the system:<br/>
		-Two PCs running in a same network<br/>
    
## Installation
For installing the system just download the files and make sure that the two computer that are running the system are on the same network.

## Deployment
Before turning the system on the PCs, we need to make sure that the PCs are connected in the same network and that sockets can communicate.

First, on the chef PC, go to the chef.py program and change the IP to the IP of the chef computer. Then, on the cashier PC, go to client.py and change the IP to the IP of the chef computer.

Now, go to the file explorer on both PC and click on network on the left sidebar. The computers of the system needs to appear on the window, showing they are in the same network. 

After that, open the command window and type the following:<br/>

On cashier: ping *Chef PC IP address* - It needs to show a connection was made successfully<br/>
On chef: ping *Cashier PC IP address*  - It need to show a connection was made successfully<br/>

Then, open Windows Defender Firewall Advanced Security. On the left panel of the window, click on Inbound rules. Create a new rule by clicking on New Rule on the right panel of the window.
Click on port on the new window that pops up. Select TCP rule and type in the specific port you are going to use to connect between the PCs 
(You can select the port by going to the chef.py and server.py files and change it, it needs to be >1024). Click on next until a Name text box appears and put
any desired name for the rule. Then click finished. Do this firewall step for both PCs. You can now run the system.

To run the system, the chef.py must be ran first, as it is the server for the sockets, then cashier needs to be run to connect to the server. 

## Launch
Go to the project folder. First run the chef, as it is going to be the socket server, and after that run the cashier, which is the client socket.

## Description
### Context
This started as a personal project to provide a system for a Mexican taqueria. We got contacted by the owner of a Mexican restaurant, asking us for a system that would optimize his restaurant's ordering procedure.The main problem with his process was that taking the order, sending the order to the cook, and delivering the food were done manually. Consequently, making the ordering and delivery process slower.<br/>
In response to these issues, we created the "Cashier-Chef Ordering System" for the restaurant. The system optimizes the process by providing an interface for the cashier and the cook, allowing them to keep comunication, receive orders faster, and complete them quicker. This can result in sales increases for the restaurant. This system also create an excel file that stores the total sales and earning making the cashier life easier.
		
### What can the project specifically do
The system gets the order form the cashier and sends it to the chef. The chef then obtains the order and it is added to a list. The chef sees his specific
interface on a PC, which contains a list of the orders on the left side, and on the right side the content of the order he clicks. Every order that is
completed on the day, every day, gets stored in an excel file. Each excel file has the orders of the days and its title is the date the orders were taken. The files
also cointains the total orders and sales of each day. All the files are stored in a folder called "Sales" that is created inside the project folder.

### Features
#### Cashier
-Items can be selected from the menu by clicking on the buttons on its interface.<br/>
-Text boxes to choose total cost for certain special items.<br/>
-Select if the order is to go by clicking on a checkbox.<br/>
-See the total cost of the order on its interface. The button "Total" needs to be clicked before sending the order.<br/>
-Interface will reset automatically after sending the order to the chef.<br/>
-The order individual items and cost will be displayed when selected on the cashiers interface.<br/>
-The order can be cancelled at any time before sending it to the chef.<br/>
-Send a note to the chef along with the order.<br/>
-Scrollbars for the item list, when the list is to large. <br/>
-Buttons and special boxes are disabled when clicked on view total. <br/>
#### Chef
-See a list of uncompleted orders.<br/>
-Ability to toggle thru the orders to see its content, by clicking on the order number.<br/>
-Select an order as completed, which would eliminate it from the list.<br/>
-Scrollbar created when the list of items is too big to see in the window. <br/>
#### Others
-A inventory folder is created inside the project folder, if it is not already created.<br/>
-An excel file is generated per day, in which every order is stored, along with the total orders per day and total sales.<br/>
	
### Links
Demo Link: https://www.youtube.com/watch?v=dYPcA2sr3Pc

## Usage
This system can be used in any restaurant where the order is taken by a cashier. This particular code was made with a menu for a Mexican restaurant, but it can easily be modified to fit the menu of any restaurant.

## Support
For any questions, do not hesistate to contact the authors.

## Roadmap
In the future, we will connect the system to a ticket machine and print a ticket for the client. This will happen when the system is implemented on a restaurant.

## Authors and Acknowledgements
Alejandro Ibarra Polanco - alejandro.ibarra.p@gmail.com <br/> Hugo Ocon - oconhugo14@gmail.com

## Project Status
Complete
