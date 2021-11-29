\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.ZpWork"
\\ P%=0:O%=&800
\\ [OPT 6

ORG &0 

.temp1    EQUW 0
.temp2    EQUW 0
 
.SpInf             \ Warning! Shared variable area for source sprite info
.temp3    EQUW 0
.temp4    EQUW 0
.temp5    EQUD 0   \ Double!
 
.SpInf2   EQUD 0:EQUD 0  \ Variable area for destination sprite info
 
.seed EQUW 0:EQUB 0
 
.CurrId    EQUB 0
.LoopA     EQUB 0
.LoopB     EQUB 0
.LoopC     EQUB 0
 
.StarInfo   SKIP NumStars*3
 
.ObjSt      SKIP TotObj
 
\\ ]

\\ PRINT"Zero page from 0 to &" ~P%-1
PRINT"Zero page from 0 to ", ~P%-1

\\ IFP%>&9F VDU7:PRINT'"Warning, ZP w/space! &";~P%'
\\ PAGE=PG%
\\ RETURN
 
\\ DEFFNres0(gap%)
\\ P%=P%+gap%:O%=O%+gap%
\\ =6
