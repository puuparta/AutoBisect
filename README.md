AutoBisect
==========

Powershell module for automate Mercurial bisect 
------------------------------------------------

Prerequisites
* PowerShell v2.0 or newer.

Installation
* copy Bisect into WindowPowerShell\Modules-folder
* execute command import-module bisect in PowerShell

Usage
* C:\PS> Bisect {(select-string .\HelloWorld.cs -pattern 'return 1.2' | select line) -notmatch 'return 1.2'} 3000 4300

  automates hg bisect command via revs 3000-4300 and finds first bad revision based on the given test targeted to file HelloWorld.cs. 
