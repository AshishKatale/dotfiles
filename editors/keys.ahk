#Enter::Run D:\PRD\software\nvim\bin\Alacritty.exe
#+Enter::Run C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
#+q::WinClose , A
#+f::Winset, Alwaysontop, , A
SetTitleMatchMode, 2
#If WinActive("ahk_exe Alacritty.exe")
^+f::Send {f13}
^+n::Send {f14}
+Space::Send {f15}
^Space::Send {f16}

