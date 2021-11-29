\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Sprites2"
\\ B%=P%
\\ [OPT pass
 
\ Entry SpInf+0,SpInf+1 = low,high of source screen address
\       SpInf+2,SpInf+3 = low,high of source graphic
\       SpInf+4         = Width minus 1 of sprite(s)
\       SpInf+5         = Height of sprite(s) being plotted
\       SpInf+6         = Start graphic offset value
\       SpInf+7         = Clip 'skip' value
 
\       SpInf2+0,SpInf2+1 = low,high of desti. screen address *
\       SpInf2+2,SpInf2+3 = low,high of desti. graphic        *
 
 
\    * indicates that the variable is not required if only plotting a
\      single sprite.
 
\ Exit  A,X,Y corrupted
 
\ ----------------------------------------
 
\ 'ClipSprite' plots a clipped sprite
 
.ClipSprite
 LDA SpInf+7:STA ClpCAdd+1
 LDA SpInf+2:STA ClpGra1+1:STA ClpGra2+1:STA ClpGra3+1:STA ClpGra4+1
 LDA SpInf+3:STA ClpGra1+2:STA ClpGra2+2:STA ClpGra3+2:STA ClpGra4+2
 
 LDY SpInf+4:LDA ClpBraTab,Y:STA ClpBra+1:LDX SpInf+6
 
 CPY #2:BEQ ClpSp3
 CPY #1:BEQ ClpSp2
 TYA:BEQ ClpSp1
 
.ClpSp4
 LDY #&18
.ClpGra4
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y:INX
 
.ClpSp3
 LDY #&10
.ClpGra3
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y:INX
 
.ClpSp2
 LDY #8
.ClpGra2
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y:INX
 
.ClpSp1
 LDY #0
.ClpGra1
 LDA &FFFF,X:EOR (SpInf),Y:STA (SpInf),Y:INX
 
 TXA
 CLC
.ClpCAdd
 ADC #&FF \ Self modified
 TAX
 
 LDA SpInf:AND #7:BEQ Clip0
 DEC SpInf
.Clip1
 DEC SpInf+5
.ClpBra
 BNE ClpSp1  \ Self modified
 RTS
 
.Clip0
 LDA SpInf:SEC:SBC #&39:STA SpInf:LDA SpInf+1:SBC #1:STA SpInf+1:JMP Clip1
 
.ClpBraTab
 EQUB ClpSp1-ClpBra-2
 EQUB ClpSp2-ClpBra-2
 EQUB ClpSp3-ClpBra-2
 EQUB ClpSp4-ClpBra-2
 
\\ ]
 
\\ PRINT"Sprites 2  from ",~B%," to ",~P%-1," (",P%-B%,")"

\\ PAGE=PG%
\\ RETURN
