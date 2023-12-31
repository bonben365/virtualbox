if ((Get-Command VBoxManage.exe -ErrorAction SilentlyContinue) -eq $null) {
  $env:path="C:\Program Files\Oracle\VirtualBox;$env:path"
}

$isoFile = "D:\ISOs\Win10_22H2.iso"
$vmName  = "Windows10-$(Get-random)"
$vmPath= "$home\VirtualBox VMs\$vmName"
$userName = 'bonben'
$password = '123@123a'
$fullUserName = 'BonBen'
#VM configurations
$hdSizeMb = 65536
$memSizeMb = 4096
$vramMb = 128 #Must be in range 0 … 256 (Mb) - GUI allows max of 128 only.
$nofCPUs = 2

VBoxManage createvm --name $vmName --ostype 'Windows10_64' --register

VBoxManage modifyvm $vmName `
  --memory $memSizeMb `
  --vram $vramMb `
  --cpus $nofCPUs `
  --clipboard-mode bidirectional `
  --graphicscontroller vboxsvga

VBoxManage createmedium --filename "$vmPath\virtualdisk.vdi" --size $hdSizeMb
VBoxManage storagectl $vmName --name 'SATA Controller' --add sata --controller IntelAHCI
VBoxManage storageattach $vmName `
  --storagectl 'SATA Controller' `
  --port 0 `
  --device 0 `
  --type hdd `
  --medium "$vmPath\virtualdisk.vdi"

VBoxManage unattended install $vmName `
  --iso=$isoFile `
  --user=$userName `
  --password=$password `
  --full-user-name=$fullUserName `
  --image-index=6 `
  --install-additions `
  --post-install-command='VBoxControl guestproperty set installation_finished y'

VBoxManage startvm $vmName


