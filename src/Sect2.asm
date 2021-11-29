\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Sect2"
\\ B%=P%
\\ [OPT pass
 
.Sect8
 EQUB ChMaxAlID:EQUB 14
 
 EQUB InAllDead:EQUB 25
 EQUB InAllDead:EQUB &80+25
 EQUB InAlDeFlp:EQUB 8
 EQUB InAllDead:EQUB 26
 EQUB InAllDead:EQUB &80+26
 EQUB WtAllDead:EQUB InExhFeat:EQUB 28:EQUB 5 \ Explosive container!
 EQUB InAllDead:EQUB 2
 EQUB InAllDead:EQUB &80+2
 EQUB InAllDead:EQUB 27
 EQUB WtAllDead:EQUB InExhFeat:EQUB 16:EQUB 10 \ 1000 pts
 EQUB InAllDead:EQUB &80+27
 
 EQUB CtrlZonEnd
 
.Sect9
 EQUB ChMaxAlID:EQUB 16
 
 EQUB InAllDead:EQUB 28
 EQUB InAllDead:EQUB &80+28
 EQUB InAllDead:EQUB &80+29
 EQUB InAllDead:EQUB 19
 EQUB InAllDead:EQUB &80+19
 EQUB InAllDead:EQUB 29
 EQUB InAllDead:EQUB 12
 EQUB InAllDead:EQUB &80+12
 EQUB InAllDead:EQUB 21
 EQUB WtAllDead:EQUB InExhFeat:EQUB 27:EQUB 9 \ Xtra life
 EQUB WtAllDead:EQUB InExhFeat:EQUB &80+27:EQUB 1 \ No Firepower
 
 EQUB CtrlZonEnd
 
.Sect10
 EQUB ChMaxAlID:EQUB 14
 
 EQUB InAllDead:EQUB 30
 EQUB InAllDead:EQUB &80+30
 EQUB WtAllDead:EQUB InExhFeat:EQUB 29:EQUB 6 \ Xtra firepower
 EQUB InAllDead:EQUB 9
 EQUB InAllDead:EQUB &80+9
 EQUB InAllDead:EQUB &80+31
 EQUB InAllDead:EQUB 31
 EQUB WtAllDead:EQUB InExhFeat:EQUB 33:EQUB 4 \ No horizontal
 EQUB InAllDead:EQUB &80+11
 EQUB InAllDead:EQUB 11
 
 EQUB CtrlZonEnd
 
.Sect11
 EQUB ChMaxAlID:EQUB 14
 
 EQUB InAlDeFlp:EQUB 11
 EQUB InAllDead:EQUB &80+15
 EQUB InAllDead:EQUB 15
 EQUB InAllDead:EQUB 33
 EQUB InAllDead:EQUB &80+33
 
 EQUB ChMaxAlID:EQUB 7
 
 EQUB WtAllDead
 EQUB InAlways  :EQUB 46 \ 2 * Big ship 1
 EQUB InAlways  :EQUB 47
 
 EQUB ChMaxAlID:EQUB 20
 EQUB WtAllDead:EQUB InExhFeat:EQUB 30:EQUB 10 \ 1000 pts
 EQUB InExhFeat:EQUB &80+30:EQUB 8  \ Smart bomb
 
 EQUB CtrlZonEnd
 
.Sect12
 EQUB ChMaxAlID:EQUB 16
 
 EQUB InAllDead:EQUB 14
 EQUB WtAllDead:EQUB InExhFeat:EQUB 5:EQUB 2 \ Slow ship
 EQUB InAllDead:EQUB 34
 EQUB InAllDead:EQUB &80+34
 EQUB InAllDead:EQUB &80+22
 EQUB InAllDead:EQUB 22
 EQUB InAllDead:EQUB &80+35
 EQUB InAllDead:EQUB 35
 EQUB InAllDead:EQUB 25
 EQUB InAllDead:EQUB &80+25
 
 EQUB CtrlZonEnd
 
.Sect13
 EQUB ChMaxAlID:EQUB 32
 
 EQUB WtAllDead:EQUB InExhFeat:EQUB 3:EQUB 10  \ 1000 pts
 EQUB WtAllDead:EQUB InExhFeat:EQUB &80+3:EQUB 10  \ 1000 pts
 
 EQUB WtAllDead
 EQUB InAlways :EQUB 23
 EQUB InAlways :EQUB 32
 
 EQUB ChMaxAlID:EQUB 12
 
 EQUB InAllDead:EQUB 37
 EQUB InAllDead:EQUB &80+37
 EQUB InAllDead:EQUB 17
 EQUB InAllDead:EQUB &80+17
 EQUB InAllDead:EQUB &80+36
 EQUB InAllDead:EQUB 36
 EQUB InAlDeFlp:EQUB 20
 
 EQUB WtAllDead:EQUB InExhFeat:EQUB 25:EQUB 1 \ No fire
 EQUB WtAllDead:EQUB InExhFeat:EQUB &80+25:EQUB 8 \ Smart bomb
 EQUB CtrlZonEnd
 
.Sect14
 EQUB ChMaxAlID:EQUB 16
 
 EQUB InAllDead:EQUB 38
 EQUB InAllDead:EQUB &80+38
 EQUB InAlDeFlp:EQUB 26
 EQUB InAllDead:EQUB &80+18
 EQUB InAllDead:EQUB 18
 EQUB InAllDead:EQUB 39
 EQUB InAllDead:EQUB &80+39
 EQUB InAlDeFlp:EQUB 16
 
 EQUB WtAllDead:EQUB InExhFeat:EQUB 35:EQUB 8 \ Smart bomb
 EQUB WtAllDead:EQUB InExhFeat:EQUB &80+35:EQUB 6 \ Xtra firepower
 
 EQUB CtrlZonEnd
 
.Sect15
 EQUB ChMaxAlID:EQUB 16
 
 EQUB InAlDeFlp:EQUB 24
 EQUB InAllDead:EQUB 40
 EQUB InAllDead:EQUB &80+40
 EQUB InAlDeFlp:EQUB 27
 EQUB InAlDeFlp:EQUB 29
 
 EQUB ChMaxAlID:EQUB 8
 
 EQUB WtAllDead
 EQUB InAlDeFlp:EQUB 50
 EQUB InAlways :EQUB 48 \ 1 * Big ship 2
 EQUB InAlways :EQUB 49
 
 EQUB ChMaxAlID:EQUB 16
 EQUB WtAllDead:EQUB InExhFeat:EQUB 37:EQUB 11 \ Protective shield
 
 EQUB CtrlZonEnd
 
\\ ]

\\ PRINT"Section 2  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
