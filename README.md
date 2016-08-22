Sam Borowsky
ScoopU mobile app
ReadMe.txt
07/12/2016

====================
OVERVIEW:
====================

ScoopU is an iOS application conceived and developed by four Washington & Lee University students. In its original phase, the app functions as a ride sharing platform exclusively for students. At any given time, the user can be a rider or a driver. When seeking a ride, the user browses available drivers and negotiates a potential ride and price via phone call. To serve as a driver, the user toggles his driving status to "On" and is then displayed within the app as an available driver.

To register as a ScoopU user:
	- Launch the app and wait for the "Welcome To Scoop" sign up page to load.
	- Fill out each text field (first name, last name, cell phone number, university-issued email address).
		** NOTE: To ensure that ONLY W&L students can register, we only accept email addresses ending in "@mail.wlu.edu". Once the user hits the "Sign Up" button, the app sends a message to the provided email address. Then, the new user clicks the link in the validation message and is granted access to the rest of the app. **
		** NOTE: Apple App Store evaluators, professional recruiters, and others who obviously do not have a W&L email can use the address "demo@scoop.com", which bypasses email verification and transitions into the rest of the app after hitting "Sign Up." **

Now, the home page of the app shows the title "Scoop Feed" and corresponds to the "News" tab on the navigation bar. This is a live, user-generated table of drop off reports. Each cell feaures:
	- A photo selected from the iPhone camera roll
	- A descripton of the form "<name> got scooped to <drop off location>."
	- A like button (heart shaped) and total likes count
	- The age of the report. The reports in the Scoop Feed are ordered by age (newest to oldest).
To generate a new report:
	- Click the pencil and paper button on the top right of the page.
	- Fill out the "Name" (must contain first and last) and "Location/Place" fields and select a photo by clicking the circular gray button above "Submit."
	- Click the "Submit" button.  

Navigate to the "Available Drivers" page by clicking the "Scoop Me" tab on the navigation bar. This is a listing of students who are currently available to give rides. Each table cell pertains to one driver and contains:
	- A photo of the driver
	- The driver's first name
	- The driver's car information (make and model)
	- The driver's cell phone number - click it to call him or her
	- The driver's proximity to the user, which updates each time the "Available Drivers" tab is visited. The available drivers table is ordered by driver proximity.
		** NOTE: ScoopU is currently off the App Store because of some minor legal hurdles. We thus do not have any live available drivers, so sample drivers temporarily demonstrate exactly how the app behaves when live. More details about our legal troubles and how we are overcoming them are explained later. **

Click the "Scoop Up" tab on the navigation bar to update your driving status. If the button on this page is red and says "Scoop Up: Off", click it to switch your driving status to "On". Now, the button is green and says "Scoop Up: On", and each user sees your information in the "Available Drivers" tab. To turn your driving status back to "Off", click the button again. This removes your table cell from the "Available Drivers" table, and users can no longer contact you for rides.
	** NOTE: Again, this feature of the app is not live at the moment, as the "Available Drivers" table is currently populated by sample data rather than actual users. **

Lastly, the user views and edits his/her profile by clicking the "Profile" tab on the navigation bar. This page displays the information that was submitted during registration (first name, last name, email, phone number). Also, the user can add and edit his/her car type and profile photo. All fields are editable besides email address, as we require the user to stick with his/her W&L email address. To save any changes, click the "Update" button.


====================
UPDATES IN PROGRESS
====================

The main legal trouble we encountered with the original concept is that drivers are being paid for giving rides. In this way, they function as unregistered taxis, which is illegal in Virignia. So, we have tweaked the concept of the app to address this issue. The changes we are implementing include:
	- Upon registration, the user selects his/her Greek affiliation (fraternity/sorority membership).
	- The home page of the app is a live feed of events customized to his/her Greek affiliation. In other words, a particular user sees   only the upcoming events that his/her fraternity or sorority is invited to.
	- A user that has admin. privileges (a social chair of a fraternity, for example) can post a new event, which:
		- details the event name, location, start and end times, and a brief description of the event
		- selects Greek organizations that are invited.
	-Available drivers are now associated with a specific event, and a user must link himself/herself to an active event upon switching his/her driving status from "Off" to "On."
	-When a user clicks an event on his/her event feed, it expands to display the drivers for that event.
In this new concept, students do not act as independent drivers who are paid for their services. Rather, they serve as the (unpaid) sober drivers that Washington & Lee requires for fraternity/sorority events. Effectively, the app has been beefed up to function as a social calendar and ride sharing platform. Several of these updates have already been implemented, and the rest are still in progress. 


====================
TECHNICAL: 
====================
IDE: Xcode 6.4
Language: Objective-C
