#!/usr/bin/bash
tput setaf 1
echo "This script creates the user"
echo "Author: Himalaya Sahu"
tput setaf 15
echo "From which source do you want to create user?"
tput setaf 10
echo "PRESS 1 : To create user directly from input "
echo "PRESS 2 : To create user from database file"
while : 
do	tput setaf 13
	read -p "Enter your choice : " choice
	if [ -z $choice ]
	then 
		tput setaf 3
		echo "Please provide the input"
	else
		if [ $choice == "1" ]
		then
			tput setaf 15
			read -p "Enter username: " user
			if id $user &> /dev/null
			then
				tput setaf 3
				echo "User Already exists!! " 
			else
				useradd $user > /dev/null
				if id $user &> /dev/null
				then
					tput setaf 14
					echo "$user user successfully created"
					id $user
					tput setaf 15
					read -p"Want to set password for this user?(y/n): " option
					if [ -z $option ]
					then 
						tput setaf 3
						echo "Please provide the input"
					else
						if [ $option == "y" ]
						then
							tput setaf 15
							read -p "Please enter $user user's password: " password
							echo $password | passwd --stdin $user &> /dev/null
						        tput setaf 14
							echo "password for user $user has been successfully setup"
							tput setaf 7
							exit 0	
						else
							tput setaf 7
							exit 0 
						fi
					fi
				else
					echo "$user not created"
				fi
			fi
		else
			if [ $choice == "2" ]
			then
				tput setaf 15
				read -p "Please provide absolute path of the user database: " path
				if [ -e $path ]
				then
					user=$(cat $path)
					tput setaf 14
					for i in  $user
					do 
						if id $i &> /dev/null
		                        	then
	    				                tput setaf 3
							echo "$i user Already exists!! "
						else			
							useradd $i 
							tput setaf 14
							echo "$i user successfully created"
						fi
					done
					tput setaf 7
					echo "All the usernames provided in the database file have been successfully created !!!"
					exit 0
				else
					echo "File $path does not exists"
				fi
			else
				tput setaf 3
				echo "Invalid Option"
			fi

			
		fi
	fi
done
