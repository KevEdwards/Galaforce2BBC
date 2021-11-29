\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Const"
 
\\ REM frequently used OS calls
\\ REM first
 
osbyte=&FFF4
oswrch=&FFEE
osword=&FFF1
osnewl=&FFE7
oscli =&FFF7
osrdch=&FFE0
osasci=&FFE3
 
osrdrm=&FFB9
oseven=&FFBF
osfind=&FFCE
osgbpb=&FFD1
osbput=&FFD4
osbget=&FFD7
osargs=&FFDA
osfile=&FFDD
 
\\ ver$="1.0000"
 
\\ cop$="*"+LEFT$(TIME$,15)+"*"
\\ FORL%=1TOLENcop$
\\ A$=MID$(cop$,L%,1)
\\ IFA$>="a" AND A$<="z" CopyName$=CopyName$+CHR$(ASC(A$)AND&5F) ELSE CopyName$=CopyName$+A$
\\ NEXT
 
ScrBase=&5800	\\ REM Star code will need changing if ScrBase is altered!
NumStars=31		\\ REM Alter this at your peril, see star processing code!
XExcess=40		\\ REM Must always be EVEN!
MaxLev=16		\\ REM Number of levels defined
process=8		\\ REM number of aliens to be processed each game loop
 
WindMinY=8
WindMinX=XExcess
WindMaxX=WindMinX+80
XKill=WindMaxX+XExcess
 
MaxInit=4	\\ REM Max number of simultaneous 'Init..' patterns
 
MaxAlien=38			\\ REM Maximum number of aliens/alien bombs allowed
TotObj=MaxAlien+1	\\ REM Total number of objects (+1 to include me)
 
MaxMyBmb=3			\\ REM Maximum number of bombs I'm allowed
MaxAlBmb=7			\\ REM Maximum number of alien bombs
 
AlGraBase=4			\\ REM Offset into graphic types of 1st alien graphic
 
DigGra=&D00			\\ REM Start address of digits graphics
DDVal=5				\\ REM Delay in game cycles after my ship has been erased
 
INITSOUND=&4400
TUNE=&4403
REFRESH=&4406
 
\\ PAGE=PG%
\\ RETURN
