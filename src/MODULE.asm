\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Module"
 
\\ P%=&900:O%=&800:B%=P%
\\ [OPT pass

\\ Re-map EQUS strings for this file - reset below!
MAPCHAR ' ','Z', 0

.pstring
 LDA strptab,Y:STA temp3
 LDA strptab+1,Y:STA temp3+1
 
.pst6
 LDY #0
 LDA (temp3),Y
.pst8
 CMP #&FF:BNE pst7
 RTS            \ Exit if X coord=&FF, end of string list
 
.pst7
 AND #&7F:TAX             \ Remove B7 'new item' flag
 INY:LDA (temp3),Y:TAY    \ Y coord
 AND #3:STA temp5+2:\ pix.off.
 TYA:AND #&F8:TAY:JSR xycalc
 STA temp2+1:STX temp2
 
 LDY #2:LDA (temp3),Y    \ Colour byte
 AND #&88:STA temp4+1:STA temp5
 LDX temp5+2:BEQ pst5
.pst0
 LSR temp5
 DEX:BNE pst0
 
.pst5
 LDA temp3:CLC:ADC #3:STA temp3 \ Skip over X,Y,colour fields
 BCC charloc
 INC temp3+1
 
.charloc
 JSR TryStars
 LDY #0:LDA (temp3),Y:BMI pst8 \ Note Y=0 when taken!
 STA temp4
 LDX #CharSet DIV 256
 ASL A:ASL A:\ I assume A<64!
 ADC temp4:BCC pst1
 INX:CLC
.pst1
 ADC #CharSet MOD 256
 BCC pst2
 INX
.pst2
 STA charbase+1:STX charbase+2
 LDX #0
.charbase
 LDA &FFFF,X
 STA temp5+1:\ char. def. byte
 LDY #7
.pst3
 ASL temp5+1:\ test 1 in char.def.
 BCC pst4:\ Skip if pixel unset!
 LDA temp5:\ colour shift byte
 EOR (temp2),Y
 STA (temp2),Y
.pst4
 DEY:BPL pst3
 JSR pst_pixright
 INX:CPX #5:BNE charbase
 JSR pst_pixright
 INC temp3:BNE charloc
 INC temp3+1:JMP charloc
 
.pst_pixright
 LSR temp5
 INC temp5+2:LDA temp5+2
 CMP #4:BCC pst_pr0
 
 LDA #0:STA temp5+2
 LDA temp4+1:STA temp5
 LDA temp2:ADC #7:\ c=1 here!
 STA temp2
 BCC pst_pr0
 INC temp2+1
.pst_pr0
 RTS
 
.strptab
 EQUW TxMainTit
 EQUW TxGetRdy
 EQUW TxPlayer
 EQUW TxGamOvr
 EQUW TxEntry
 EQUW TxChar
 EQUW TxNewHigh
 EQUW TxBestScr
 EQUW TxOptChr
 EQUW TxStrtLev
 
.TxMainTit
 EQUB 1:EQUB 7*8+1:EQUB &88
 EQUS "BBC MICRO 40TH ANNIVERSARY"
 
 EQUB &80+16:EQUB 10*8+0:EQUB &80
 EQUS "BY KEVIN EDWARDS"
 
 EQUB &80+24:EQUB 23*8+0:EQUB &08
 EQUS "(C) MMXXI"
 
 EQUB &80+11:EQUB 25*8+2:EQUB &08
 EQUS "DEVELOPMENT VERSION" \ CopyName$
 
.TxPresSpc
 EQUB &80+10:EQUB 28*8+1:EQUB &88
 EQUS "PRESS SPACE TO START"
 EQUB &FF
 
.TxGetRdy
 EQUB 26:EQUB 6*8+1:EQUB &88
 EQUS "GET READY"
 
 EQUB &80+12:EQUB 14*8+0:EQUB &08
 EQUS "ENTERING GALAXY "
.TxGalax
 EQUS "000"
 
.TxPlayer
 EQUB &80+28:EQUB 8*8+1:EQUB &80
 EQUS "PLAYER "
.TxPlyr
 EQUB 0
 EQUB &FF
 
.TxGamOvr
 EQUB 26:EQUB 6*8+1:EQUB &88
 EQUS "GAME OVER"
 EQUB &FF
 
.TxEntry
 EQUB 0:EQUB 6*8+0:EQUB &88
 EQUS "1":EQUB '.'-32
.TxEnt0
 EQUB &80+6:EQUB 6*8+0:EQUB &80
 EQUS "1234567"
.TxEnt1
 EQUB &80+28:EQUB 6*8+0:EQUB &08
 EQUS "1234567890123456"
 EQUB &FF
 
.TxChar
 EQUB 28:EQUB 6*8+0:EQUB &08
 EQUB 0
 EQUB &FF
 
.TxNewHigh
 EQUB 14:EQUB 5*8+2:EQUB &88
 EQUS "A NEW HIGH SCORE!"
 
 EQUB &80+14:EQUB 6*8+1:EQUB &08
 EQUS "-=-=-=-=-=-=-=-=-"
 
 EQUB &80+14:EQUB 26*8+0:EQUB &08
 EQUS "(ENTER YOUR NAME)"
 EQUB &FF
 
.TxBestScr
 EQUB 8:EQUB 5*8+1:EQUB &80
 EQUS "TODAY'S BEST FIGHTERS"
 
 EQUB &80+8:EQUB 6*8+1:EQUB &88
 EQUS "-=-=-=-=-=-=-=-=-=-=-"
 
 EQUB &80+4:EQUB 26*8+0:EQUB &88
 EQUS "(MORE TRAINEES REQUIRED)"
 EQUB &FF
 
.TxOptChr
 EQUB 0:EQUB 31*8+0:EQUB &88
 EQUS "A"
 EQUB &FF
 
.TxStrtLev
 EQUB 6:EQUB 5*8+0:EQUB &80
 EQUS "PRESS CURSOR UP/DOWN TO"
 
 EQUB &80+12:EQUB 7*8+3:EQUB &80
 EQUS "ALTER START GALAXY"
 
 EQUB &80+0:EQUB 11*8+0:EQUB &88
 EQUS "FURTHEST"
 EQUB &80+0:EQUB 13*8+0:EQUB &88
 EQUS "GALAXY"
 EQUB &80+0:EQUB 15*8+0:EQUB &88
 EQUS "REACHED"
 
 EQUB &80+0:EQUB 18*8+0:EQUB &88
 EQUS "START"
 EQUB &80+0:EQUB 20*8+0:EQUB &88
 EQUS "GALAXY"
 
 EQUB &80+16:EQUB 26*8+0:EQUB &08
 EQUS "(RETURN TO EXIT)"
 EQUB &FF
 
.HSBase
 EQUS "0075000ADVANCED TRAINER"
 EQUS "0050000NOVICE TRAINER  "
 EQUS "0040000ADVANCED PILOT  "
 EQUS "0030000COMPETENT PILOT "
 EQUS "0020000NOVICE PILOT    "
 EQUS "0010000TRAINEE         "
 
.SoundFx
 BIT Demo:BMI Soun0
 BIT NoFx:BMI Soun0
 BIT FSound:BPL Soun0
 LDA #7:JMP osword
.Soun0
 RTS
 
.PlayTune
 BIT Demo:BMI PlTu0
 TYA:PHA
 JSR flush
 PLA:TAY
 JMP TUNE
.PlTu0
 RTS


\\ Re-map Back to normal ASCII
MAPCHAR ' ','Z', 32
 
\\ ]
\\ PRINT"Module     from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ IFP%>=(&900+modu%) PRINT'"Module overlow!":VDU7,7:END
\\ P%=objstrt%:O%=&800+modu%
\\ PAGE=PG%
\\ RETURN

\\ DEF FNmyascii(oldasc$)
\\ IF pass>4 O%=O%+LEN(oldasc$):P%=P%+LEN(oldasc$):=pass
\\ FORL%=1TOLEN(oldasc$)
\\ ?(O%+L%-1)=ASC(MID$(oldasc$,L%,1))-32
\\ NEXT
\\ O%=O%+LEN(oldasc$)
\\ P%=P%+LEN(oldasc$)
\\ =pass

