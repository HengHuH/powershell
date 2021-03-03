# Heng's Profile for PowerShell7

# Prompt

function prompt {
    # $color = Get-Random -Min 1 -Max 16
    Write-Host ("$env:UserName") -NoNewLine -ForegroundColor Magenta
	Write-Host ("$") -NoNewLine
    Write-Host ("$env:COMPUTERNAME ") -NoNewLine -ForegroundColor Yellow
    $path = (Get-Location).Path
    $parts = $path.Split("\")
    $length = $parts.Length
    if($length -gt 3)
    {
        $arr = @()
        $arr += $parts[0]
        for($i=1; $i -lt $length - 1; $i++) { $arr += ($parts[$i]).SubString(0,1)}
        $arr += $parts[$length - 1]
        $path = $arr -join "\"
    }
	Write-Host $path -NoNewLine -ForegroundColor Green
	Write-Host (" $") -NoNewLine

    return " "
}

iex ($(lua $HOME\.local\config\external\z-lua\z.lua --init powershell) -join "`n") 

#-------------------------------   Set Alias Begin    -------------------------------
# 1. 编译函数 make
function MakeThings {
    nmake.exe $args -nologo
}
Set-Alias -Name make -Value MakeThings

# 2. 更新系统 os-update
Set-Alias -Name os-update -Value Update-Packages

# 3. 查看目录 ls & ll
function ListDirectory {
    (Get-ChildItem).Name
    Write-Host("")
}
Set-Alias -Name ls -Value ListDirectory
Set-Alias -Name ll -Value Get-ChildItem

# git
function GitStatus { & git status $args }
New-Alias -Name gst -Value GitStatus

function GitAllBranch { git branch -a }
New-Alias -Name gba -Value GitAllBranch

function GitSwitchBranch{
    param (
        $BranchName
    )
    git switch $BranchName
}
New-Alias -Name gsb -Value GitSwitchBranch

function GitSwitchNewBranch($BranchName) { git switch -c $BranchName}
New-Alias -Name gsnb -Value GitSwitchNewBranch

function GitCommitAllMessage ([string]$Message)
{
    git add .
    git commit -m $Message
}
New-Alias -Name gcam -Value GitCommitAllMessage

function GitRebaseMaster { git rebase -i master }
New-Alias -Name grm -Value GitRebaseMaster

function GitPushOriginBranch ($BranchName){ git push origin $BranchName }
New-Alias -Name gpob -Value GitPushOriginBranch

function GitFetchUpstream { git fetch upstream }
New-Alias -Name gfu -Value GitFetchUpstream

function GitPush { git push }
New-Alias -Name gph -Value GitPush

# z.lua

# 快速回到父目录
function ZLuaBackRoot { z -b }
New-Alias -Name zb -Value ZLuaBackRoot

# 选择最近去的地方
# function ZLuaLast { z -I -t }
# New-Alias -Name zh -Value ZLuaLast

# 严格匹配当前路径的子路径
function ZLuaSubDirectory {& z -c $args}
New-Alias -Name zz -Value ZLuaSubDirectory

# 使用交互式选择模式
function ZLuaInteractive {& z -i $args }
New-Alias -Name zi -Value ZLuaInteractive

# 使用 fzf 对多个结果进行选择
# function ZLuaRecent { z -I }
# New-Alias -Name zf -Value ZLuaRecent

#-------------------------------    Set Alias END     -------------------------------