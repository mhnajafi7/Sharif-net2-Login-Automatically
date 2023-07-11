# Sharif-net2-Login-Automatically
To be able to connect to the Internet, the system must log into my account at net2.sharif.edu. That's why I wrote a script that automatically logs in to this account every time reboots the system and every 100 seconds by checking the Internet connection, If it is out of the account, it will log in again.

The script will prompt the user to enter their username and password, which is then securely
stored using built-in Bash functionality. The script then checks whether an input argument has
been provided. This argument specifies the time interval between subsequent checks for Internet
connectivity. If no argument is provided, the script displays an error message and exits.

The script defines two functions: login and check. The login function uses the curl command to
send a POST request to the net2 website with the user’s login credentials. If the login is successful,
the script saves the resulting cookies to a file for future use.

The check function checks Internet connectivity by sending a request to Google’s public DNS server
using the ping command. If a response is received, the function exits. If no response is received,
the function calls the login function to attempt to re-establish the connection.

Finally, the main loop of the script continuously calls the check function with a delay specified by
the input argument. This loop runs indefinitely until the script is terminated manually.

By automating the login process and continuously checking for Internet connectivity, this script
allows us to establish and maintain a reliable connection to the net2 website without manual
intervention

## Bash Script
```bash
    #! /bin/bash
	##This script is created by Mohammad H Najafi in June 2023
	
	###### Edit this
	#login information
	username="username" 	 #Enter your username
	password="password"	     #Enter your password
	###
	
	
	
	
	# time period to check connection
	periodtime=$1
	###
	
	# if the first argument doesn't exist
	if [ -z $periodtime ]
	then 
	echo "Error: the first argument is missing!"
	echo
	echo "Please enter like this format: ./net2_login.sh <time_period>"
	exit 1 		#error occured siganling
	fi
	###
	
	# function for POST the username and pssword to login URL
	function login(){
		curl -sL -d "username=$username&password=$password" "https://net2.sharif.edu/login"
		echo "You are logged in to sharif net2"
		#fi
	}
	###
	
	# function to check internet connection
	function check(){
		if ! ping -c 1 google.com &> /dev/null; then
		
		login
		
		fi
	}
	###
	
	# first login
	login
	###
	
	# loop for check connection
	while true; do
	check
	sleep $periodtime
	done
	###
```

## Service
To run this script every time the system boots, we need to create a service. The service can be
defined as follows:

```service
    [Unit]
	Description=Login to net2.sharif.edu
	After=network.target

	[Service]
	WorkingDirectory=/home/orangepi/
	ExecStart=/bin/bash /path/net2_login.sh 100
	Restart=on-failure

	[Install]
	WantedBy=multi-user.target
```

After saving this file to a specified path for services, we can activate it by running the following commands so that it runs every time the system boots.
```bash
    $ sudo systemctl systemctl daemon-reload  
    $ sudo systemctl enable resource_monitor.service
    $ sudo systemctl start resource_monitor.service
    $ sudo systemctl status resource_monitor.service
```
To view the logs for the service, use the journalctl command:
```bash
$ sudo journalctl -u resource_monitor.service
```
<a target="blank"><img align="center" src="net2.png" height="50" /></a>