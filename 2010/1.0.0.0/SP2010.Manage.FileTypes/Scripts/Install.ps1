$SolutionFolder = "./"
$SolutionName = "SP2010.Manage.FileTypes.wsp"

$AdminServiceName = "SPAdminV4"
$IsAdminServiceWasRunning = $true;

Add-PSSnapin microsoft.sharepoint.powershell

if ($(Get-Service $AdminServiceName).Status -eq "Stopped")
{
    $IsAdminServiceWasRunning = $false;
    Start-Service $AdminServiceName       
}

Write-Host


Write-Host "Rectracting solution: $SolutionName" -NoNewline
    $Solution = Get-SPSolution | ? {($_.Name -eq $SolutionName) -and ($_.Deployed -eq $true)}
    if ($Solution -ne $null)
    {
        if($Solution.ContainsWebApplicationResource)
        {
            Uninstall-SPSolution $SolutionName -AllWebApplications -Confirm:$false
        }
        else
        {
            Uninstall-SPSolution $SolutionName -Confirm:$false
        }
    }
    
    while ($Solution.JobExists)
    {
        Start-Sleep 2
    }
Write-Host " - Done."
    
Write-Host "Removing solution: $SolutionName" -NoNewline
    if ($(Get-SPSolution | ? {$_.Name -eq $SolutionName}).Deployed -eq $false)
    {
        Remove-SPSolution $SolutionName -Confirm:$false
    } 
Write-Host " - Done."
Write-Host

Write-Host "Adding solution: $SolutionName" -NoNewline
    $SolutionPath = $SolutionFolder + $SolutionName
    Add-SPSolution $SolutionPath | Out-Null
Write-Host " - Done."
    
Write-Host "Deploying solution: $SolutionName" -NoNewline
    $Solution = Get-SPSolution | ? {($_.Name -eq $SolutionName) -and ($_.Deployed -eq $false)}
    if(($Solution -ne $null) -and ($Solution.ContainsWebApplicationResource))
    {
        Install-SPSolution $SolutionName -AllWebApplications -GACDeployment -Confirm:$false
    }
    else
    {
        Install-SPSolution $SolutionName -GACDeployment -Confirm:$false
    }
    while ($Solution.Deployed -eq $false)
    {
        Start-Sleep 2
    }
Write-Host " - Done."
    
if (-not $IsAdminServiceWasRunning)
{
    Stop-Service $AdminServiceName     
}

Echo Finish