\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Object2"
 
 InAllDead = &00
 InInExh   = &01
 WtAllDead = &02
 WtInExh   = &03
 InAlways  = &80+4
 CtrlFor   = &80+5
 CtrlNext  = &80+6
 CtrlGoto  = &80+7
 ChMaxAlID = &08
 CtrlZonEnd = &09
 InAlDeFlp = &0A
 CtrlDummy = &0B
 InAlwFeat = &80+&C
 InExhFeat = &0D
 
\\ B%=P%
\\ [OPT pass
 
.CallInd
 JMP (temp1)
 
.InitInit
 LDA ObjSt+0:BPL InIn2
 LSR A:BCS InIn2
 
 LDA SectAddr:STA temp5
 LDA SectAddr+1:STA temp5+1
 
.InIn0
 LDY SectOff
 LDA (temp5),Y:INY
 STA temp5+2:AND #&7F:TAX
 LDA TInCommLo,X:STA temp1
 LDA TInCommHi,X:STA temp1+1
 JSR CallInd \ Jump to action address in 'temp1'
 
.InIn1
 BIT temp5+2:BMI InIn0 \ Continue interpretation
 
.InIn2
 RTS
 
.TInCommLo
 EQUB InCom0 MOD &100
 EQUB InCom1 MOD &100
 EQUB InCom2 MOD &100
 EQUB InCom3 MOD &100
 EQUB InCom4 MOD &100
 EQUB InCom5 MOD &100
 EQUB InCom6 MOD &100
 EQUB InCom7 MOD &100
 EQUB InCom8 MOD &100
 EQUB InCom9 MOD &100
 EQUB InCom10 MOD &100
 EQUB InCom11 MOD &100
 EQUB InCom12 MOD &100
 EQUB InCom13 MOD &100
 
.TInCommHi
 EQUB InCom0 DIV &100
 EQUB InCom1 DIV &100
 EQUB InCom2 DIV &100
 EQUB InCom3 DIV &100
 EQUB InCom4 DIV &100
 EQUB InCom5 DIV &100
 EQUB InCom6 DIV &100
 EQUB InCom7 DIV &100
 EQUB InCom8 DIV &100
 EQUB InCom9 DIV &100
 EQUB InCom10 DIV &100
 EQUB InCom11 DIV &100
 EQUB InCom12 DIV &100
 EQUB InCom13 DIV &100
 
.InCom0
 LDA ActAliens:ORA ActInits:BNE InCEx
 JMP InitInVarB
 
.InCom1
 LDA ActInits:BNE InCEx
 JMP InitInVarB
 
.InCom2
 LDA ActAliens:ORA ActInits:BNE InCEx
 STY SectOff:RTS
 
.InCom3
 LDA ActInits:BNE InCEx
 STY SectOff:RTS
 
.InCom4
 JMP InitInVarB
 
.InCom5
 LDA (temp5),Y:INY:STY SectOff
 STA VInFCnt:STY VInFOff
 RTS
 
.InCom6
 DEC VInFCnt:BEQ InC60
 LDA VInFOff:STA SectOff
 RTS
 
.InC60
 STY SectOff:RTS
 
.InCom7
 LDA (temp5),Y:STA SectOff
 RTS
 
.InCom8
 LDA ActAliens:ORA ActInits:BNE InCEx
 LDA (temp5),Y:INY:STY SectOff
 STA MaxAlID:STA UptoID
 
.InCEx
 RTS
 
.InCom9
 LDA ActAliens:ORA ActInits:BNE InCEx
 JSR ShowFlags
 INC level
 JSR ShowFlags
 JSR InitLev
 LDA SectAddr:STA temp5
 LDA SectAddr+1:STA temp5+1
 RTS
 
.InCom10
 LDA ActAliens:ORA ActInits:BNE InCEx
 LDA (temp5),Y:INY:STY SectOff
 PHA
 JSR InitInVar
 PLA:EOR #&80 \ Toggle reverse flag bit
 JMP InitInVar
 
.InCom11
 RTS
 
.InCom13
 LDA ActInits:BNE InCEx
 
.InCom12
 JSR InitInVarB:LDY SectOff:BCS InCom12F \ Allocation fail!
 LDA (temp5),Y:STA InitFeat,X
 LDA #AlGraBase+10:STA InitGTyp,X
 LDA #1:STA InitNum,X
.InCom12F
 INY:STY SectOff
 RTS
 
.InitInVarB
 LDA (temp5),Y:INY:STY SectOff
 
.InitInVar
 TAY:LDX #MaxInit-1
.InInVa2
 LDA InitSt,X:BPL InInVa3
 DEX:BPL InInVa2
 SEC:RTS \ Failed to allocate to 'Init' var. C=1
 
.InInVa3
 INC ActInits
 LDA #&80:STA InitSt,X
 TYA:STA temp2:STA InitPFlip,X
 AND #&7F:TAY
 LDA TPatInLo,Y:STA temp1
 LDA TPatInHi,Y:STA temp1+1
 LDY #0
 LDA (temp1),Y:STA InitPat,X
 INY:LDA (temp1),Y
 CMP #&F0:BCS InInVa0 \ If an X coordinate ctrl value, don't 'flip' it
 BIT temp2:BPL InInVa0
 STA temp2+1:LDA #XKill:SEC:SBC temp2+1
 
.InInVa0
 STA InitX,X
 INY:LDA (temp1),Y:STA InitY,X
 INY:LDA (temp1),Y
 BIT temp2:BPL InInVa1
 EOR #&FF:CLC:ADC #1
 
.InInVa1
 STA InitRelX,X
 INY:LDA (temp1),Y:STA InitRelY,X
 INY:LDA (temp1),Y:CLC:ADC #AlGraBase:STA InitGTyp,X
 INY:LDA (temp1),Y:STA InitNum,X
 INY:LDA (temp1),Y:STA InitDelay,X:STA InitRDelay,X
 CLC
 
.PrIni6
 RTS
 
.ProcessInit
 LDA ObjSt+0:BPL PrIni6 \ I'm dead/exploding
 LSR A:BCS PrIni6       \ RTS in both cases
 
 LDX #MaxInit-1
.PrIni0
 LDA InitSt,X:BPL PrIni1
 LDA InitDelay,X:BEQ PrIni2
 DEC InitDelay,X
.PrIni1
 DEX:BPL PrIni0
 RTS
 
.PrIni2
 LDA InitRDelay,X:STA InitDelay,X
 LDY MaxAlID
.PrIni3
 LDA ObjSt,Y:BPL PrIni4
 DEY:BNE PrIni3
 BEQ PrIni1 \ Always
 
.PrIni4
 DEC InitNum,X:BNE PrIni5
 LDA #0:STA InitSt,X
 DEC ActInits
 
.PrIni5
 INC ActAliens
 STX LoopA:STY LoopB           \ Save IDs and juggle them about
 LDY InitGTyp,X:LDX LoopB:JSR InitObj
 LDX LoopA:LDY LoopB
 LDA InitFeat,X:STA ObjFeat,Y
 LDA InitX,X:STA ObjX,Y
 CLC:ADC InitRelX,X:STA InitX,X
 LDA InitY,X:STA ObjY,Y
 CLC:ADC InitRelY,X:STA InitY,X
 LDA InitPat,X:STA ObjPat,Y
 LDA InitPFlip,X:STA ObjPFlip,Y
 
 LDA ObjX,Y:CMP #&F0:BCC PrIni8 \ If not a ctrl 'X' value
 JSR rand:AND #&1F
 LDX ObjPFlip,Y:BMI PrIni9
 CLC:ADC #WindMinX
 JMP PrIni10
 
.PrIni9
 STA temp1
 LDA #WindMaxX:SEC:SBC temp1
 
.PrIni10
 STA ObjX,Y
 
.PrIni8
 LDA ObjPFlip,Y:BPL PrIni7
 LDA ObjX,Y:SEC:SBC ObjXWid,Y \ Do additional X adjustment for reverse pat
 STA ObjX,Y                   \ now that 'XWid' and final 'X' are known
 
.PrIni7
 LDX #0:JSR CalcSpInfo
 JSR SusRightRout
 LDX LoopA:JMP PrIni1
 
\\ ]

\\ PRINT"Object 2   from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
