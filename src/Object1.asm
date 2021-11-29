\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Object1"
\\ B%=P%
\\ [OPT pass
 
.InitObj
 LDA #&80
 STA ObjSt,X
 LDA #0
 STA ObjPOff,X
 STA ObjDestr,X
 STA ObjDirCnt,X
 
.InitObjB
 TYA:STA ObjGTyp,X
 LDA TGTypConv,Y:STA ObjGra,X
 LDA TSpWid,Y:STA ObjWid,X
 LDA TSpXWid,Y:STA ObjXWid,X
 LDA TSpHei,Y:STA ObjHei,X
 LDA TSpNFrm,Y:STA ObjNumFrm,X:STA ObjFrm,X
 LDA TSpHits,Y:STA ObjHits,X
 LDA TSpInfo,Y:STA ObjInfo,X
 RTS
 
.TSpWid
 EQUB 4:EQUB 4:EQUB 4:EQUB 4
 EQUB 4:EQUB 4:EQUB 4:EQUB 4:EQUB 4:EQUB 4
 EQUB 4:EQUB 4:EQUB 4:EQUB 4:EQUB 4:EQUB 4
 EQUB 3:EQUB 2
 EQUB 4:EQUB 4:EQUB 4:EQUB 4
 
.TSpXWid
 EQUB 7:EQUB 7:EQUB 7:EQUB 7
 EQUB 7:EQUB 7:EQUB 7:EQUB 7:EQUB 7:EQUB 7
 EQUB 7:EQUB 7:EQUB 7:EQUB 7:EQUB 7:EQUB 7
 EQUB 5:EQUB 3
 EQUB 7:EQUB 7:EQUB 7:EQUB 7
 
.TSpHei
 EQUB 16:EQUB 16:EQUB 16:EQUB 16
 EQUB 16:EQUB 16:EQUB 16:EQUB 16:EQUB 16:EQUB 16
 EQUB 16:EQUB 16:EQUB 16:EQUB 16:EQUB 16:EQUB 7
 EQUB 8:EQUB 8
 EQUB 32:EQUB 32:EQUB 32:EQUB 32
 
.TSpNFrm
 EQUB 6-1:EQUB 1-1:EQUB 1-1:EQUB 1-1
 EQUB 1-1:EQUB 1-1:EQUB 1-1:EQUB 1-1:EQUB 1-1:EQUB 1-1
 EQUB 1-1:EQUB 1-1:EQUB 1-1:EQUB 1-1:EQUB 2-1:EQUB 1-1
 EQUB 1-1:EQUB 2-1
 EQUB 1-1:EQUB 1-1:EQUB 1-1:EQUB 1-1
 
.TSpHits
 EQUB 1:EQUB 1:EQUB 1:EQUB 1
 EQUB 1:EQUB 1:EQUB 1:EQUB 1:EQUB 1:EQUB 2
 EQUB 2:EQUB 2:EQUB 12:EQUB 1:EQUB 2:EQUB 1
 EQUB 1:EQUB 1
 EQUB 32:EQUB 32:EQUB 36:EQUB 36
 
.TSpInfo
 EQUB 0:EQUB 0:EQUB &80:EQUB 0
 EQUB 0:EQUB 0:EQUB 0:EQUB 0:EQUB 0:EQUB 0
 EQUB 0:EQUB 0:EQUB &82:EQUB 0:EQUB &48:EQUB &61
 EQUB &61:EQUB 1
 EQUB 6:EQUB 6:EQUB 6:EQUB 6
 
.TGTypScore
 EQUB 0:EQUB 0:EQUB 0:EQUB 0
 EQUB 6:EQUB 4:EQUB 5:EQUB 10:EQUB 8:EQUB 10
 EQUB 12:EQUB 9:EQUB 20:EQUB 5:EQUB 20:EQUB 0
 EQUB 0:EQUB 0
 EQUB 150:EQUB 150:EQUB 200:EQUB 200
 
.KillObj
 LDY #0:JSR InitObj
 LDA #&81:STA ObjSt,X
 RTS
 
.InitMe
 LDX #0:LDA ShipInfo:AND #3:TAY:INY:JSR InitObj
 LDA #XExcess+36:STA ObjX+0
 LDA #&E8+3:STA ObjY+0
 LDX #0:LDY #0:JSR CalcSpInfo
 JMP SusRightRout
 
\ 'CalcSpInfo' calcs all the necessary data required by the sprite
\ routine for a given ID.
 
\ On entry X=0 or 8 for the two different 'banks' of sprite workspace
\          for source and destination images.
\          Y=ID of object being calculated.
 
\ On Exit  SpInf+0/+1,X = Screen address of bottom left of sprite
\          SpInf+2/+3,X = Address of graphics base
\          SpInf+4,X    = Width-1 of sprite in bytes (-ve if off sceeen)
\          SpInf+5,X    = Height of sprite
\          SpInf+6,X    = Start offset into graphic data
\          SpInf+7,X    = Clip 'skip' value (non-zero means clip)
 
\ If SpInf+4,X is -ve then all 'Exit' variables are INVALID! as the sprite
\ is totally off the screen. True also if SpInf+5,X (height) = 0.
 
 
.CalcSpInfo
 LDA ObjWid,Y:STA SpInf+4,X \ Default width (in bytes) to plot
 LDA ObjHei,Y:STA SpInf+5,X \ Height to plot
 LDA #0:STA SpInf+6,X       \ Default start index into graphics
 STA SpInf+7,X              \ Default clip flag (no clip)
 
 STY temp1 \ Save Y
 LDA ObjX,Y:LSR A:LDA #0
 BCC ClcSpI2
 LDA ObjNumFrm,Y:ADC #0 \ +1 to fudge for correct frame number, C=0 after
.ClcSpI2
 ADC ObjGra,Y:ADC ObjFrm,Y:TAY
 LDA TSpGraLo,Y:STA SpInf+2,X
 LDA TSpGraHi,Y:STA SpInf+3,X
 LDY temp1 \ Restore Y
 
\ Do some Y clipping with the TOP only!
 
 LDA ObjY,Y:SEC:SBC #WindMinY-1
 BCC ClcSpI4 \ Off top of window
 BEQ ClcSpI4 \ ditto
 
 CMP ObjHei,Y:BCS ClcSpI5 \ No Y clip
 BCC ClcSpI6 \ Always
 
.ClcSpI4
 LDA #0
.ClcSpI6
 STA SpInf+5,X \ New height to plot
 
\ Do some X clipping
 
.ClcSpI5
 LDA ObjX,Y:CMP #WindMaxX:BCS ClcSpI1 \ Totally off to right
 SEC:SBC #XExcess:BCC ClcSpI0 \ To left of screen
 LSR A:STA temp2+1  \ Byte offset 0,1,2...39 of sprite
 
\ Test for Possible right edge clip
 
 CLC:ADC ObjWid,Y
 SEC:SBC #40:BCC ClcSpI3 \ If no clip at all
 
 STA SpInf+6,X:STA SpInf+7,X \ New gra offset & 'skip' value
 LDA ObjWid,Y:SEC:SBC SpInf+7,X:STA SpInf+4,X \ new width to plot
 JMP ClcSpI3
 
\ Possible left edge clip
 
.ClcSpI0
 LDA #WindMinX-1:SEC:SBC ObjX,Y
 LSR A:CLC:ADC #1
 CMP ObjWid,Y:BCS ClcSpI1 \ Totally off to left
 
 STA SpInf+7,X \ clip 'skip' value
 LDA ObjWid,Y:SEC:SBC SpInf+7,X:STA SpInf+4,X \ new width to plot
 
 STX temp2+1
 LDX #0:LDA ObjY,Y:TAY:JSR xycalc
 LDY temp2+1:STA SpInf+1,Y:TXA:STA SpInf,Y
 RTS
 
.ClcSpI3
 STX temp2+1
 LDA ObjX,Y:SEC:SBC #XExcess:TAX:LDA ObjY,Y:TAY:JSR xycalc
 LDY temp2+1:STA SpInf+1,Y:TXA:STA SpInf,Y
 RTS
 
.ClcSpI1
 LDA #&FF:STA SpInf+4,X     \ All sprite is off screen
 RTS
 
\\ ]

\\ PRINT"Object 1   from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
