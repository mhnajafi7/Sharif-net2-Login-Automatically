#! /bin/bash
##This script is created by Mohammad H Najafi in June 2023

###### Edit this
#login information
username="username" 	 #Enter your username
password="password"	 #Enter your password
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
