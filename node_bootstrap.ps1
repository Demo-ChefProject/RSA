#!/bin/bash

#cd ~/home/jenkins/workspace/Chef-apache/
#cd C:/Users/krithi.gananasekaran/workspace/Chef-Jdk
cd C:\Jenkins\workspace\Chef-RSA

#for jdk
#sudo knife role from file /home/jenkins/workspace/Chef-apache/roles/apache.rb
#knife role from file C:\Users\krithi.gnanasekaran\workspace\Chef-Jdk\roles\jdkinstall.rb
knife role from file C:\Jenkins\workspace\Chef-RSA\roles\liferay.json


# Upload cookbooks into Chef Server
knife upload cookbooks rsa


# Bootstrap a node to its chef server
knife bootstrap windows winrm 52.90.146.213 --winrm-user Administrator --winrm-password '?%EW!26tAzW' --node-name Rigil_node_Windows -r 'role[rsa]' -y

#Passing credentials stored as a secure string
$pass = ConvertTo-SecureString '?%EW!26tAzW' -AsPlainText -Force
$Pegacred = new-object -TypeName System.Management.Automation.PSCredential -argumentlist "Administrator",$Pass
#  Create a remote session to the chef node
$Session = New-PSSession -ComputerName 52.90.146.213 -Credential $Pegacred

$Script = {powershell.exe chef-client}

$Job = Invoke-Command -Session $Session -Scriptblock $Script
echo $Job
#Script which runs the ruby script in the remote server


# Exit and remove the current session
Remove-PSSession -Session $Session
