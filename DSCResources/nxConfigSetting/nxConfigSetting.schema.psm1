Configuration nxConfigSetting {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $Name,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $TestCommand,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $TestRegex,
        
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String[]] $FixCommands
    )

    # Import the module that defines custom resources
    Import-DSCResource -ModuleName nx -ModuleVersion "1.0"

    nxScript $Name {
        GetScript = @"
#!/bin/bash
result=`$($TestCommand)
if [[ "`$result" =~ $($TestRegex) ]] ; then
    echo `$result
fi
"@
        SetScript = @"
#!/bin/bash
$($FixCommands -join '`n')
"@
        TestScript = @"
#!/bin/bash
result=`$($TestCommand)
if [[ "`$result" =~ $($TestRegex) ]] ; then
    exit 0
else
    exit 1
fi
"@
    }
}
