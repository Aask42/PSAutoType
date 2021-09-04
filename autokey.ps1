<#
.AUTHOR
    AASK 20210902
.EXAMPLE
    autokey.ps1 "action"
.NOTES
    Don't forget to make your paste.txt file if you want to use one!
#>

$action = $args[0]


$paste = get-content ./paste.txt -ErrorAction SilentlyContinue # Get our paste file as ps hates typing special characters

$actions = @{
    "hello_world" = @('Hello World','{enter}','^v')
}

# Validate we have this action
if(!$actions.$action){
    write-host "$action does not exist, sorry charlie!"
    exit
}

$wshell = New-Object -ComObject wscript.shell;

notepad.exe
$wshell.AppActivate('Untitled - Notepad') # Select the right window in case we got clicked off
start-sleep 1
# Input all our freakin' commands
for($i = 0;$i -lt $actions.$action.Count;$i++){
    if($actions.$action[$i][0] -eq '{' -or $actions.$action[$i][0] -eq '^'){
        $wshell.SendKeys($actions.$action[$i])
        start-sleep -milliseconds 25
    } else {
        for($x = 0;$x -lt $actions.$action[$i].Length;$x++ ){
            $wshell.SendKeys($actions.$action[$i][$x])
        }
    }
}
