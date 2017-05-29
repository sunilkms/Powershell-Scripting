function Join-Objects 
{
  PARAM
  (
     $FirstObject,
     [string]$FirstJoinColumn,
     $SecondObject,
     [string]$SecondJoinColumn#=$FirstJoinColumn
  )
  PROCESS 
  {

    foreach($d in $FirstObject) 
    { 
      $t = $SecondObject | Where-Object {$_.($SecondJoinColumn) -eq $d.($FirstJoinColumn) } 

      $t1 = $d | select *

      foreach ($p in Get-Member -InputObject $t -MemberType NoteProperty) 
      {
        Add-Member -InputObject $t1 -MemberType NoteProperty -Name $p.Name -Value $t.$($p.Name) -Force 
        $t1.$($p.Name) = $t.$($p.Name) 
      }

      $t1
    }
  }
}


#Test Example
#$brh015ad=Get-ADUser -filter {SamAccountName -like "brh015*"}|Select-Object SamAccountName,DistinguishedName
#$brh015Rcpt=Get-Recipient -filter {Alias -like "brh015*"}|Select-Object Alias,PrimarySMTPAddress
#$Merged=Join-Objects $brh015AD, "SamAccountName", $brh015Rcpt, "Alias"
#$Merged
