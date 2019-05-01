Configuration CISUbuntu16Policy110
{
    param
    (
        [Parameter()]
        [String[]] $PoliciesToIgnore
    )

    # Import the module that defines custom resources
    Import-DSCResource -ModuleName nx -ModuleVersion "1.0"
    nxFileLine "Test FileLine" {
        FilePath = "/etc/testfileline"
        ContainsLine = "Test"
    }

   nxScript "blah" {
            GetScript = @'
#!/bin/bash
if [ -f /etc/modprobe.d/CIS.conf ] && grep -Fxq 'install cramfs /bin/true' /etc/modprobe.d/CIS.conf ; then
    echo 'install cramfs /bin/true'
fi
'@
            SetScript = @'
#!/bin/bash
echo 'install cramfs /bin/true' | tee -a /etc/modprobe.d/CIS.conf
'@
            TestScript = @'
#!/bin/bash
if [ -f /etc/modprobe.d/CIS.conf ] && grep -Fxq 'install cramfs /bin/true' /etc/modprobe.d/CIS.conf ; then
    exit 0
else
    exit 1
fi
'@
        }
    }
}