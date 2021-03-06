
function bisect
<#
.SYNOPSIS

    Auto bisect for Mercurial 
    Author         : P.H. pasi.heinonen@gmail.com
    Prerequisite   : PowerShell V2 over Vista and upper.
    License: BSD 3-Clause
 
.DESCRIPTION

    "Unfrustrate" Mercurial hg bisect binary search command for automate it. 
 
.PARAMETER BisectTest

    Automated test which will checks the state of current revision under bisect.
    Test result must be boolean True or False. 
 
.PARAMETER GoodRev

    Known good revision id. Default is 0.
 
.PARAMETER BadRev

    Bad revision id. Default is 'tip'.
 
.EXAMPLE

    C:\PS> Bisect {(select-string .\HelloWorld.cs -pattern 'return 1.2' | select line) -notmatch 'return 1.2'} 3000 4300
     
    Description
    -----------
    Example automate hg bisect command via revs 3000-4300 and finds first bad revision based on the given test
    which search string "return 1.2" from file HelloWorld.cs. 

.NOTES

    This command can be used to automate hg bisect.
 
.LINK

    Script posted over:  
    http://github.com  
#>
 
{
    param(
        [Parameter(Mandatory=$true)]
        [ScriptBlock]
        $BisectTest,
        
        [Parameter()]
        $GoodRev = 0,
        
        [Parameter()]
        $BadRev = 'tip'
    )
    
    # init the bisect
    hg bisect --reset;
    hg bisect --bad $BadRev;
    (hg bisect --good $GoodRev) | out-null;
    # used out-null to avoid console output after last command above.
    
    #loop until hg bisect finds first bad revision
    while($output -notmatch 'The first bad revision is')
    {
        # execute results of script block to result-var
        $result = &$BisectTest; #Invoke-Expression "$BisectTest";
        if($result)
        {
            $output = (hg bisect --good) | out-string;
        }
        else
        {
            $output = (hg bisect --bad) | out-string;
        }
    }
    
    # dump output to the console
    $output;
}