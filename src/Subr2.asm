\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Subr2"
\\ B%=P%
\\ [OPT pass
 
.ProcessAlBombs
 LDX #MaxAlBmb-1
.PrAlB0
 LDA AlBmbSt,X:BMI PrAlB1
.PrAlB2
 DEX:BPL PrAlB0
 RTS
 
.PrAlB1
 LDA AlBmbTyp,X:BMI PrAlB4    \ If a fast bomb!
 LDA counter:LSR A:BCS PrAlB2 \ Slow every other game loop
 
.PrAlB4
 JSR PlotBomb
 LDA AlBmbY,X:CLC:ADC #8:BEQ PrAlB3
 STA AlBmbY,X
 JSR PlotBomb
 JMP PrAlB2
 
.PrAlB3
 DEC ActAlBombs
 LDA #0:STA AlBmbSt,X:BEQ PrAlB2
 
.PlotBomb
 STX temp2 \ Save X
 LDY AlBmbY,X:LDA AlBmbX,X:SEC:SBC #XExcess:TAX
 JSR xycalc:STA temp1+1:STX temp1
 LDX temp2:LDA AlBmbX,X:LSR A
 BCS PlBmb0
 
 LDY #7
.PlBmb1
 LDA (temp1),Y:EOR BombGra,Y:STA (temp1),Y
 DEY:BPL PlBmb1
 RTS
 
.PlBmb0
 LDY #7
.PlBmb00
 LDA (temp1),Y:EOR BombGra0,Y:STA (temp1),Y
 DEY:BPL PlBmb00
 LDY #9:LDA #8:EOR (temp1),Y:STA (temp1),Y
 RTS
 
.InitAlBomb
 LDA ObjSt+0:BPL InABEx
 LSR A:BCS InABEx
 LDA ObjSt,X:BPL InABEx \ No bomb if alien ...
 LSR A:BCS InABEx
 LDA ObjInfo,X:ASL A:BMI InABEx \ Non-alien obj can't drop bombs
 AND #8:BNE InABEx \ If big alien, AND #8 not 4 (ASL A)
 
 LDA level:CMP #6:BCS InABm4
 JSR rand:BMI InABEx \ Additional 50/50 chance of bomb for levels<6
 
.InABm4
 LDA ObjX,X:CMP #WindMinX:BCC InABEx \ Approx. boundary checks
 CLC:ADC ObjXWid,X:CMP #WindMaxX:BCS InABEx
 LDA ObjY,X:CMP #&90:BCS InABEx \ No bombs if too far down screen
 CMP #8:BCC InABEx \ No bombs 'behind' score area
 
 LDY #MaxAlBmb-1
.InABm0
 LDA AlBmbSt,Y:BPL InABm1
 DEY:BPL InABm0
 
.InABEx
 RTS
 
.InABm1
 INC ActAlBombs
 LDA level:CMP #11:BCC InABm3 \ Slow bombs only, levels<11
 LDA ObjY,X:CMP #&48:BCS InABm3 \ Slow bombs only if too far down screen
 JSR rand:AND #&F:BNE InABm3 \ For slow bomb 15 out of 16 times
 LDA #&80:BNE InABm2 \ Always
 
.InABm3
 LDA #0 \ Slow bomb value
 
.InABm2
 STA AlBmbTyp,Y \ Bomb speed flag
 
 LDA #&80:STA AlBmbSt,Y
 LDA ObjXWid,X:LSR A:CLC:ADC ObjX,X:STA AlBmbX,Y
 LDA ObjY,X:CLC:ADC #7:AND #&F8:STA AlBmbY,Y
 TYA:TAX
 JMP PlotBomb
 
.BombGra
 EQUB &44:EQUB &0E:EQUB &44:EQUB &44:EQUB &44:EQUB &44:EQUB &44:EQUB &44
 
.BombGra0
 EQUB &11:EQUB &03:EQUB &11:EQUB &11:EQUB &11:EQUB &11:EQUB &11:EQUB &11
 
.MeAlBmbCol
 LDA ObjSt+0:BPL InABEx \ RTS if I'm dead
 LSR A:BCS InABEx
 LDX #MaxAlBmb-1
 
.MeABmC0
 LDA AlBmbSt,X:BPL MeABmC2
 
 LDA ObjX+0:SEC:SBC AlBmbX,X
 BCC MeABmC1 \ My X < BmbX
 BNE MeABmC2 \ No X collision
 BEQ MeABmC4 \ Now see if Y is in collision
 
.MeABmC1
 EOR #&FF:ADC #1
 CMP ObjXWid+0:BCS MeABmC2 \ No X collision
 
.MeABmC4
 LDA ObjY+0:SEC:SBC AlBmbY,X
 BCS MeABmC3 \ My Y >= BmbY
 
 EOR #&FF:ADC #1
 CMP #8:BCS MeABmC2 \ No Y collision
 BCC MeABmC5 \ Always, has collided
 
.MeABmC3
 CMP ObjHei+0:BCS MeABmC2 \ No Y collision
 
.MeABmC5
 JSR PlotBomb \ Remove bomb that hit me
 DEC ActAlBombs
 LDA #0:STA AlBmbSt,X
 LDA #DDVal:STA DieDelay
 JSR ExplNoB
 JMP DestrAll \ Kill ALL objs
 
.MeABmC2
 DEX:BPL MeABmC0
 RTS
 
.Extras
 LDX #&8E:JSR check_key:BEQ ToM1 \ f1
 LDX #&8B:JSR check_key:BNE ExtEx \ f5
 
\ Mode 5
 
 LDX #&C4:LDY #7:BNE To6845r
 
.ToM1
 LDX #&D8:LDY #3
 
.To6845r
 SEI
 LDA #154:JSR osbyte \ Write video ULA control reg. & OS copy
 LDX #3
.To6845r0
 STX &FE00:LDA T6845val,Y:STA &FE01
 DEY:DEX:BPL To6845r0
 CLI
 
.ExtEx
 RTS
 
.T6845val
 EQUB &7F:EQUB &28:EQUB &4F:EQUB &28 \ Mode 1 reg 0 to 3
 
 EQUB &3F:EQUB &28:EQUB &31:EQUB &24 \ Mode 5 reg 0 to 3
 
.Options
 LDX #2:LDY #2:JSR vdu19 \ Colour 2 to green
 LDX #&AD:JSR check_key:BNE Opti3 \ If C not pressed (Cheat key!)
 LDA #49:STA HighestLev \ Allow access to levels upto 49!
 LDA #1:STA StrtLev
 
.Opti3
 JSR TryStars
 LDX #&B6:JSR check_key:BEQ Opti3 \ Wait until Return released
 
 LDY #18:JSR pstring \ Display 'options' information
 JSR OpShoFB \ Show highest level
 JSR OpShoF  \ Show curr start level
.Opti0
 JSR fx19
 JSR TryStars
 LDX #3:JSR OpKeysB \ Check P S K and CTRL!
 LDX #&B6:JSR check_key:BEQ Opti1 \ Exit when Return pressed
 LDA VSyncMast:AND #7:BNE Opti0  \ Drop through every 8th frame
 
 LDX #&C6:JSR check_key:BNE Opti5 \ Cur Up
 JSR OpShoF \ Erase last level
 JSR TryStars
 LDX StrtLev:INX
 CPX HighestLev:BCC Opti2:BEQ Opti2
.Opti4
 LDX #1
.Opti2
 STX StrtLev
 JSR OpShoF \ Show new level
 JMP Opti0
 
.Opti5
 LDX #&D6:JSR check_key:BNE Opti0 \ Cur Down
 JSR OpShoF
 JSR TryStars
 LDX StrtLev:DEX:BNE Opti2
 LDX HighestLev:BNE Opti2
 
.Opti1
 JSR TryStars
 LDX #&B6:JSR check_key:BEQ Opti1 \ Return release
 
 LDY #18:JSR pstring \ Erase 'options' information
 JSR OpShoFB \ Erase highest level reached flags
 
\ Drop through and erase start level flags
 
.OpShoF
 LDA StrtLev
 LDX #28:LDY #19*8:JMP ShowFlagsB \ start level
 
.OpShoFB
 LDA HighestLev
 LDX #28:LDY #13*8:JMP ShowFlagsB \ highest lev reached
 
\\ ]

\\ PRINT"Subr. 2    from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%:RETURN
