\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.StartUp"
 
\\ [OPT pass
.last
\\ ]
 
\\ IF last>&4400 VDU7:PRINT''"Obj code has just zapped music driver!":END
\\ IF pass=4 Y%=P% ELSE Z%=P%:REM For phase error checking
 
\\ Code has just zapped music driver!
\\ ?????? GUARD &4400
 
\\ P%=objend%:O%=&800+modu%+(objend%-objstrt%)
\\ B%=P%
\\ [OPT pass
 ORG objend%

.gogo
 LDA #15:LDX #0:JSR osbyte
 LDA #&8C:LDX #&C:JSR osbyte    \ *TAPE 12
 LDA #3:STA &258
 
 SEI
 LDX #&F:LDA #0
.romoff
 STA &2A1,X:DEX:BPL romoff      \ Unplug all sideways ROMs
 CLI
 
 LDA #4:LDX #1:JSR osbyte           \ Disable cursor edit keys
 LDA #&E1:LDX #0:LDY #0:JSR osbyte  \ Make soft keys create ascii values
 
 LDX #0:TXA
.clrabs
 STA &400,X
 STA &500,X
 STA &600,X
 STA &700,X
 INX:BNE clrabs
 
 LDX #&A0-1
.DowDig
 LDA LdDigGra,X:STA DigGra,X
 DEX:CPX #&FF:BNE DowDig
 
 LDX #0
.DowChrs
 LDA Ldcharset,X:STA CharSet,X
 INX:BNE DowChrs
 LDX #&26
.DowChr0
 LDA Ldcharset+&100,X:STA CharSet+&100,X
 DEX:BPL DowChr0
 
 LDX #&CD
.DowChr1
 LDA Ldcharset2-1,X:STA SpCharSet-1,X
 DEX:BNE DowChr1
 
 LDA #4:STA temp1
 LDA #EnvDat MOD &100:STA temp2
 LDA #EnvDat DIV &100:STA temp2+1
 
.EnvDown
 LDX temp2:LDY temp2+1:LDA #8:JSR osword
 LDA temp2:CLC:ADC #14:STA temp2
 BCC EnDo0
 INC temp2+1
.EnDo0
 DEC temp1:BNE EnvDown
 
\ Ensure 6502 is set up correctly
 
 CLD:CLI
 LDX #&FF:TXS
 JMP start
 
\ Exploding alien, Firing, Xtra man, last man
 
.EnvDat
 EQUB 1:EQUB 1:EQUB -1:EQUB 0:EQUB 0:EQUB 255:EQUB 0:EQUB 0
 EQUB 0:EQUB 0:EQUB 0:EQUB -10:EQUB 0:EQUB 0
 
 EQUB 2:EQUB 1:EQUB -2:EQUB 2:EQUB 0:EQUB 20:EQUB 10:EQUB 0
 EQUB &3C:EQUB -1:EQUB -0:EQUB -10:EQUB 100:EQUB 20
 
 EQUB 3:EQUB 1:EQUB 10:EQUB 5:EQUB -20:EQUB 9:EQUB 7:EQUB 7
 EQUB +126:EQUB -1:EQUB 0:EQUB -2:EQUB 106:EQUB 20
 
 EQUB 4:EQUB 3:EQUB +12:EQUB +16:EQUB -28:EQUB 1:EQUB 1:EQUB 1
 EQUB +126:EQUB -3:EQUB -3:EQUB -10:EQUB 106:EQUB 90
 
 
.LdDigGra
\\ OPT FNLoadFil("Section.Digits",&A0)
INCBIN "object\Section\Digits.o"

.Ldcharset
\\ OPT FNLoadFil("Section.CHARDAT",&127)
INCBIN "object\Section\CHARDAT.o"

.Ldcharset2
\\ OPT FNLoadFil("Section.SpFont",&CD)
INCBIN "object\Section\SpFont.o"
 
\\]

\\ PRINT"Start Up   from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%:RETURN
 
\\ DEFFNLoadFil(fsp$,size%)
\\ IF pass>=6 OSCLI"LOAD "+fsp$+" "+STR$~(O%)
\\ O%=O%+size%:P%=P%+size%
\\ =pass
