\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Rout1"
\\ B%=P%
\\ [OPT pass
 
.flush
 LDA #15:LDX #0:JMP osbyte
 
.fx19
 LDA #19:JMP osbyte
 
.chkp
 LDX #&C8:\ P key
 
.check_key
 LDA #&81:LDY #&FF
 JSR osbyte
 CPY #&FF:RTS
 
.xycalc
 LDA #0:STA temp1+1
 TYA:AND #7:STA temp1
 TYA:LSR A:LSR A:LSR A:TAY
 TXA:AND #&FE
 ASL A  \ No ROL temp1+1 as X should always be between 0 and 79 on entry
 ASL A:ROL temp1+1
 ORA temp1:ADC rowlow,Y:TAX
 LDA temp1+1:ADC rowhi,Y
.xycal0
 RTS
 
.rowlow
\\ OPT FNmkscrlo
	FOR n, 0, 31, 1
	  EQUB LO( ScrBase + ( n * &140 ) )
	NEXT

.rowhi
\\OPT FNmkscrhi
	FOR n, 0, 31, 1
	  EQUB HI( ScrBase + ( n * &140 ) )
	NEXT


.reset
 LDX #&FF
 STX Feature
 
 INX:\ to 0
 STX FireDel
 STX SectOff
 STX VSyncCn2
 STX Escape
 STX ActAliens
 STX ActBullets
 STX ActInits
 STX ActAlBombs
 STX DemoCnt
 STX SmartFlg
 STX ShipInfo
 
 INX:\ to 1
 STX UptoID
 STX MaxAlID
 STX DieDelay
 
 LDA #0
 LDX #TotObj-1
.rese0
 STA ObjSt,X:DEX:BPL rese0
 
 LDX #MaxInit-1
.rese1
 STA InitSt,X:DEX:BPL rese1
 
 LDX #MaxMyBmb-1
.rese2
 STA MyBmbSt,X:DEX:BPL rese2
 
 LDX #MaxAlBmb-1
.rese3
 STA AlBmbSt,X:DEX:BPL rese3
 
 LDA &FC:STA seed
 EOR #&FD:STA seed+1
 EOR #&63:STA seed+2
 RTS
 
.StrtLev    EQUB 1    \ Default start level
.HighestLev EQUB 1    \ Default highest level reached (nromally 1)
 
.HardReset
 
 LDX StrtLev:BIT Demo:BPL HrdR0 \ If not in demo mode
 
 JSR rand:AND #7:TAX:INX \ Fudge so between 1 and 8
 
.HrdR0
 STX level
 
\ Drop through to reset score/lives
 
.ResetInfo
 LDX #6:LDA #0
.ResIn0
 STA score,X:DEX:BPL ResIn0
 LDA #1:STA smarts
 LDA #3:STA lives
 LDA #0:JSR SavePlyrB \ Copy info into player 1 & 2 variable area
 LDA #1:JSR SavePlyrB
 LDA #0:JSR ShwLivB \ Show 'lives' variable in both Player live positions
 LDA #1:JSR ShwLivB
 JMP ZeroInf \ Display 0000000 in both score areas
 
.controls
 LDX #0
 LDA Feature:BNE contr5
 INX
.contr5
 STX XIndex:STX YIndex
 BIT Demo:BPL contr2
 
 DEC DemoCnt:BPL contr4
 JSR rand:STA DemoDir
 AND #&1F:STA DemoCnt
 
.contr4
 LDX #2:LDA DemoDir:BPL contr3
 DEX
.contr3
 STX XIndex:LDA #0:STA YIndex:JMP contr0
 
.contr2
 BIT FKeyJoy:BPL rxjoy
 
 LDX #&9E:JSR check_key:\ Z
 ROL XIndex
 LDX #&BD:JSR check_key:\ X
 ROL XIndex
 LDX #&B7:JSR check_key:\ colon
 ROL YIndex
 LDX #&97:JSR check_key:\ ?
 ROL YIndex
 BPL contr0 \ Always
 
.rxjoy
 LDX #1:JSR chkjoy:ROL XIndex
 LDX #1:JSR chkjoy2:ROL XIndex
 LDX #2:JSR chkjoy:ROL YIndex
 LDX #2:JSR chkjoy2:ROL YIndex
 
.contr0
 LDY Feature
 LDX YIndex:CPY #3:BNE contr6
 LDX #0 \ Always gets 0 from table
.contr6
 LDA TRelY,X:STA YIndex
 
 LDX XIndex:CPY #4:BNE contr7
 LDX #0
.contr7
 LDA TRelX,X:STA XIndex
 RTS
 
.TRelX
 EQUB 0:EQUB 1:EQUB -1:EQUB 0
 EQUB 0:EQUB -1:EQUB 1:EQUB 0
 
.TRelY
 EQUB 0:EQUB 4:EQUB -4:EQUB 0
 EQUB 0:EQUB -4:EQUB 4:EQUB 0
 
.chkjoy
 LDA #&80:JSR osbyte
 CPY #&C0
 RTS
 
.chkjoy2
 LDA #&80:JSR osbyte
 CPY #&40:ROR A:EOR #&80:ROL A
 RTS
 
.frame_delay
 STY temp3
.framdel
 JSR TryStars
 JSR fx19
 DEC temp3:BNE framdel
 RTS
 
.frame_spc
 STY temp3
.framspc
 JSR testspc:BEQ framsp0
 JSR TryStars
 JSR fx19
 DEC temp3:BNE framspc
.framsp0
 RTS
 
.testspc
 LDX #&9D:\ Space key
 JMP check_key
 
\ New RND routine with EOR &FC for 'extra randomness'
 
.rand
 LDA seed:EOR &FC
 ROR seed:ROR seed+1
 ADC seed+2:EOR seed+1
 STA seed:EOR seed+2
 CMP seed+1:INC seed+1
 STA seed+2
 RTS
 
.vdu19
 LDA #19:JSR oswrch
 TXA:JSR oswrch
 TYA:JSR oswrch
 LDA #0:JSR oswrch
 JSR oswrch
 JMP oswrch
 
.RxJoyBut
 LDA #&80:LDX #0:JSR osbyte
 TXA:LSR A \ C=1 if pressed
 RTS
 
\\ ]

\\ PRINT"Routine 1  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
 
\\ DEFFNmkscrlo
\\ IFpass<6 O%=O%+32:P%=P%+32:=pass
\\ FORL%=ScrBase TO(ScrBase+31*&140)STEP&140
\\ [OPT pass
 \\ EQUB L% MOD 256
\\ ]NEXT
\\ =pass
 
\\ DEFFNmkscrhi
\\ IFpass<6 O%=O%+32:P%=P%+32:=pass
\\ FORL%=ScrBase TO(ScrBase+31*&140)STEP&140
\\ [OPT pass
 \\ EQUB L% DIV 256
\\ ]NEXT
\\ =pass
