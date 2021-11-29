\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.AbsWork"
 
\\ P%=&400:B%=P%:O%=&800
\\ [OPT 6
 
\ Event routine variables, beware!

ORG &400

.AbsStartDummy

.VSyncMast EQUB 0
.VSyncCnt  EQUB 0
.VSyncCn2  EQUB 0
 
\ Non-Player relevant variables
 
.counter   EQUB 0         \ INC by 1 each game loop
.Player    EQUB 0
.XIndex    EQUB 0
.YIndex    EQUB 0
.WhichStar EQUB 0
.FireDel   EQUB 0
.SectAddr  EQUW 0
.SectOff   EQUB 0
.MaxAlID   EQUB 0
.UptoID    EQUB 0
.Escape    EQUB 0
.ActAliens  EQUB 0
.ActBullets EQUB 0
.ActInits   EQUB 0
.ActAlBombs EQUB 0
.DieDelay  EQUB 0
.VInFCnt   EQUB 0
.VInFOff   EQUB 0
.Demo      EQUB 0
.DemoDir   EQUB 0
.DemoCnt   EQUB 0
.TimeOut   EQUB 0
.NewAlID   EQUB 0
.RetPress  EQUB 0
.Feature   EQUB 0
.AlCounter EQUB 0
.SmartFlg  EQUB 0
.ShipInfo  EQUB 0
.NoFx      EQUB 0
 
.ObjX       SKIP TotObj
.ObjY       SKIP TotObj
.ObjWid     SKIP TotObj
.ObjXWid    SKIP TotObj
.ObjHei     SKIP TotObj
.ObjGTyp    SKIP TotObj
.ObjGra     SKIP TotObj
.ObjFrm     SKIP TotObj
.ObjNumFrm  SKIP TotObj
.ObjPat     SKIP TotObj
.ObjPOff    SKIP TotObj
.ObjPFlip   SKIP TotObj
.ObjDirCnt  SKIP TotObj
.ObjRelX    SKIP TotObj
.ObjRelY    SKIP TotObj
.ObjFOff    SKIP TotObj
.ObjFCnt    SKIP TotObj
.ObjHits    SKIP TotObj
.ObjDestr   SKIP TotObj
.ObjInfo    SKIP TotObj
.ObjFeat    SKIP TotObj
 
.InitSt     SKIP MaxInit
.InitX      SKIP MaxInit
.InitY      SKIP MaxInit
.InitGTyp   SKIP MaxInit
.InitNum    SKIP MaxInit
.InitPat    SKIP MaxInit
.InitPFlip  SKIP MaxInit
.InitDelay  SKIP MaxInit
.InitRDelay SKIP MaxInit
.InitRelX   SKIP MaxInit
.InitRelY   SKIP MaxInit
.InitFeat   SKIP MaxInit
 
.MyBmbSt   SKIP MaxMyBmb
.MyBmbX    SKIP MaxMyBmb
.MyBmbY    SKIP MaxMyBmb
 
.AlBmbSt   SKIP MaxAlBmb
.AlBmbX    SKIP MaxAlBmb
.AlBmbY    SKIP MaxAlBmb
.AlBmbTyp  SKIP MaxAlBmb
 
\ Player specific variables
 
.PlyrInf
.smarts     EQUB 0
.level      EQUB 0
.lives      EQUB 0
.score      EQUS "1234567"
.PlyrEnd    \ See below
 
.Plyr1Inf
.P1smarts   EQUB 0
.P1level    EQUB 0
.P1lives    EQUB 0
.P1score    EQUS "1234567"
 
.Plyr2Inf
.P2smarts   EQUB 0
.P2level    EQUB 0
.P2lives    EQUB 0
.P2score    EQUS "1234567"
 
\\ ]
PRINT"General workspace from ",~AbsStartDummy," to ",~P%-1
 
\\ IFP%>&7FF VDU7:PRINT'"Absolute workspace overflow!"

PlyrSize=PlyrEnd-PlyrInf    \\ REM Size (in bytes) of players specfic variables
 
\\ PAGE=PG%
\\ RETURN
 
\\ DEFFNres1(gap%)
\\ P%=P%+gap%:O%=O%+gap%
\\ =6
