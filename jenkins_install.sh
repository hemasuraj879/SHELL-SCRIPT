 #!/bin/bash

DATE=$(date +%F)
LOGSDIR=/tmp
# /home/centos/shellscript-logs/script-name-date.log
SCRIPT_NAME=$0
LOGFILE=$LOGSDIR/$0-$DATE.log
USERID=$(id -u)

if [ $USERID -ne 0 ];
then
    echo -e " ERROR:: Please run this script with root access "
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];
    then
        echo -e "$2 ... FAILURE"
        exit 1
    else
        echo -e "$2 ...  SUCCESS"
    fi
}
  
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo &>> $LOGFILE
VALIDATE $? "Adding repo"

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key &>> $LOGFILE
VALIDATE $? "Importing keys" 

yum install fontconfig java-17-openjdk -y &>> $LOGFILE
VALIDATE $? "Installing Java"
# Install java version

yum install jenkins -y &>> $LOGFILE
VALIDATE $? "Installing jenkins"
# Install jenkins

systemctl start jenkins &>> $LOGFILE
VALIDATE $? "Starting jenkins"
# Starting jenkins

systemctl enable jenkins &>> $LOGFILE
VALIDATE $? "Enabling jenkins"
# Enabling jenkins

