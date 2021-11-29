\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.ObjPro"
\\ B%=P%
\\ [OPT pass
 
.TryMe
 LDA VSyncCn2:BEQ TryMe0
 
.TryMe1
 RTS
 
.TryMe0
 JSR controls
 LDA Feature:CMP #2:BNE TryMe2
 LDA VSyncMast:AND #3:BEQ TryMe2
 LDA #0:STA XIndex:STA YIndex
 
.TryMe2
 LDX #1:STX VSyncCn2
 DEX:STX CurrId
 LDA ObjSt+0:BPL TryMe1 \ Not if I don't exist
 
\ Drop through and process me (ID=0)
 
 
\ 'ObjectProcess' erases, processes and re-displays a given object
\ On Entry  CurrId = ID of object to be processed
 
\ If the object processing wishes to init another alien it must
\ set the object's info up and place the corresponding ID in the
\ variable 'NewAlID'. If non-zero after 'JSR ActObjPro' then a
\ 'put sprite' will be performed using that ID to display the object
 
.ObjectProcess
 LDA #0:STA NewAlID \ 0 to indicate that no new object is to be init
 JSR ActObjPro      \ The necessary erase/move/re-plot code
 LDY NewAlID:BEQ ObjPrEx \ If no new object is to be init
 
 LDX #0:JSR CalcSpInfo \ Calc info for 'put' routine
 JMP SusRightRout \ Actually 'put' the new object on the screen
 
.ObjPrEx
 RTS
 
\ This part actually erases, processes and re-displays an object
 
.ActObjPro
 LDY CurrId:LDX #0:JSR CalcSpInfo \ Calc source info
 
 LDX CurrId:JSR Animate       \ Animate graphic
 LDA ObjSt,X:BPL SusRightRout \ If alien ID has been killed (erase it)
 
 LDA ObjDestr,X:BPL ObPro1 \ If collision hasn't caused death!
 JSR KillObj \ Change object into exploding graphic
 JMP ObPro0
 
.ObPro1
 JSR MoveObject \ Move object according to pattern data
 LDA ObjSt,X:BPL SusRightRout \ If ID has been killed by pattern prog.
 
.ObPro0
 LDY CurrId:LDX #8:JSR CalcSpInfo \ Calc desti. info
 
 LDA SpInf+7:BNE SusPlot0   \ Do separate if source is 'clipped'
 LDA SpInf2+7:BNE SusPlot0  \ Do separate if dest. is 'clipped'
 LDA SpInf+4:BMI SusPlot1   \ Source width, take if off screen (if -ve)
 CMP SpInf2+4:BNE SusPlot0  \ Do separate if different widths
 
 LDA SpInf+5:BEQ SusPlot0  \ Do separate if source height=0
 LDA SpInf2+5:BEQ SusPlot0 \ Do separate if dest. height=0
 CMP SpInf+5:BNE SusPlot0  \ Do separate if different heights
 LDA SpInf+6:CMP SpInf2+6:BNE SusPlot0 \ Do separate if diff. gra index
 
 DEC SpInf+4    \ Width-1 for sprite tables
 JMP NormSprite \ Erase and plot sprite at same time
 
\ Source and destination are to be plotted separately
 
.SusPlot0
 JSR SusRightRout
 
.SusPlot1
 LDA SpInf2+0:STA SpInf+0 \ Copy 'dest' info into 'source' w/space
 LDA SpInf2+1:STA SpInf+1
 LDA SpInf2+2:STA SpInf+2
 LDA SpInf2+3:STA SpInf+3
 LDA SpInf2+4:STA SpInf+4
 LDA SpInf2+5:STA SpInf+5
 LDA SpInf2+6:STA SpInf+6
 LDA SpInf2+7:STA SpInf+7
 
.SusRightRout
 LDA SpInf+4:BMI SuRiR1 \ If sprite is off screen left/right (delay req'd)
 LDA SpInf+5:BEQ SuRiR1 \ If sprite height is 0 (off TOP of screen)
 DEC SpInf+4            \ Width-1 for sprite tables
 LDA SpInf+7:BNE SuRiR0 \ If clipped sprite
 JMP PutSprite
 
.SuRiR0
 JMP ClipSprite
 
.SuRiR1
 JMP SpCompB \ Delay equivalent to 'putting' a sprite 4*16 bytes
 
.Animate
 LDA ObjSt,X:BPL Anim0
 LDA ObjInfo,X:AND #8:BNE Anim0
 DEC ObjFrm,X:BPL Anim0
 LDA ObjSt,X:LSR A:BCC Anim1 \ If not dying
 LDA ObjGTyp,X:BNE Anim1     \ If not exploding graphic
 
.Anim2
 LDA #0:STA ObjSt,X \ Remove use of ID
 TXA:BEQ Anim0 \ If my ID
 DEC ActAliens
 RTS
 
.Anim1
 LDA ObjNumFrm,X:STA ObjFrm,X
.Anim0
 RTS
 
\\ ]

\\ PRINT"Obj.Proc.  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
