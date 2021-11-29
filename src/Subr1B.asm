\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Subr1B"
\\ B%=P%
\\ [OPT pass
 
\ Smart bomb
 
.ExplNoD
 LDX #FxEx6 MOD &100:LDY #FxEx6 DIV &100:JSR SoundFx
 LDX #FxEx7 MOD &100:LDY #FxEx7 DIV &100:JMP SoundFx
 
\ Alien 'injured' FX (needs to be shot more)
 
.ExplNoC
 LDX #FxEx4 MOD &100:LDY #FxEx4 DIV &100:JSR SoundFx
 LDX #FxEx5 MOD &100:LDY #FxEx5 DIV &100:JMP SoundFx
 
\ My ship exploding (Also when Escape pressed)
 
.ExplNoB
 LDX #FxEx3 MOD &100:LDY #FxEx3 DIV &100:JSR SoundFx
 LDX #FxEx5 MOD &100:LDY #FxEx5 DIV &100:JMP SoundFx
 
\ Alien exploding FX
 
.ExplNoise
 LDX #FxEx1 MOD &100:LDY #FxEx1 DIV &100
.ExNo0
 JSR SoundFx
 LDX #FxEx2 MOD &100:LDY #FxEx2 DIV &100:JMP SoundFx
 
.FxEx1
 EQUW &10:EQUW -13:EQUW 7:EQUW 4
.FxEx2
 EQUW &11:EQUW 1:EQUW 170:EQUW 4
 
.FxEx3
 EQUW &10:EQUW -13:EQUW 7:EQUW 10
 
.FxEx4
 EQUW &10:EQUW -9:EQUW 7:EQUW 10
.FxEx5
 EQUW &11:EQUW 1:EQUW 200:EQUW 10
 
.FxEx6
 EQUW &10:EQUW -13:EQUW 7:EQUW 14
.FxEx7
 EQUW &11:EQUW 1:EQUW 240:EQUW 14
 
.MeAlienCol
 LDA ObjSt+0:BPL MeAlCol5 \ I'm dead
 LSR A:BCC NoFePro \ I'm not exploding
.MeAlCol5
 JMP MeAlColEx
 
.NoFePro
 LDX MaxAlID
.MeAlCol0
 LDA ObjSt,X:BPL MeAlColNo
 LSR A:BCS MeAlColNo
 LDA ObjDestr,X:BMI MeAlColNo
 LDA ObjX,X:SEC:SBC ObjX+0
 BCS MeAlCol1
 
 EOR #&FF:ADC #1
 CMP ObjXWid,X:BCS MeAlColNo
 BCC MeAlCol2
 
.MeAlCol1
 CMP ObjXWid+0:BCS MeAlColNo
 
.MeAlCol2
 LDA ObjY,X:SEC:SBC ObjY+0
 BCS MeAlCol3
 
 EOR #&FF:ADC #1
 CMP ObjHei+0:BCS MeAlColNo
 
.MeAlColYes
 LDA ObjInfo,X:ASL A:BMI MeAlFeat \ If non-alien object
 LDA Feature:CMP #11:BEQ MeAlCol4
 LDA #DDVal:STA DieDelay \ Del in game cycles AFTER my ship has been era.
 JSR ExplNoB
 JMP DestrAll \ Make process.code kill all objs
 
.MeAlCol4
 SEC:ROR ObjDestr,X
 TXA:PHA
 LDY ObjGTyp,X:LDA TGTypScore,Y:JSR AddScr:JSR ExplNoise
 PLA:TAX
 JMP MeAlColNo
 
.MeAlFeat
 JSR FeatPro:JMP MeAlColNo
 
.MeAlCol3
 CMP ObjHei,X:BCC MeAlColYes
 
.MeAlColNo
 DEX:BNE MeAlCol0
 
.MeAlColEx
 RTS
 
.DoSmart
 BIT Demo:BMI MeAlColEx
 LDA ObjSt+0:BPL MeAlColEx
 LSR A:BCS MeAlColEx
 
 LDX #&FF:JSR check_key:BNE DoSm0
 
 BIT SmartFlg:BMI MeAlColEx
 LDA smarts:BEQ MeAlColEx
 
 LDX #TotObj-1
.DoSm2
 LDA ObjSt,X:BPL DoSm3
 LSR A:BCS DoSm3
 LDA ObjHits,X:SBC #9:BCS DoSm4
 LDA #0
.DoSm4
 STA ObjHits,X
 BNE DoSm3
 LDA #&80:STA ObjDestr,X
.DoSm3
 DEX:BNE DoSm2
 
 JSR ShowLives:DEC smarts:JSR ShowLives
 JSR ExplNoD
 LDA #&FF:BMI DoSm1
 
.DoSm0
 LDA #0
.DoSm1
 STA SmartFlg
 RTS
 
\ 'FeatPro' A=ObjInfo,X << 1
 
.FeatPro
 ASL A:BMI MeAlFe2 \ If B5=1, object has been collected already
 LDA ObjInfo,X:ORA #&20:STA ObjInfo,X \ Set 'collected' bit
 LDY ObjFeat,X
 CPY #8:BEQ MeAlFe6 \ If smart bomb
 
 LDA Feature
 STY Feature
 CMP #11:BNE NoCh \ If not protective shield
 LDA #1:STA ShipInfo \ Change to 2nd ship!
 
.NoCh
 CPY #11:BEQ MeAlFe5 \ Protective shield
 CPY #10:BEQ MeAlFe1 \ 1000pts
 CPY #9:BEQ MeAlFe3  \ Xtra life
 CPY #5:BEQ MeAlFe8  \ Explosive container
 BNE MeAlFe4
 
.MeAlFe6
 TXA:PHA
 LDA smarts:CMP #3:BCS MeAlFe7
 JSR ShowLives:INC smarts:JSR ShowLives
 LDX #FxXtra MOD &100:LDY #FxXtra DIV &100:JSR SoundFx
.MeAlFe7
 PLA:TAX
 
.MeAlFe4
 SEC:ROR ObjDestr,X \ Kill obj
.MeAlFe2
 RTS
 
.MeAlFe1
 LDA #&80:STA ObjSt,X
 LDA #48:STA ObjPat,X \ 1000 gra init patt
 LDA #0:STA ObjPOff,X:STA ObjDirCnt,X
 TXA:PHA:LDA #100:JSR AddScr:PLA:TAX
 RTS
 
.MeAlFe3
 LDA lives:CMP #5:BCS MeAlFe4
 LDA #&80:STA ObjSt,X
 TXA:PHA
 JSR ShowLives
 INC lives
 JSR ShowLives:JSR ShwLiv
 LDX #FxXtra MOD &100:LDY #FxXtra DIV &100:JSR SoundFx
 PLA:TAX
 LDA #49:STA ObjPat,X
 LDA #0:STA ObjPOff,X:STA ObjDirCnt,X
 RTS
 
.MeAlFe5
 LDA #2:STA ShipInfo
 BNE MeAlFe4 \ Always
 
.MeAlFe8
 TXA:PHA
 JSR ExplNoB
 JSR DestrAll
 LDA #DDVal:STA DieDelay
 PLA:TAX
 RTS
 
.FxXtra
 EQUW &13:EQUW 3:EQUW 60:EQUW 25
 
.DestrAll
 LDX #TotObj-1:LDA #&80
.DesAl0
 STA ObjDestr,X
 DEX:BPL DesAl0
 
 LDA #&81:STA ObjSt+0 \ IMMEDIATELY halt Alien init/processing
 RTS
 
\\ ]

\\ PRINT"Subr. 1B   from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%:RETURN
