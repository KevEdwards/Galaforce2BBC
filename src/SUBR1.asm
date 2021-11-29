\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Subr1"
\\ B%=P%
\\ [OPT pass
 
.DispHead
 JSR title
 LDY #0:JMP pstring
 
.pgamovr
 LDY #6:JSR pstring
 LDY #4:JMP pstring
 
.title
 LDA #0:STA temp4+1
 LDA #&30:STA temp5
 LDX #6:LDY #32:JSR xycalc:STA temp2+1:STX temp2
 LDX #6:LDY #40:JSR xycalc:STA temp3+1:STX temp3
 
.tit0
 LDX temp4+1:LDA BigName,X:BMI tit6
 STA temp1
 ASL A:ASL A:CLC:ADC temp1:TAX
 LDA #5:STA temp4
 
.tit1
 LDA SpCharSet,X:STA temp1
 LDA #4:STA temp1+1
 LDY #0
 
.tit2
 LSR temp1:BCC tit3
 LDA temp5:EOR (temp2),Y:STA (temp2),Y:INY
 LDA temp5:EOR (temp2),Y:STA (temp2),Y:DEY
.tit3
 LDA #8:AND temp1:BEQ tit4
 LDA temp5:EOR (temp3),Y:STA (temp3),Y:INY
 LDA temp5:EOR (temp3),Y:STA (temp3),Y:DEY
.tit4
 INY:INY
 DEC temp1+1:BNE tit2
 JSR titrig:INX
 DEC temp4:BNE tit1
 JSR titrig
 INC temp4+1:BNE tit0:\ Always
 
.titrig
 LDA temp5:EOR #(&C0 EOR &30):STA temp5
 CMP #&C0:BNE tit6
 LDA temp2:ADC #7:STA temp2:BCC tit5  \ C=1
 INC temp2+1
.tit5
 LDA temp3:CLC:ADC #8:STA temp3:BCC tit6
 INC temp3+1
.tit6
 RTS
 
.BigName
\\ OPT FNmyascii2("GALAFORCE")
 base = 55;
 EQUB 'G'- base,'A'- base,'L'- base,'A'- base,'F'- base,'O'- base,'R'- base,'C'- base,'E'- base
 EQUB 38:EQUB '2' - '0'
 EQUB &FF
 
.ProcessMyBombs
 LDX #MaxMyBmb-1
.PrMyB0
 LDA MyBmbSt,X:BMI PrMyB1
.PrMyB2
 DEX:BPL PrMyB0
 BMI PrMyB4
 
.PrMyB1
 JSR PlotBull
 LDA MyBmbY,X:SEC:SBC #8
 CMP #8:BCC PrMyB3
 LDY Feature:CPY #7:BNE PrFasFir \ If not fast fire
 SEC:SBC #8
 CMP #8:BCC PrMyB3
 
.PrFasFir
 STA MyBmbY,X
 JSR PlotBull
 JMP PrMyB2
 
.PrMyB3
 DEC ActBullets
 LDA #0:STA MyBmbSt,X:BEQ PrMyB2
 
.PlotBull
 STX temp2 \ Save X
 LDY MyBmbY,X:LDA MyBmbX,X:SEC:SBC #XExcess:TAX
 JSR xycalc:STA temp1+1:STX temp1
 LDX temp2:LDA MyBmbX,X:LSR A
 BCS PlBul0
 
 LDY #7
.PlBul1
 LDA (temp1),Y:EOR BullGra,Y:STA (temp1),Y
 DEY:BPL PlBul1
 RTS
 
.PlBul0
 LDY #&F:LDX #7
.PlBul00
 LDA (temp1),Y:EOR BullGra0,X:STA (temp1),Y
 DEY:DEX:BPL PlBul00
 LDY #6:LDA #1:EOR (temp1),Y:STA (temp1),Y
 LDX temp2 \ Restore original ID
 RTS
 
.PrMyB4
 LDA ObjSt+0:BPL PrMyBEx
 LSR A:BCS PrMyBEx
 LDX Feature:DEX:BEQ PrMyBEx \ No fire
 
 BIT Demo:BMI PrMyBDem \ Always fire
 BIT FKeyJoy:BMI DoKy
 JSR RxJoyBut:BCS PrMyBDem
 BCC PrMyB5
 
.DoKy
 LDX #&B6:JSR check_key \ Return
 BNE PrMyB5
 
.PrMyBDem
 LDA FireDel:BEQ PrMyB6
 DEC FireDel
 
.PrMyBEx
 RTS
 
.PrMyB5
 LDA #0:BEQ PrMyB9 \ Always
 
.PrMyB6
 LDA ShipInfo:CMP #1:BCS PrMyB10
 LDA Feature:CMP #6:BEQ PrMyB10 \ Lots of fire
 LDA ActBullets:CMP #9:BCS PrMyBEx \ Was 3!
 
.PrMyB10
 LDX #MaxMyBmb-1
.PrMyB7
 LDA MyBmbSt,X:BPL PrMyB8
 DEX:BPL PrMyB7
 RTS
 
.PrMyB8
 INC ActBullets
 LDA #&80:STA MyBmbSt,X
 LDA ObjX+0:CLC:ADC #2:STA MyBmbX,X
 LDA ObjY+0:SBC #22:AND #&F8:STA MyBmbY,X
 JSR PlotBull
 LDX #FxFire MOD &100:LDY #FxFire DIV &100:JSR SoundFx
 LDA #2
 
.PrMyB9
 STA FireDel
 RTS
 
.FxFire
 EQUW &12:EQUW 2:EQUW 60:EQUW 4
 
.BullGra
 EQUB &22:EQUB &22:EQUB &22:EQUB &22:EQUB &22:EQUB &22:EQUB &07:EQUB &22
.BullGra0
 EQUB &88:EQUB &88:EQUB &88:EQUB &88:EQUB &88:EQUB &88:EQUB &0C:EQUB &88
 
.BullAlienCol
 LDX #MaxMyBmb-1
.BuAlCo0
 LDA MyBmbSt,X:BMI BuAlCB
 JMP BuAlCo2
 
.BuAlCB
 LDY MaxAlID
.BuAlCo1
 LDA ObjSt,Y:BPL BuFud1
 LSR A:BCS BuFud1
 LDA ObjDestr,Y:BMI BuFud1
 LDA ObjInfo,Y:LSR A:BCC BuFud0
 
.BuFud1
 JMP BuAlCo3
 
.BuFud0
 LDA ObjX,Y:CLC:SBC MyBmbX,X
 BCC BuAlCo4 \ ObjX < BmbX
 BNE BuAlCo3 \ No X collision
 BEQ BuAlCo6
 
.BuAlCo4
 EOR #&FF:ADC #1
 CMP ObjXWid,Y:BCS BuAlCo3 \ No X collision
 
.BuAlCo6
 LDA ObjY,Y:SEC:SBC MyBmbY,X
 BCS BuAlCo5 \ ObjY >= BmbY
 
 EOR #&FF:ADC #1
 CMP #8:BCS BuAlCo3 \ No Y collision
 BCC BuAlCo7 \ collision
 
.BuAlCo5
 CMP ObjHei,Y:BCS BuAlCo3 \ No Y collision
 
.BuAlCo7
 DEC ActBullets
 LDA #0:STA MyBmbSt,X
 STX temp5:STY temp5+1   \ Save X,Y
 JSR PlotBull \ Erase bull
 LDX temp5+1             \ X = 'Obj..' ID (no DEC abs,Y)
 LDA ObjInfo,X:AND #&F7:STA ObjInfo,X
 DEC ObjHits,X:BEQ BuAlCoA \ Alien dead
 JSR ExplNoC:JMP BuAlCo8
 
.BuAlCoA
 LDY temp5+1
 LDA ObjInfo,Y:BPL BuAlCo9 \ Not a special feature alien
 LDX #1:STX ShipInfo   \ Tell processing to change my ship
 
.BuAlCo9
 ASL A:BPL BuAlCoB
 LDX temp5+1:JSR FeatPro:LDX temp5:LDY temp5+1
 JMP BuAlCoC
 
.BuAlCoB
 LDA #&80:STA ObjDestr,Y \ kill ID
 LDA #&81:STA ObjSt,Y    \ Change status to 'exploding' immediately!
 
.BuAlCoC
 LDX ObjGTyp,Y
 LDA TGTypScore,X:JSR AddScr
 JSR ExplNoise
 
.BuAlCo8
 LDX temp5   \ Restore X with Bullet ID (Y no longer req'd)
 BPL BuAlCo2 \ Goes to outer loop as X bomb ID is dead!
 
.BuAlCo3
 DEY:BEQ BuAlCo2
 JMP BuAlCo1
.BuAlCo2
 DEX:BMI BuAlCo10 \ branch
 JMP BuAlCo0
.BuAlCo10
 RTS
 
\\ ]

\\ PRINT"Subr. 1    from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%:RETURN
 
\\ DEF FNmyascii2(oldasc$)
\\ IF pass>4 O%=O%+LEN(oldasc$):P%=P%+LEN(oldasc$):=pass
\\ FORL%=1TOLEN(oldasc$)
\\ ?(O%+L%-1)=ASC(MID$(oldasc$,L%,1))-55
\\ NEXT
\\ O%=O%+LEN(oldasc$):P%=P%+LEN(oldasc$)
\\ =pass
