resource "aws_key_pair" "mykey" {
    key_name= "mykey"
    public_key= "${file("${var.PATH_TO_PUBLIC_KEY}")}"
  
}

resource "aws_instance" "example"{
    ami = "${lookup(var.AMIS,var.AWS_REGION)}"
    instance_type ="t2.micro"
    key_name="${aws_key_pair.mykey.key_name}"
    user_data     = <<EOF
        <powershell>
        net user ${var.INSTANCE_USERNAME} '${var.INSTANCE_PASSWORD}' /add /y
        net localgroup administrators ${var.INSTANCE_USERNAME} /add

        winrm quickconfig -q
        winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
        winrm set winrm/config '@{MaxTimeoutms="1800000"}'
        winrm set winrm/config/service '@{AllowUnencrypted="true"}'
        winrm set winrm/config/service/auth '@{Basic="true"}'

        netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
        netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

        net stop winrm
        sc.exe config winrm start=auto
        net start winrm
        </powershell>
        EOF



    provisioner "file" {
        source = "test.txt"
        destination="C:/test.txt"

    }
    
    ///
#    provisioner "remote-exec" {
#        inline=[
#            "chmod +x /tmp/script.sh",
#            "sudo /tmp/script.sh"
#        ]
#    }
    connection {
        type = "winrm"
        host = self.public_ip
        user="${var.INSTANCE_USERNAME}"
        private_key="${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }


}