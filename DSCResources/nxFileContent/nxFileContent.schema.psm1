Configuration nxFileContent {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $Name,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $TestCommand,
        
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $Filename,
        
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [String] $FileContent,
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String] $AppendCommand,
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String] $AppendRegex
    )

    # Import the module that defines custom resources
    Import-DSCResource -ModuleName nx -ModuleVersion "1.0"

    if($AppendCommand -and $AppendRegex) {
        nxScript $Name {
            GetScript = @"
#!/bin/bash
result=`$($TestCommand)
if [[ "`$result" =~ ^pass$ ]] ; then
    echo `$result
fi
"@
            SetScript = @"
#!/bin/bash
result=`$($AppendCommand)
if [[ "`$result" =~ ^pass$ ]] ; then
    echo '$FileContent' | tee -a $Filename
else
    sed -i 's/$AppendRegex/$FileContent/' $Filename
fi
"@
            TestScript = @"
#!/bin/bash
result=`$($TestCommand)
if [[ "`$result" =~ ^pass$ ]] ; then
    exit 0
else
    exit 1
fi
"@
        }
    }
    else {    
        nxScript $Name {
            GetScript = @"
#!/bin/bash
result=`$($TestCommand)
if [[ "`$result" =~ ^pass$ ]] ; then
    echo `$result
fi
"@
            SetScript = @"
#!/bin/bash
echo '$FileContent' | tee -a $Filename
"@
            TestScript = @"
#!/bin/bash
result=`$($TestCommand)
if [[ "`$result" =~ ^pass$ ]] ; then
    exit 0
else
    exit 1
fi
"@
        }
    }
}
