\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Rout2"
\\ B%=P%
\\ [OPT pass
 
.InitLev
 LDY level:DEY:TYA:LDY #0
.InLev0
 CMP #MaxLev:BCC InLev1
 INY:SBC #MaxLev:BCS InLev0 \ Always
 
.InLev1
 TAX
 LDA TSecLo,X:STA SectAddr
 LDA TSecHi,X:STA SectAddr+1
 LDA #0:STA SectOff
 RTS
 
.AddScr
 STA temp4
 LDA #5:STA temp4+1 \ Index to 'tens' column
.AddSc0
 LDX temp4+1
 LDA temp4:BEQ AddSc1
 CLC:ADC score,X
 LDY #0
.AddSc2
 CMP #10:BCC AddSc3
 INY:SBC #10:BCS AddSc2 \ Always
.AddSc3
 STA score,X:STY temp4
 CPX #5:BNE AddSc4
 LDY Player:LDX TPlyrX,Y
 DEX:DEX:DEX:DEX \ -4 from X to move to 'tens' position on screen
 LDY #0:JSR PDigit
 JMP AddSc5
 
.TPlyrX
 EQUB 24:EQUB 76
 
.AddSc4
 TAY:JSR PDig0
.AddSc5
 DEC temp4+1:BPL AddSc0
.AddSc1
 RTS
 
.PDigit
 STA temp3
 JSR xycalc
 STA temp2+1:STX temp2
 LDY temp3
.PDig0
 LDX TStIndx,Y
 LDY #15
.PDig1
 LDA DigGra,X:STA (temp2),Y
 DEX:DEY:BPL PDig1
 LDA temp2:SEC:SBC #16:STA temp2
 BCS PDig2
 DEC temp2+1
.PDig2
 RTS
 
.TStIndx
 EQUB &0F:EQUB &1F:EQUB &2F:EQUB &3F:EQUB &4F
 EQUB &5F:EQUB &6F:EQUB &7F:EQUB &8F:EQUB &9F
 
.ZeroInf
 LDA #0
.ZeroI1
 STA temp4+1:TAY
 LDA #0:LDX TPlyrX,Y:LDY #0:JSR PDigit
 LDX #6:STX temp4 \ 6 (+1 above) zeros, Units is always 0!
.ZeroI0
 LDY #0:JSR PDig0
 DEC temp4:BNE ZeroI0
 LDA temp4+1:EOR #1:BNE ZeroI1
 RTS
 
.ReadPlyr
 LDX #PlyrSize-1
.RePly1
 LDA Player:BNE RePly0
 LDA Plyr1Inf,X:JMP RePly2
.RePly0
 LDA Plyr2Inf,X
.RePly2
 STA PlyrInf,X
 DEX:BPL RePly1
 RTS
 
.SavePlyrB  \ Second entry point to force a new 'Player' value
 STA Player
 
.SavePlyr
 LDX #PlyrSize-1
.SaPly1
 LDA PlyrInf,X
 LDY Player:BNE SaPly0
 STA Plyr1Inf,X:JMP SaPly2
.SaPly0
 STA Plyr2Inf,X
.SaPly2
 DEX:BPL SaPly1
 RTS
 
.TLivX
 EQUB 34:EQUB 42
 
.ShwLivB   \ Second entry point to force a new 'Player' value
 STA Player
 JSR ReadPlyr
 
.ShwLiv
 LDY Player:LDX TLivX,Y
 LDA lives:JSR TenUnit
 LDY #0:JMP PDigit
 
.HunTenUn
 LDX #0
.HuTeU0
 CMP #100:BCC TenUnit
 INX:SBC #100:BCS HuTeU0 \ Always
 
.TenUnit
 LDY #0
.TenUn0
 CMP #10:BCC TenUn1
 INY:SBC #10:BCS TenUn0 \ Always
.TenUn1
 RTS
 
.Event
 CMP #4:BNE EvExt \ If not 'vsync' event
 
 TXA:PHA:TYA:PHA
 INC VSyncMast \ Global, continuous frame counter
 
 BIT FPause:BMI Even2
 LDA FSound:LDX #&F:LDY #&F0:JSR REFRESH
 
.Even2
 LDA VSyncCnt:BEQ Even0
 DEC VSyncCnt
 
.Even0
 LDA VSyncCn2:BEQ Even1
 DEC VSyncCn2
 
.Even1
 PLA:TAY:PLA:TAX
 LDA #4
.EvExt
 RTS
 
.TryStars
 LDA VSyncCnt:BNE EvExt \ RTS
 LDA #1:STA VSyncCnt
 
.MoveStars
 LDY #16:LDX WhichStar:BEQ MveSta0
 DEY
.MveSta0
 LDA StarInfo+2,X:EOR (StarInfo,X):STA (StarInfo,X)
 LDA StarInfo,X:AND #7:CMP #6:BCC MveSta1
 LDA StarInfo,X:ADC #&39:EOR #&80:STA StarInfo,X
 LDA StarInfo+1,X:ADC #1:STA StarInfo+1,X
 BPL MveSta2
 
 JSR AtTop:JMP MveSta2
 
.MveSta1
 INC StarInfo,X:INC StarInfo,X
.MveSta2
 LDA StarInfo+2,X:EOR (StarInfo,X):STA (StarInfo,X)
 INX:INX:INX:DEY:BNE MveSta0
 
 LDX #16*3:LDA WhichStar:BEQ MveSta3
 LDX #0
.MveSta3
 STX WhichStar
 RTS
 
.TStarByte
 EQUB 8:EQUB 4:EQUB 2:EQUB 1
 EQUB &80:EQUB &40:EQUB &20:EQUB &10
 EQUB &88:EQUB &44:EQUB &22:EQUB &11
 EQUB &80:EQUB 4:EQUB &40:EQUB &11
 
.InitStars
 LDA #0:TAX
 STA WhichStar:STA VSyncCnt \ Reset important star & Event related vars.
 STA temp1:STA temp1+1
 LDA #NumStars:STA temp2
.InSta0
 JSR AtTop
 LDA temp1:CLC:ADC StarInfo,X:STA StarInfo,X
 LDA temp1+1:ADC StarInfo+1,X:STA StarInfo+1,X
 JSR rand:AND #7:EOR temp1:CLC:ADC #&40:STA temp1
 LDA temp1+1:ADC #1:STA temp1+1
 JSR rand:AND #&F:TAY
 LDA TStarByte,Y:STA StarInfo+2,X
 EOR (StarInfo,X):STA (StarInfo,X)
 INX:INX:INX
 DEC temp2:BNE InSta0
 RTS
 
.AtTop
 JSR rand:AND #1
 CLC:ADC #&59:STA StarInfo+1,X
 CMP #&5A:BEQ AtTop0
 JSR rand:AND #&F8:ORA #&40:BNE AtTop1
.AtTop0
 JSR rand:AND #&78
.AtTop1
 STA StarInfo,X
 RTS
 
.MoveMeDelay
 STA LoopA
.MoMeD0
 JSR ProcessMyBombs
 JSR TryStars
 JSR TryMe
 JSR OpKeys
 JSR fx19
 LDX #&8F:JSR check_key:BEQ MoMeD1 \ Escape
 BIT Demo:BPL MoMeD2
 JSR testspc:BEQ MoMeD1
.MoMeD2
 DEC LoopA:BNE MoMeD0
.MoMeD1
 RTS
 
\\ ]

\\ PRINT"Routine 2  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
