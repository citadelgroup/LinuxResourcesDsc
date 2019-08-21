# LinuxResourcesDsc
Module for extending the functionality of the nx resources

## Resources

* [nxFileContent](#nxfilecontent): Provides a mechanism to edit file content.
* [nxConfigSetting](#nxconfigsetting): Provides a mechanism to set config settings of apps/system based on a check.

### nxFileContent

Provides a mechanism to edit file content.

#### Requirements

* This must be run on a Linux OS

#### Parameters

* **[String] Name** _(Write)_: The name of the DSC Resource (must be unique).
* **[String] TestCommand** _(Write)_: The bash command to test for. Must return "pass" or "fail".
* **[String] Filename** _(Write)_: The file to edit.
* **[String] FileContent** _(Write)_: A string representing the content to write.
* **[String] AppendCommand** _(Optional)_: The bash command to test whether the content should be edited in place or appended.
* **[String] EditRegex** _(Optional)_: A regex string to replace with FileContent.
* **[String] PostApplyCommand** _(Optional)_: A command to run after editing the file.

#### Read-Only Properties from Get-TargetResource

None

#### Examples

### nxConfigSetting

Provides a mechanism to set config settings of apps/system based on a check.

#### Requirements

* This must be run on a Linux OS

#### Parameters

* **[String] Name** _(Write)_: The name of the DSC Resource (must be unique).
* **[String] TestCommand** _(Write)_: The bash command to test for. The result is compared against TestRegex.
* **[String] TestRegex** _(Write)_: The string containing regex to compare against.
* **[String] FixCommands** _(Write)_: An array of strings representing bash commands to enforce.

#### Read-Only Properties from Get-TargetResource

None

#### Examples

## Versions

### 1.0.0

* Initial release of LinuxResourcesDsc.

### 1.1.0

* Added nxConfigSetting
