\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Object3"
\\ B%=P%
\\ [OPT pass
 
.ProcessAliens
 LDA #process:STA LoopC
 LDX UptoID
 
.PrAli0
 STX CurrId:STX UptoID
 LDA ObjSt,X:BPL PrAli3
 
 JSR ObjectProcess \ Move/Animate object
 JMP PrAli1
 
.PrAli3
 JSR SpCompensate \ Delay loop = time to plot/unplot 1 sprite
 
.PrAli1
 JSR TryMe         \ See if vsync has occured, process me if true
 JSR TryStars      \ See if vsync has occured, process stars if so
 
 LDX UptoID
 LDA ObjSt,X:BPL PrAli4
 LDA ObjInfo,X:AND #2:BEQ PrAli7 \ If normal firepowered alien
 JSR rand:AND #7:BNE PrAli4
 BEQ PrAli5
 
.PrAli7
 LDA level:CMP #40:BCC PrAli6
 CMP #52:BCC PrAli8
 
 JSR rand:AND #&3F:BNE PrAli4 \ 1 in 64 chance (levels 52+)
 BEQ PrAli5
 
.PrAli8
 JSR rand:AND #&7F:BNE PrAli4 \ 1 in 128 chance (levels 40+)
 BEQ PrAli5
 
.PrAli6
 JSR rand:BNE PrAli4 \ 1 in 256 chance
.PrAli5
 JSR InitAlBomb \ Try to init bomb (must be alive ID and on screen etc)
 LDX UptoID \ Restore ID
 
.PrAli4
 INX:CPX MaxAlID:BCC PrAli2:BEQ PrAli2
 JSR ProcessInit    \ Vital to keep everything in sync!
 LDX #1
 INC AlCounter \ INC every time ALL the aliens are processed
 
.PrAli2
 DEC LoopC:BNE PrAli0
 STX UptoID
 RTS
 
\ Approx. delay for 'putting' a 4 by 16 byte sprite
 
.SpCompB
 LDY #16:BNE SpCom0
 
\ Approx. delay for 'erasing and re-plotting' a 4 by 16 byte sprite
 
.SpCompensate
 LDY #32
 
.SpCom0
 LDX #19
.SpCom1
 DEX:BNE SpCom1
 DEY:BNE SpCom0
 RTS
 
\\ ]

\\ PRINT"Object 3   from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
