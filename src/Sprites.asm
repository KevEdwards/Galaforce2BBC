\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Sprites"
\\ B%=P%
\\ [OPT pass
 
\ Entry SpInf+0,SpInf+1 = low,high of source screen address
\       SpInf+2,SpInf+3 = low,high of source graphic
\       SpInf+4         = Width minus 1 of sprite(s)
\       SpInf+5         = Height of sprite(s) being plotted
\       SpInf+6         = Start graphic offset value
 
\       SpInf2+0,SpInf2+1 = low,high of desti. screen address *
\       SpInf2+2,SpInf2+3 = low,high of desti. graphic        *
 
 
\    * indicates that the variable is not required if only plotting a
\      single sprite.
 
\ Exit  A,X,Y corrupted
 
\ ----------------------------------------
 
\ 'NormSprite' erases and plots a non-clipped sprite
 
.NormSprite
 LDA SpInf+2:STA NorGra1+1:STA NorGra2+1:STA NorGra3+1:STA NorGra4+1
 LDA SpInf+3:STA NorGra1+2:STA NorGra2+2:STA NorGra3+2:STA NorGra4+2
 
 LDA SpInf2+2:STA NorGraD1+1:STA NorGraD2+1:STA NorGraD3+1:STA NorGraD4+1
 LDA SpInf2+3:STA NorGraD1+2:STA NorGraD2+2:STA NorGraD3+2:STA NorGraD4+2
 
 LDY SpInf+4:LDA NorBraTab,Y:STA NorBra+1:LDX SpInf+6
 
 CPY #2:BEQ NorSp3 \ Y=Sprite width minus 1
 CPY #1:BEQ NorSp2
 TYA:BEQ NorSp1
 
.NorSp4
 LDY #&18
.NorGra4
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y
.NorGraD4
 LDA &FFFF,X:EOR (SpInf2),Y:STA (SpInf2),Y:INX
 
.NorSp3
 LDY #&10
.NorGra3
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y
.NorGraD3
 LDA &FFFF,X:EOR (SpInf2),Y:STA (SpInf2),Y:INX
 
.NorSp2
 LDY #8
.NorGra2
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y
.NorGraD2
 LDA &FFFF,X:EOR (SpInf2),Y:STA (SpInf2),Y:INX
 
.NorSp1
 LDY #0
.NorGra1
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y
.NorGraD1
 LDA &FFFF,X:EOR (SpInf2),Y:STA (SpInf2),Y:INX
 
 LDA SpInf:AND #7:BEQ Norm0
 DEC SpInf
.Norm1
 LDA SpInf2:AND #7:BEQ Norm2
 DEC SpInf2
.Norm3
 DEC SpInf+5
.NorBra
 BNE NorSp1  \ Self modified
 RTS
 
.Norm0
 LDA SpInf:SEC:SBC #&39:STA SpInf:LDA SpInf+1:SBC #1:STA SpInf+1:JMP Norm1
 
.Norm2
 LDA SpInf2:SEC:SBC #&39:STA SpInf2:LDA SpInf2+1:SBC #1:STA SpInf2+1:JMP Norm3
 
.NorBraTab
 EQUB NorSp1-NorBra-2
 EQUB NorSp2-NorBra-2
 EQUB NorSp3-NorBra-2
 EQUB NorSp4-NorBra-2
 
\ ----------------------------------------
 
\ 'PutSprite' plots a single non-clipped sprite
 
.PutSprite
 LDA SpInf+2:STA PutGra1+1:STA PutGra2+1:STA PutGra3+1:STA PutGra4+1
 LDA SpInf+3:STA PutGra1+2:STA PutGra2+2:STA PutGra3+2:STA PutGra4+2
 
 LDY SpInf+4:LDA PutBraTab,Y:STA PutBra+1:LDX SpInf+6
 
 CPY #2:BEQ PutSp3 \ Y=Sprite width minus 1
 CPY #1:BEQ PutSp2
 TYA:BEQ PutSp1
 
.PutSp4
 LDY #&18
.PutGra4
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y:INX
 
.PutSp3
 LDY #&10
.PutGra3
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y:INX
 
.PutSp2
 LDY #8
.PutGra2
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y:INX
 
.PutSp1
 LDY #0
.PutGra1
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y:INX
 
 LDA SpInf:AND #7:BEQ Put0
 DEC SpInf
.Put1
 DEC SpInf+5
.PutBra
 BNE PutSp1  \ Self modified
 RTS
 
.Put0
 LDA SpInf:SEC:SBC #&39:STA SpInf:LDA SpInf+1:SBC #1:STA SpInf+1:JMP Put1
 
.PutBraTab
 EQUB PutSp1-PutBra-2
 EQUB PutSp2-PutBra-2
 EQUB PutSp3-PutBra-2
 EQUB PutSp4-PutBra-2
 
\\ ]
 
\\ PRINT"Sprites    from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
