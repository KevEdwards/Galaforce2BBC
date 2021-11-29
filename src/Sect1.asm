\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Sect1"
\\ B%=P%
\\ [OPT pass
 
.Sect0
 EQUB ChMaxAlID:EQUB 14
 
 EQUB InAllDead:EQUB 6
 EQUB InAllDead:EQUB &80+6
 EQUB InAllDead:EQUB &80+13
 EQUB InAllDead:EQUB 13
 EQUB InAllDead:EQUB 12
 EQUB InAllDead:EQUB &80+12
 EQUB InAlDeFlp:EQUB 11
 
 EQUB ChMaxAlID:EQUB 10
 EQUB InAllDead:EQUB &80+1
 EQUB InAllDead:EQUB 1
 EQUB InAlDeFlp:EQUB 1
 
 EQUB ChMaxAlID:EQUB 18
 EQUB InExhFeat:EQUB 4:EQUB 6   \ Xtra firepower
 
 EQUB CtrlZonEnd
 
.Sect1
 EQUB ChMaxAlID:EQUB 16
 
 EQUB InAllDead:EQUB &80+0
 EQUB InAllDead:EQUB 0
 EQUB InExhFeat:EQUB 0:EQUB 3  \ No vertical
 EQUB InAllDead:EQUB &80+8
 EQUB InAllDead:EQUB 8
 EQUB InExhFeat:EQUB 8:EQUB 8  \ Smart bomb
 EQUB InAllDead:EQUB 2
 EQUB InAllDead:EQUB &80+2
 EQUB InAlDeFlp:EQUB 2
 EQUB InAllDead:EQUB 23
 
 EQUB CtrlZonEnd
 
.Sect2
 EQUB ChMaxAlID:EQUB 14
 
 EQUB CtrlFor  :EQUB 2
 EQUB InAlDeFlp:EQUB 3
 EQUB InAllDead:EQUB &80+3
 EQUB InAllDead:EQUB 3
 EQUB InAllDead:EQUB 1
 EQUB InAllDead:EQUB &80+1
 
 EQUB ChMaxAlID:EQUB 8
 EQUB CtrlNext
 
 EQUB CtrlZonEnd
 
.Sect3
 EQUB ChMaxAlID:EQUB 24
 
 EQUB InExhFeat:EQUB 13:EQUB 10  \ 1000 pts
 
 EQUB ChMaxAlID:EQUB 16
 EQUB InAllDead:EQUB &80+4
 EQUB InAllDead:EQUB 4
 EQUB InAllDead:EQUB 5
 EQUB InAllDead:EQUB &80+5
 EQUB InAllDead:EQUB 7
 EQUB InAllDead:EQUB 23
 
 EQUB ChMaxAlID:EQUB 6
 
 EQUB WtAllDead
 EQUB InAlDeFlp:EQUB 16
 EQUB InAlways  :EQUB 42  \ Big ship 1
 EQUB InAlways  :EQUB 43
 
 EQUB ChMaxAlID:EQUB 17
 EQUB WtAllDead:EQUB InExhFeat:EQUB 6:EQUB 8   \ Smart bomb
 EQUB CtrlZonEnd
 
.Sect4
 EQUB ChMaxAlID:EQUB 16
 
 EQUB CtrlFor  :EQUB 2
 EQUB InAllDead:EQUB 10
 EQUB InAllDead:EQUB 15
 EQUB WtAllDead:EQUB InExhFeat:EQUB 38:EQUB 7  \ Rapid fire
 EQUB InAllDead:EQUB &80+15
 EQUB InAllDead:EQUB &80+10
 EQUB InAllDead:EQUB 17
 EQUB WtAllDead:EQUB InExhFeat:EQUB 38:EQUB 2   \ Slow ship
 EQUB InAllDead:EQUB &80+17
 
 EQUB ChMaxAlID:EQUB 12
 EQUB CtrlNext
 
 EQUB CtrlZonEnd
 
.Sect5
 EQUB ChMaxAlID:EQUB 16
 
 EQUB InAllDead:EQUB 16
 EQUB InExhFeat:EQUB &80+18:EQUB 10   \ 1000 pts
 EQUB InAllDead:EQUB &80+16
 EQUB InExhFeat:EQUB 18:EQUB 10   \ 1000 pts
 EQUB InAllDead:EQUB &80+41
 EQUB WtAllDead:EQUB InExhFeat:EQUB 31:EQUB 0  \ Reverse controls
 EQUB InAllDead:EQUB 41
 EQUB InAlDeFlp:EQUB 10
 EQUB InAllDead:EQUB &80+18
 EQUB InAllDead:EQUB 18
 EQUB InAlDeFlp:EQUB 3
 
 EQUB CtrlZonEnd
 
.Sect6
 EQUB ChMaxAlID:EQUB 14
 
 EQUB InExhFeat:EQUB 21:EQUB 6  \ Xtra firepower
 EQUB InAllDead:EQUB 19
 EQUB InAllDead:EQUB &80+19
 EQUB InAllDead:EQUB &80+20
 EQUB InAllDead:EQUB 20
 EQUB InAllDead:EQUB &80+13
 EQUB InAllDead:EQUB 13
 
 EQUB CtrlFor  :EQUB 2
 EQUB InAllDead:EQUB 21
 EQUB InAllDead:EQUB &80+21
 EQUB InAllDead:EQUB 23
 
 EQUB CtrlNext
 
 EQUB WtAllDead:EQUB InAlwFeat:EQUB 29:EQUB 9  \ Xtra life
 
 EQUB CtrlZonEnd
 
.Sect7
 EQUB ChMaxAlID:EQUB 12
 
 EQUB InAllDead:EQUB &80+22
 EQUB InAllDead:EQUB 22
 EQUB InAllDead:EQUB 6
 EQUB InAllDead:EQUB &80+6
 EQUB InAllDead:EQUB 24
 EQUB InAllDead:EQUB 0
 EQUB InAllDead:EQUB &80+0
 EQUB InAllDead:EQUB &80+24
 
 EQUB ChMaxAlID:EQUB 9
 
 EQUB WtAllDead
 EQUB InAlways  :EQUB 44 \ 2 * Big ship 1
 EQUB InAlways  :EQUB 45
 
 EQUB CtrlZonEnd
 
\\ ]

\\ PRINT"Section 1  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
