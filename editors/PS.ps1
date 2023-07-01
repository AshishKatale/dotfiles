Set-Alias -Name c -Value clear
Set-Alias -Name x -Value clear
Set-Alias -Name ll -Value ls
Set-Alias -Name opn -Value explorer

function ccc { exit }
function xxx { exit }
function D { cd D:\ }
function C { cd C:\ }
function psrc { code $PROFILE }

function gad { git add . }
function gst { git status }
function glo { git log --oneline }
function gcl { git config --list }
function gcgl { git config --global --list }
function glog { git log --oneline --graph --all --decorate=full }
function gcamend { git commit --amend --no-edit }

function nst { npm start }
function ndv { npm run dev }
function nbld { npm run build }

function GIT_INFO {
	($REPO_EXISTS = git rev-parse --is-inside-work-tree) > $null
	if ($REPO_EXISTS) {
		($BRANCH = git branch --show-current) > $null
		if($BRANCH){
			$ICON = "$([char]0xdb80)$([char]0xdea2)" # 󰊢
			Write-Host " $ICON $BRANCH" -ForegroundColor "Green" -NoNewline
			return
		}

		($TAG = git tag --points-at=HEAD) > $null
		if($TAG){
			$ICON = "$([char]0xdb81)$([char]0xdcfb)" # 󰓻
			Write-Host " $ICON $TAG" -ForegroundColor "Green" -NoNewline
			return
		}

		($COMMIT = git rev-parse --short HEAD) > $null
		if($COMMIT) {
			$ICON = "$([char]0xf417)" # 
			Write-Host " $ICON $COMMIT " -ForegroundColor "Green" -NoNewline
		}
	}
}

function prompt {
	Write-Host "$PWD" -ForegroundColor "Cyan" -NoNewline
	GIT_INFO
	Write-Host " $" -ForegroundColor "Yellow" -NoNewline
	return " "
}

