$menu = {
    Write-Host "
    1. Windows 10
    2. Windows 11
    3. Ubuntu Desktop 22
    4. Ubuntu Desktop 20
    5. Ubuntu Desktop 18
    6. Quit or Press Ctrl + C"
    Write-Host " Select an option and press Enter: "  -nonewline
}

cls

$vmCreation = {
    if ((Get-Command VBoxManage.exe -ErrorAction SilentlyContinue) -eq $null) {
        $env:path="C:\Program Files\Oracle\VirtualBox;$env:path"
    }

    $isoFile = "D:\ISOs\$osName$osNumber.iso"
    $vmName  = "$osName$osNumber-$(Get-random)"
    $vmPath= "$home\VirtualBox VMs\$vmName"
    $userName = 'bonben'
    $password = '1'
    $fullUserName = 'BonBen'
    #VM configurations
    $hdSizeMb = 65536
    $memSizeMb = 8192
    $vramMb = 128 #Must be in range 0 … 256 (Mb) - GUI allows max of 128 only.
    $nofCPUs = 3

    VBoxManage createvm --name $vmName --ostype $ostype --register
    VBoxManage modifyvm $vmName --memory $memSizeMb --vram $vramMb --cpus $nofCPUs --clipboard-mode bidirectional --graphicscontroller vboxsvga
    VBoxManage createmedium --filename "$vmPath\virtualdisk.vdi" --size $hdSizeMb
    VBoxManage storagectl $vmName --name 'SATA Controller' --add sata --controller IntelAHCI
    VBoxManage storageattach $vmName --storagectl 'SATA Controller' --port 0 --device 0 --type hdd --medium "$vmPath\virtualdisk.vdi"
    VBoxManage unattended install $vmName --iso=$isoFile --user=$userName --password=$password --image-index=$imageIndex --full-user-name=$fullUserName --install-additions
    VBoxManage startvm $vmName
}
 
Do { 
    cls
    Invoke-Command $menu
    $select = Read-Host
    if ($select -eq 1) {$osName = 'Windows'; $osNumber ='10'; $ostype = 'Windows10_64'; $imageIndex='6'}
    if ($select -eq 2) {$osName = 'Windows'; $osNumber ='11'; $ostype = 'Windows10_64'; $imageIndex='6'}
    if ($select -eq 3) {$osName = 'Ubuntu'; $osNumber ='22'; $ostype = 'Ubuntu_64'; $imageIndex='null'}
    if ($select -eq 4) {$osName = 'Ubuntu'; $osNumber ='20'; $ostype = 'Ubuntu_64'; $imageIndex='null'}
    if ($select -eq 5) {$osName = 'Ubuntu'; $osNumber ='18'; $ostype = 'Ubuntu_64'; $imageIndex='null'}

    Switch ($select)
    {
        1 {Invoke-Command $vmCreation}
        2 {Invoke-Command $vmCreation}
        3 {Invoke-Command $vmCreation}
        4 {Invoke-Command $vmCreation}
        5 {Invoke-Command $vmCreation}
    }
} While ($select -ne 6)
