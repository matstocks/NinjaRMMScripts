function installsoftware {
  
  #This script is specifically for downloading ZIP files, extracting them and running an enclosed MSI installer
  #Set the variables here to be used in the rest of the script
  $url = 'INSERT URL HERE'
  $output = "C:\build\EPSetup.zip"
  $zip_extract_folder = "C:\build\EPSetup"
  $path = "c:\build"
  $log_date = Get-Date -Format "MM-dd-yyyy-HHmmss"
  $msi_location = "c:\build\EPSetup\EPStandard\Easyplan.msi"
  
  #Start a timer
  $start_time = Get-Date
  Write-Output "Variables set. They are as follows:" 
  Write-Output "Download URL is $url"
  Write-Output "This will be saved to $output"
  Write-Output "The path is $path"
  Write-Output "The process was started at $start_time"
  Write-Output "The MSI installer is $msi_location"
  
  #Check the build directory exists
  Write-Output "Checking that $path exists..."
  If (!(test-path $path))
  {
      Write-Output "$path does not exist...creating path"
      md $path
  }
  
  If ((test-path $path))
  {
      Write-Output "$path does exist...continuing"
  }
  
  #Download the file to the output path
  Write-Output "Downloading package from $url and saving to $output ..."
  (New-Object System.Net.WebClient).DownloadFile($url, $output)
  
  #Extraxt the ZIP file
  Write-Output "Extracting zip $output ..."
  Expand-Archive $output -DestinationPath $zip_extract_folder
  
  #Run the installation
  Write-Output "Running Installation... Command being used is: msiexec /i $msi_location /qn /l $path\$log_date-action.log"
  cmd.exe /c "msiexec /i $msi_location /qn /l $path\$log_date-action.log"
  Write-Output - "In the event of failure the MSI installation Log is located at $path\$log_date-action.log"
  #End the timer and output how long it took
  Write-Output "Script completed. Total time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
  Write-Output "#########################################################################################"
  
}

installsoftware | Out-File c:\windows\temp\NinjaScript.txt -Append
