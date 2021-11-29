\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Flags"
\\ B%=P%
\\ [OPT pass
 
.LdFlagGra
\\  OPT FNLoadDat1("Section.ObFlag",&40)
INCBIN "object\Section\ObFlag.o"

.LdMiniGra
 \\ OPT FNLoadDat1("Section.ObMiniShip",&10)
INCBIN "object\Section\ObMiniShip.o"

.FlPoleGra
 EQUB 0:EQUB &88:EQUB 0:EQUB &88:EQUB 0:EQUB &88:EQUB 0:EQUB &88
 
.ShowFlags
 LDA level:LDX #0:LDY #30*8
 
.ShowFlagsB
 PHA \ Save 'level' value
 JSR xycalc:STA temp1+1:STX temp1
 TAY:TXA:CLC:ADC #&40:STA temp2:BCC ShFl4
 INY
.ShFl4
 INY:STY temp2+1
 
 PLA:BEQ ShFl0 \ RTS if 'level' = 0
 
 LDY #0
.ShFl6
 CMP #50:BCC ShFl7
 SBC #50:INY:BCS ShFl6 \ Always
 
.ShFl7
 PHA:TYA:BEQ ShFl8
 LDX #&3F:JSR ShFlGra \ Show 'fifties'
 
.ShFl8
 PLA:LDY #0
.ShFl1
 CMP #10:BCC ShFl2
 SBC #10:INY:BCS ShFl1 \ Always
 
.ShFl2
 PHA
 TYA:BEQ ShFl3
 LDX #&2F:JSR ShFlGra \ Show 'tens'
 
.ShFl3
 PLA:CMP #5:BCC ShFl5
 SBC #5:PHA
 LDX #&1F:LDY #1:JSR ShFlGra \ Show 'fives'
 PLA
 
.ShFl5
 TAY:BEQ ShFl0 \ RTS if no 'units'
 LDX #&F       \ drop through and display 'unit' flags
 
.ShFlGra
 STX temp4:STY temp3+1
.ShFlGr1
 LDY #&F:LDX temp4
.ShFlGr0
 LDA LdFlagGra,X:EOR (temp1),Y:STA (temp1),Y
 DEX:DEY:BPL ShFlGr0
 
 LDY #7
.ShFlGr2
 LDA FlPoleGra,Y:EOR (temp2),Y:STA (temp2),Y
 DEY:BPL ShFlGr2
 
 LDA temp1:CLC:ADC #&10:STA temp1:BCC ShFlGr3
 INC temp1+1
.ShFlGr3
 LDA temp2:CLC:ADC #&10:STA temp2:BCC ShFlGr4
 INC temp2+1
.ShFlGr4
 DEC temp3+1:BNE ShFlGr1
 
.ShFl0
 RTS
 
.ShowLives
 LDX #80-4:LDY #30*8:JSR xycalc
 STA temp1+1:STX temp1
 
 LDX lives:BEQ ShLi0
 DEX:BEQ ShLi0
.ShLi3
 LDY #&F
.ShLi1
 LDA LdMiniGra,Y:EOR (temp1),Y:STA (temp1),Y
 DEY:BPL ShLi1
 
 LDA temp1:SEC:SBC #&10:STA temp1:BCS ShLi2
 DEC temp1+1
.ShLi2
 DEX:BNE ShLi3
 
.ShLi0
 LDX smarts:BEQ ShSm0
 
.ShSm1
 LDY #&F
.ShSm2
 LDA SmBmbGra,Y:EOR (temp1),Y:STA (temp1),Y
 DEY:BPL ShSm2
 LDA temp1:SEC:SBC #&10:STA temp1:BCS ShSm3
 DEC temp1+1
.ShSm3
 DEX:BNE ShSm1
 
.ShSm0
 RTS
 
.SmBmbGra
 EQUB 3:EQUB &17:EQUB &3C:EQUB &7E:EQUB &7C:EQUB &3C:EQUB &17:EQUB 3
 EQUB 8:EQUB &C:EQUB &86:EQUB &C6:EQUB &CE:EQUB &86:EQUB &C:EQUB 8
 
\\ ]

\\ PRINT"Flags Etc. from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
 
\\ DEFFNLoadDat1(file$,size%)
\\ IFpass>=6 OSCLI"LOAD "+file$+" "+STR$~(O%)
\\ O%=O%+size%:P%=P%+size%
\\ =pass
