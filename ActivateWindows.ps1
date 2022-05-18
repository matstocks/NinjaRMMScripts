#Check current activation state
Get-CIMInstance -query "select Name, Description, LicenseStatus from SoftwareLicensingProduct where LicenseStatus=1" | Format-List Name, Description, LicenseStatus

#Retrieve Mainboard Baked In Activation Key
$BakedKey = (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey

#Set Baked Key As Primary Activation Key
slmgr.vbs /ipk $BakedKey

#Perform Online Activation Using This Key
slmgr.vbs /ato

#Finally Confirm That Activation Worked
Get-CIMInstance -query "select Name, Description, LicenseStatus from SoftwareLicensingProduct where LicenseStatus=1" | Format-List Name, Description, LicenseStatus


