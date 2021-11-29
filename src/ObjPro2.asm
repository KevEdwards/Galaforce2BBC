\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.ObjPro2"
\\ B%=P%
\\ [OPT pass
 
\ 'MoveObject' processes the movement of an object using its pattern
\ data, or in the case of my ship, the contents of 'XIndex' and 'YIndex'
\ are used.
 
\ On Entry 'CurrId' = Valid ID of object being moved
 
.MoveObject
 LDX CurrId:BNE MvObj0 \ If not my ID
 
 LDA ObjSt+0:LSR A:BCS MvObj2 \ Don't move me if I'm exploding
 
 LDA ShipInfo:AND #3:CLC:ADC #1
 CMP ObjGTyp+0:BEQ MveNewG \ No graphic change
 TAY:LDX #0:JSR InitObj
 
.MveNewG
 LDA ObjX+0:CLC:ADC XIndex
 CMP #WindMinX:BCC FlpDemDir
 CMP #WindMaxX-6:BCS FlpDemDir
 STA ObjX+0:JMP MvObj1
 
.FlpDemDir
 LDA DemoDir:EOR #&80:STA DemoDir \ Done even if not in demo mode
 
.MvObj1
 LDA ObjY+0:CLC:ADC YIndex
 CMP #&98:BCC MvObj2
 CMP #&F0:BCS MvObj2
 STA ObjY+0
.MvObj2
 RTS
 
.MvObj0
 LDA ObjSt,X:LSR A:BCS MvObj2 \ RTS, Don't move an exploding object
 LDA ObjDirCnt,X:BNE MvObj3
.MvObj7
 LDA ObjSt,X:LSR A:BCS MvObj2 \ RTS if it has been killed
 LDY ObjPat,X
 LDA TPatDatLo,Y:STA temp1
 LDA TPatDatHi,Y:STA temp1+1
 LDY ObjPOff,X
 LDA (temp1),Y:STA ObjDirCnt,X
 INY:LDA (temp1),Y:STA ObjRelY,X \ Temp hold of Packed RelX/Y! OR Param
 INY:TYA:STA ObjPOff,X
 
 LDA ObjDirCnt,X:BPL MvObj5
 AND #&7F:TAY
 LDA TPatComLo,Y:STA temp2
 LDA TPatComHi,Y:STA temp2+1
 JMP (temp2)
 
.MvObj5
 LDA ObjRelY,X:AND #&F
 LDY ObjPFlip,X:BPL MvObj6
 EOR #8
.MvObj6
 TAY:LDA TRelXCon,Y:STA ObjRelX,X
 LDA ObjRelY,X
 LSR A:LSR A:LSR A:LSR A:TAY
 LDA TRelYCon,Y:STA ObjRelY,X
 
.MvObj3
 DEC ObjDirCnt,X
 LDA ObjX,X:CLC:ADC ObjRelX,X
 CMP #XKill:BCC MvObj4
 JMP KillObj \ Explode object and RTS
 
.MvObj4
 STA ObjX,X
 LDA ObjY,X:CLC:ADC ObjRelY,X
 STA ObjY,X
 RTS
 
.TRelXCon
 EQUB 0:EQUB +1:EQUB +2:EQUB +3:EQUB +4:EQUB +5:EQUB +6:EQUB +7
 EQUB 0:EQUB -1:EQUB -2:EQUB -3:EQUB -4:EQUB -5:EQUB -6:EQUB -7
 
.TRelYCon
 EQUB 0:EQUB +2:EQUB +4:EQUB +6:EQUB +8:EQUB +10:EQUB +12:EQUB +14
 EQUB 0:EQUB -2:EQUB -4:EQUB -6:EQUB -8:EQUB -10:EQUB -12:EQUB -14
 
.TPatComLo
 EQUB MvNewInd MOD &100
 EQUB MvFor MOD &100
 EQUB MvNext MOD &100
 EQUB MvDie MOD &100
 EQUB MvInAl MOD &100
 EQUB MvRndPat MOD &100
 EQUB MvBotSeg MOD &100
 EQUB MvNewGra MOD &100
 EQUB MvHomeIn MOD &100
 EQUB MvRndInAl MOD &100
 EQUB MvNewPat MOD &100
 EQUB MvTopSeg MOD &100
 
.TPatComHi
 EQUB MvNewInd DIV &100
 EQUB MvFor DIV &100
 EQUB MvNext DIV &100
 EQUB MvDie DIV &100
 EQUB MvInAl DIV &100
 EQUB MvRndPat DIV &100
 EQUB MvBotSeg DIV &100
 EQUB MvNewGra DIV &100
 EQUB MvHomeIn DIV &100
 EQUB MvRndInAl DIV &100
 EQUB MvNewPat DIV &100
 EQUB MvTopSeg DIV &100
 
.MvNewInd
 LDA ObjRelY,X:STA ObjPOff,X
 JMP MvObj7
 
.MvFor
 LDA ObjRelY,X:STA ObjFCnt,X
 LDA ObjPOff,X:STA ObjFOff,X
 JMP MvObj7
 
.MvNext
 DEC ObjFCnt,X:BEQ MvNex0
 LDA ObjFOff,X:STA ObjPOff,X
 JMP MvObj7
 
.MvNex0
 DEC ObjPOff,X
 JMP MvObj7
 
.MvDie
 JSR KillObj
 JMP MvObj7
 
.MvRndInAl
 JSR rand:AND #7:BNE MvInA2
 
.MvInAl
 LDA ObjSt+0:BPL MvInA2 \ No alien init if I'm dead or exploding
 LSR A:BCS MvInA2
 
 LDY MaxAlID
.MvInA0
 LDA ObjSt,Y:BPL MvInA1
 DEY:BNE MvInA0
 
.MvInA2
 INC ObjPOff,X \ Make sure pointer skips over the two param bytes
 JMP MvObj7
 
.MvInA1
 LDA NewAlID:BNE MvInA2 \ No new init if another is waiting to be init
                        \ shouldn't occur, but just in case!
 INC ActAliens
 STY NewAlID \ Save new alien ID 'flag' for plotting in 'ObjPro'
 LDA ObjX,X:STA ObjX,Y
 LDA ObjY,X:STA ObjY,Y
 LDA ObjPFlip,X:STA ObjPFlip,Y
 LDA ObjRelY,X:STA ObjPat,Y   \ 1st param is new alien's pattern
 
 LDY ObjPOff,X:INC ObjPOff,X \ Adjust for param byte 2
 LDA (temp1),Y:CLC:ADC #AlGraBase:TAY \ 2nd param is graphic type of alien
 LDX NewAlID:JSR InitObj \ Set up variables for new object
 LDA ObjY,X:CLC:ADC ObjHei,X:STA ObjY,X
 LDA ObjXWid,X:LSR A:CLC:ADC ObjX,X:STA ObjX,X
 LDX CurrId:JMP MvObj7 \ Restore ID of object originally being processed
 
.MvRndPat
 JSR rand:BMI MvRnP0 \ 50/50 chance of new pattern being taken
.MvNewPat
 LDA ObjRelY,X:STA ObjPat,X
 LDA #0:STA ObjPOff,X
 
.MvRnP0
 JMP MvObj7
 
.MvBotSeg
 LDA ObjY,X:CMP #&D8:BCS MvBot0
 LDA ObjRelY,X:STA ObjPOff,X
.MvBot0
 JMP MvObj7
 
.MvNewGra
 LDA ObjPOff,X:PHA \ InitObj 0s pattern offset, so must be saved
 LDA ObjRelY,X:CLC:ADC #AlGraBase:TAY:JSR InitObj
 PLA:STA ObjPOff,X
 JMP MvObj7
 
.MvHomeIn
 LDA ObjX,X:CMP ObjX+0:BCC MvHo0
 LDA #&80:BMI MvHo1
.MvHo0
 LDA #0
.MvHo1
 STA ObjPFlip,X
 DEC ObjPOff,X
 JMP MvObj7
 
.MvTopSeg
 LDA ObjY,X:CMP #&40:BCC MvTop0
 LDA ObjRelY,X:STA ObjPOff,X
.MvTop0
 JMP MvObj7
 
\\ ]

\\ PRINT"Obj.Pro. 2 from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
