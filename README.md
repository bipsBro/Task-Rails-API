# README


* Ruby version
	ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]

* Database MySql config in /config/database.yml
	need to set
	> username
	> password

* Set Slack Api Bearer token in /app/controller/api/v1/leaves_controller.rb in line no 52

Run Process

* Start mysql server first
* run rails server

API points
* for login process
	> POST /api/v1/session

	
* for leave fatch
	> GET /api/v1/leaves
* for leave create
	> POST /api/v1/leaves