\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Subr1C"
\\ B%=P%
\\ [OPT pass
 
.ClrArrows
 LDY #0:JSR ClrArrowB
 LDY #1
 
.ClrArrowB
 JSR CalArrInf
 LDA #0
.ClAr0
 STA (temp1),Y:DEY:BPL ClAr0
 RTS
 
.EorArrow
 LDY Player
.EorArrowB
 JSR CalArrInf
.EoAr0
 LDA ArrowGra,X:EOR (temp1),Y:STA (temp1),Y
 DEX:DEY:BPL EoAr0
 RTS
 
.PutArrow
 LDY Player
 JSR CalArrInf
.PuAr0
 LDA ArrowGra,X:STA (temp1),Y
 DEX:DEY:BPL PuAr0
 RTS
 
.TArrwX
 EQUB 28:EQUB 48
 
.CalArrInf
 STY temp2
 LDX TArrwX,Y:LDY #0:JSR xycalc
 STA temp1+1:STX temp1
 LDX #&F:LDA temp2:BEQ ClArIn0
 LDX #&1F
.ClArIn0
 LDY #&F
 RTS
 
.TNegKey
 EQUB &C8:EQUB &AE:EQUB &B9:EQUB &FE \ P S K CTRL
 
.OpKeys
 LDX #2 \ Default key check, P S K (not 1/2 players)
 
.OpKeysB
 LDA VSyncMast:AND #&F:BNE OpKeEx
 
 STX LoopB
.OpKe0
 LDY LoopB:LDX TNegKey,Y:JSR check_key
 BNE OpKe1
 JSR ProcOp
.OpKe1
 DEC LoopB:BPL OpKe0
.OpKeEx
 RTS
 
.ProcOp
 JSR PlotTog \ Plot last letter then toggle flag & char
 LDA LoopB:CMP #2:BCS NoFlh
 JSR flush   \ FX 15,0 clear all buffers
.NoFlh
 LDY LoopB:BNE PlotOpt \ If not pause option
 
.ProcO0
 JSR chkp:BEQ ProcO0 \ Wait until released
 JSR PlotOpt         \ Show P
.ProcO1
 JSR chkp:BNE ProcO1 \ Wait until pressed
.ProcO2
 JSR chkp:BEQ ProcO2 \ Wait until released
 
.PlotTog
 JSR PlotOpt
 LDY LoopB
 LDA TCurChr,Y:EOR TEorChr,Y:STA TCurChr,Y
 LDA FlagBase,Y:EOR #&80:STA FlagBase,Y
 RTS
 
.PlotOpt
 LDY LoopB
.PlotOptB
 LDA TChrX,Y:STA TxOptChr+0
 LDA TChrY,Y:STA TxOptChr+1
 LDA TChrCol,Y:STA TxOptChr+2
 LDA TCurChr,Y:STA TxOptChr+3
 LDY #16:JMP pstring \ Erase/Display option letter
 
.TChrX
 EQUB 76:EQUB 74:EQUB 70:EQUB 68 \ P S K CTRL
 
.TChrY
 EQUB &F8+2:EQUB &F8+0:EQUB &F8+2:EQUB &F8+0 \ P S K CTRL
 
.TChrCol
 EQUB &08:EQUB &88:EQUB &08:EQUB &88 \ P S K CTRL
 
.TCurChr
 EQUB ' '-32:EQUB 'S'-32:EQUB 'K'-32:EQUB '1'-32
 
.FlagBase
.FPause  EQUB &00 \ Default pause off
.FSound  EQUB &80 \ sound on
.FKeyJoy EQUB &80 \ keyboard
.FnumPlyr EQUB &00 \ 1 player
 
.TEorChr
 EQUB ' '-32 EOR 'P'-32
 EQUB 'S'-32 EOR 'Q'-32
 EQUB 'K'-32 EOR 'J'-32
 EQUB '1'-32 EOR '2'-32
 
\\ ]

\\ PRINT"Subr. 1C   from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%:RETURN
