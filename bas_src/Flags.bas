  � SAVE"$.Galaforce2.Flags" 
	B%=P% [OPT pass   (.LdFlagGra 2( OPT �LoadDat1("Section.ObFlag",&40) <  F.LdMiniGra P, OPT �LoadDat1("Section.ObMiniShip",&10) Z  d.FlPoleGra nD EQUB 0:EQUB &88:EQUB 0:EQUB &88:EQUB 0:EQUB &88:EQUB 0:EQUB &88 x  �.ShowFlags � LDA level:LDX #0:LDY #30*8 �  �.ShowFlagsB � PHA \ Save 'level' value �% JSR xycalc:STA temp1+1:STX temp1 �- TAY:TXA:CLC:ADC #&40:STA temp2:BCC ShFl4 � INY �
.ShFl4 � INY:STY temp2+1 �  �' PLA:BEQ ShFl0 \ RTS if 'level' = 0 �  LDY #0
.ShFl6 CMP #50:BCC ShFl7"# SBC #50:INY:BCS ShFl6 \ Always, 6
.ShFl7@ PHA:TYA:BEQ ShFl8J* LDX #&3F:JSR ShFlGra \ Show 'fifties'K L
.ShFl8T PLA:LDY #0^
.ShFl1h CMP #10:BCC ShFl2r# SBC #10:INY:BCS ShFl1 \ Always| �
.ShFl2� PHA� TYA:BEQ ShFl3�' LDX #&2F:JSR ShFlGra \ Show 'tens'� �
.ShFl3� PLA:CMP #5:BCC ShFl5� SBC #5:PHA�/ LDX #&1F:LDY #1:JSR ShFlGra \ Show 'fives'� PLA� �
.ShFl5�& TAY:BEQ ShFl0 \ RTS if no 'units': LDX #&F       \ drop through and display 'unit' flags .ShFlGra& STX temp4:STY temp3+10.ShFlGr1: LDY #&F:LDX temp4D.ShFlGr0N. LDA LdFlagGra,X:� (temp1),Y:STA (temp1),YX DEX:DEY:BPL ShFlGr0b l LDY #7v.ShFlGr2�. LDA FlPoleGra,Y:� (temp2),Y:STA (temp2),Y� DEY:BPL ShFlGr2� �1 LDA temp1:CLC:ADC #&10:STA temp1:BCC ShFlGr3� INC temp1+1�.ShFlGr3�1 LDA temp2:CLC:ADC #&10:STA temp2:BCC ShFlGr4� INC temp2+1�.ShFlGr4� DEC temp3+1:BNE ShFlGr1� �
.ShFl0� RTS .ShowLives# LDX #80-4:LDY #30*8:JSR xycalc  STA temp1+1:STX temp1* 4 LDX lives:BEQ ShLi0> DEX:BEQ ShLi0H
.ShLi3R LDY #&F\
.ShLi1f. LDA LdMiniGra,Y:� (temp1),Y:STA (temp1),Yp DEY:BPL ShLi1z �/ LDA temp1:SEC:SBC #&10:STA temp1:BCS ShLi2� DEC temp1+1�
.ShLi2� DEX:BNE ShLi3� �
.ShLi0� LDX smarts:BEQ ShSm0� �
.ShSm1� LDY #&F�
.ShSm2�- LDA SmBmbGra,Y:� (temp1),Y:STA (temp1),Y� DEY:BPL ShSm2/ LDA temp1:SEC:SBC #&10:STA temp1:BCS ShSm3 DEC temp1+1
.ShSm3$ DEX:BNE ShSm1. 8
.ShSm0B RTSL V.SmBmbGra`H EQUB 3:EQUB &17:EQUB &3C:EQUB &7E:EQUB &7C:EQUB &3C:EQUB &17:EQUB 3jF EQUB 8:EQUB &C:EQUB &86:EQUB &C6:EQUB &CE:EQUB &86:EQUB &C:EQUB 8t ~]�9�"Flags Etc. from &";~B%;" to &";~P%-1;" (";P%-B%;")"�	�=PG%��� �ݤLoadDat1(file$,size%)�&�pass>=6 �"LOAD "+file$+" "+�~(O%)�O%=O%+size%:P%=P%+size%�	=pass�