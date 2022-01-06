#--------------------------------------------------------------
# Genrate ips from CDR.
# the script give you ips if you give the cdr range in the 
# input file example:192.168.10.0/24
#--------------------------------------------------------------
param (
        $Inputfile="IpswithCDR-Range.txt",
        $Outputfile="IPs.txt"
      )

$data= gc $inputfile

foreach ($ip in $data) 
{
        if ($ip -match "/32") 
                {
                $cdr=$ip.split("/")[1]
                ""
                Write-Host "****************************************************"
                write-host "Processing CDR:$cdr"
                Write-Host "****************************************************"

                $ip=$ip.Split("/")[0]
                Write-host "IP:$ip"
                #$ip | Add-Content -Path $Outputfile
                }

        if ($ip -match "/") 
                {
                $cdr=$ip.split("/")[1]
                sleep 2

                ""
                Write-Host "****************************************************"
                write-host "Processing CDR:$cdr"
                Write-Host "****************************************************"

                $ips=switch ($cdr)
                {
                      24 {254}
                      25 {128} 
                      26 {64}
                      27 {32}
                      28 {16}
                      29 {8}
                      30 {4}
                      31 {2}
                      32 {1}
                }

                $ip=$ip.split("/")[0]
                Write-Host "IP:$ip"                
                if ($ip.split(".")[3] -eq 0) 
                                            {
                                             $firstt=1
                                             Write-Host "First:$firstt"                                             
                                             $last=$ips
                                             Write-Host "Last:$last"
                                            } 
                else   {
                        $first=$ip.split(".")[3]
                        $firstt=[int]$first + 1
                        Write-Host "First:$first"
                        $last=[int]$([int]$first + [int]$ips)
                        Write-Host "Last:$last"
                       }

                $ipsplit=$ip.Split(".")
                $firstt..$last | % { $ipsplit[0] + "." +  $ipsplit[1] + "." + $ipsplit[2] + "." + $_ | Add-Content -Path $Outputfile}
                }
 else {        
        $ip | Add-Content -Path $Outputfile
      }
}
