\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.High"
\\ B%=P%
\\ [OPT pass
 
\ This routine handles a 6 entry high score where the names are 16 chars.
\ long and the score is 7 chars.
\ Format is  0000000ABCDEFGHIJKLMNOP for each entry
 
.ti23
 EQUB 0:EQUB 23:EQUB 46:EQUB 69:EQUB 92:EQUB 115
 
\ See if score if good enough for a new high score
 
.hig
 BIT Demo:BMI higex \ Ignore high score check in demo mode
 LDX #0:STX temp2 \ Entry counter
.hig0
 LDY ti23,X:STY temp2+1 \ Offset start for current entry 0,23,46..
 DEY:LDX #&FF
.hig1
 INY:INX:CPX #7:BEQ hig3
 LDA score,X:CLC:ADC #'0'-32 \ Convert to my ascii
 CMP HSBase,Y
 BEQ hig1
 BCC hig2
 BNE hig3
.hig2
 INC temp2:LDX temp2 \ Next entry
 CPX #6:BCC hig0
.higex
 RTS \ score not in high score table, so exit
 
\ Shuffle names down from the new entry position so that the new
\ entry can be inserted
 
.hig3
 LDA temp2:PHA \ Save entry number (0-5) on stack for input routine
 CMP #5:BEQ hig5 \ Don't shuffle down if last entry in table
 LDY #5*23 \ point to 1st byte of last entry, the DEY will then adjust ok!
.hig4
 DEY
 LDA HSBase,Y:STA HSBase+23,Y \ Copy names up memory 1 entry
 CPY temp2+1 \ Has start of source offset been copied and reached yet?
 BNE hig4
 
\ Copy the new score into the table at the correct position and then
\ fill the name field with space characters
 
.hig5
 LDY temp2+1 \ Read start offset for current entry
 TYA:PHA \ Save start offset for current entry (used by input routine)
 LDX #0
.hig6
 LDA #' '-32 \ My ascii for space
 CPX #7:BCS hig7 \ Branch if accesing the name field
 LDA score,X:CLC:ADC #'0'-32 \ Convert score value into my ascii digits
.hig7
 STA HSBase,Y
 INY:INX
 CPX #23:BCC hig6
 
 LDY #12:JSR pstring \ 'A NEW HIGH SCORE!'
 JSR phi \ Display the high score table
 LDY #25:JSR frame_delay \ Short delay after tune/time to release space
 
 PLA:STA LoopA \ Save start offset for new entry
 PLA:ASL A:ASL A:ASL A:ASL A \ entry value (0-5) times 16
 ADC #10*8 \ Add offset to Y position for input
 STA TxEntry+1:STA TxEnt0+1:STA TxEnt1+1
 STA TxChar+1:LDX #28:STX TxChar \ Set up position of input char!
 
 LDX #&FF:JSR kbdonof \ Turn kbd irqs on again
 LDA #21:LDX #0:JSR osbyte \ Flush kbd buffer only!
 LDY #28:JSR PlayTune
 JSR pitcur \ Put on cursor
 LDA #0:STA LoopB \ Next free name counter
 BEQ gtn0 \ Always
 
.gtn1
\       LDA #7 JSR oswrch
.gtn2
 STX LoopA:STY LoopB
.gtn0
 JSR TryStars
 LDA #202:LDX #&20:LDY #0:JSR osbyte \ Caps Lock on/Shift Lock off
 LDA #&7E:JSR osbyte \ Clear escape condition
 LDA #&81:LDX #1:LDY #0:JSR osbyte \ Get character
 BCS gtn0 \ If time-out or escape detected
 TXA \ Put ascii value of key into A
 LDX LoopA \ Offset from 'HSBase' for next input character
 LDY LoopB \ Next free name counter (0-15) if 16 can only delete/return
 
 CMP #&D:BEQ gtnex \ Return has ended input
 CMP #&7F:BEQ gtn3 \ If delete pressed
 
 CPY #16:BEQ gtn1 \ Name 'full', can only press delete or return
 CMP #'Z'+1:BCS gtn1 \ Beep, invalid char
 SBC #' '-1 \ Subtract ASC " " for my ascii, with fudge because c=0
 BCC gtn1 \ Beep, invalid char
 STA HSBase+7,X \ Save in table in the name field, NOT in the score part!
 JSR pitcur \ Erase cursor
 LDA HSBase+7,X \ Restore input character
 STA TxChar+3 \ Save in 'pstring' character position
 JSR pit \ Print new character
 
 LDA TxChar:CLC:ADC #3:STA TxChar \ Move right 6 (3*2) pixels
 LDA TxChar+1:EOR #2:STA TxChar+1
 JSR pitcur \ Put cursor on
 INX:INY \ Increase pointer and counter
 BPL gtn2 \ always
 
.gtn3
 CPY #0:BEQ gtn1 \ Can't delete when no characters entered
 JSR pitcur \ Erase cursor
 LDA TxChar:SEC:SBC #3:STA TxChar \ Move left 6 (3*2) pixels
 LDA TxChar+1:EOR #2:STA TxChar+1
 DEX \ 'HSBase' offset back to last character
 LDA HSBase+7,X:STA TxChar+3 \ Read last char and put in 'pstring' block
 JSR pit \ Erase last character
 LDA #' '-32:STA HSBase+7,X \ Put space into erased character place
 JSR pitcur \ Put cursor on
 DEY:JMP gtn2 \ Branch won't reach!
 
.pitcur
 LDA #'-'-32:STA TxChar+3 \ Put on cursor
.pit
 TXA:PHA:TYA:PHA
 LDY #10:JSR pstring
 PLA:TAY:PLA:TAX
 RTS
 
.gtnex
 LDY #20:JSR frame_delay
 JSR pitcur \ Erase cursor
 LDY #12:JSR pstring \ Erase 'A NEW HIGH SCORE!'
 JSR phi \ Erase high score table
 LDX #0 \ Value to disable kbd
 
.kbdonof
 LDA #178:LDY #0:JMP osbyte \ FX 178 disables KBD irqs
 
.phi
 LDY #10*8:STY TxEntry+1:STY TxEnt0+1:STY TxEnt1+1
 LDX #0:STX LoopA \ Entry counter
 
.phi0
 TXA:CLC:ADC #'1'-32 \ Make 0,1,2.. into my ascii chars 1,2,3
 STA TxEntry+3
 LDY ti23,X
 LDX #0
.phi1
 LDA HSBase,Y:STA TxEnt0+3,X
 INY:INX:CPX #7:BCC phi1
 LDX #0
.phi2
 LDA HSBase,Y:STA TxEnt1+3,X
 INY:INX:CPX #16:BCC phi2
 LDY #8:JSR pstring
 LDA TxEntry+1:CLC:ADC #16 \ Down two character rows
 STA TxEntry+1:STA TxEnt0+1:STA TxEnt1+1
 INC LoopA:LDX LoopA:CPX #6:BCC phi0
 RTS
 
\\ ]

\\ PRINT"High       from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
