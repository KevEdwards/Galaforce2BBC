\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.SpGra"
\\ B%=P%
\\ [OPT pass


MACRO MkGraVecLo start, size, num
    FOR l, num-1, 0, -1
        EQUB LO(start+l*size)
    NEXT
    FOR l, num-1, 0, -1
        EQUB LO(start+(l+num)*size)
    NEXT
ENDMACRO

MACRO MkGraVecHi start, size, num
    FOR l, num-1, 0, -1
        EQUB HI(start+l*size)
    NEXT
    FOR l, num-1, 0, -1
        EQUB HI(start+(l+num)*size)
    NEXT
ENDMACRO

.TSpGraLo
\\ OPT FNMkGraVecLo(Expl,4*16,6)    \ 0 to 11 Explosion
 
\\ OPT FNMkGraVecLo(MyShip,4*16,1)  \ 12 to 17 My ship(s)
\\ OPT FNMkGraVecLo(0,4*16,1)
\\ OPT FNMkGraVecLo(0,4*16,1)
 
\\ OPT FNMkGraVecLo(Aliens,4*16,1)  \ 18 to 19 Jelly mon
\\ OPT FNMkGraVecLo(0,4*16,1)       \ 20 to 21
\\ OPT FNMkGraVecLo(0,4*16,1)       \ 22 to 23
\\ OPT FNMkGraVecLo(0,4*16,1)       \ 24 to 25
\\ OPT FNMkGraVecLo(0,4*16,1)       \ 26 to 27
\\ OPT FNMkGraVecLo(0,4*16,1)       \ 28 to 29
\\ OPT FNMkGraVecLo(0,4*16,1)       \ 30 to 31
\\ OPT FNMkGraVecLo(0,4*16,1)       \ 32 to 33
\\ OPT FNMkGraVecLo(0,4*16,1)       \ 34 to 35
\\ OPT FNMkGraVecLo(0,4*16,1)       \ 36 to 37
\\ OPT FNMkGraVecLo(0,4*16,2)       \ 38 to 41 Feature object
\\ OPT FNMkGraVecLo(0,4*7,1)        \ 42 to 43 1000pts
\\ OPT FNMkGraVecLo(0,3*8,1)        \ 44 to 45 Xtra Life
\\ OPT FNMkGraVecLo(0,2*8,2)        \ 46 to 49 Flash bomb
 
\\ OPT FNMkGraVecLo(BigAl,4*32,1)  \ 50 to 51 Big Alien 1 Part 1
\\ OPT FNMkGraVecLo(0,4*32,1)      \ 52 to 53 Big Alien 1 Part 2
\\ OPT FNMkGraVecLo(0,4*32,1)      \ 54 to 55 Big Alien 2 Part 1
\\ OPT FNMkGraVecLo(0,4*32,1)      \ 56 to 57 Big Alien 2 Part 2

 MkGraVecLo Expl, 4*16, 6      				; 0 to 11 Explosion

 MkGraVecLo MyShip,			4*16, 1   		; 12 to 17 My ship(s)
 MkGraVecLo MyShip +2*4*16,	4*16, 1
 MkGraVecLo MyShip +4*4*16,	4*16, 1

 MkGraVecLo Aliens, 		4*16, 1			; 18 to 19 Jelly mon
 MkGraVecLo Aliens +2*4*16, 4*16, 1			; 20 to 21
 MkGraVecLo Aliens +4*4*16, 4*16, 1			; 22 to 23
 MkGraVecLo Aliens +6*4*16, 4*16, 1			; 24 to 25
 MkGraVecLo Aliens +8*4*16, 4*16, 1			; 26 to 27
 MkGraVecLo Aliens +10*4*16, 4*16, 1		; 28 to 29
 MkGraVecLo Aliens +12*4*16, 4*16, 1		; 30 to 31
 MkGraVecLo Aliens +14*4*16, 4*16, 1		; 32 to 33
 MkGraVecLo Aliens +16*4*16, 4*16, 1		; 34 to 35
 MkGraVecLo Aliens +18*4*16, 4*16, 1		; 36 to 37
 MkGraVecLo Aliens +20*4*16, 4*16, 2		; 38 to 41 Feature object
 MkGraVecLo Aliens +24*4*16, 4*7, 1						; 42 to 43 1000pts
 MkGraVecLo Aliens +24*4*16 +2*4*7, 3*8, 1				; 44 to 45 Xtra Life
 MkGraVecLo Aliens +24*4*16 +2*4*7 +2*3*8, 2*8, 2		; 46 to 49 Flash bomb

 MkGraVecLo BigAl,			4*32, 1  		; 50 to 51 Big Alien 1 Part 1
 MkGraVecLo BigAl +2*4*32,	4*32, 1  		; 52 to 53 Big Alien 1 Part 2
 MkGraVecLo BigAl +4*4*32,	4*32, 1  		; 54 to 55 Big Alien 2 Part 1
 MkGraVecLo BigAl +6*4*32,	4*32, 1  		; 56 to 57 Big Alien 2 Part 2

 
.TSpGraHi
\\ OPT FNMkGraVecHi(Expl,4*16,6)
 
\\ OPT FNMkGraVecHi(MyShip,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
 
\\ OPT FNMkGraVecHi(Aliens,4*16,1)  \ Jelly mon
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,1)
\\ OPT FNMkGraVecHi(0,4*16,2)       \ Feature object
\\ OPT FNMkGraVecHi(0,4*7,1)
\\ OPT FNMkGraVecHi(0,3*8,1)
\\ OPT FNMkGraVecHi(0,2*8,2)        \ Flash bomb
 
\\ OPT FNMkGraVecHi(BigAl,4*32,1)  \ Big Alien 1 Part 1
\\ OPT FNMkGraVecHi(0,4*32,1)      \ Big Alien 1 Part 2
\\ OPT FNMkGraVecHi(0,4*32,1)      \ Big Alien 2 Part 1
\\ OPT FNMkGraVecHi(0,4*32,1)      \ Big Alien 2 Part 2

 MkGraVecHi Expl, 4*16, 6      				; 0 to 11 Explosion

 MkGraVecHi MyShip,			4*16, 1   		; 12 to 17 My ship(s)
 MkGraVecHi MyShip +2*4*16,	4*16, 1
 MkGraVecHi MyShip +4*4*16,	4*16, 1

 MkGraVecHi Aliens, 		4*16, 1			; 18 to 19 Jelly mon
 MkGraVecHi Aliens +2*4*16, 4*16, 1			; 20 to 21
 MkGraVecHi Aliens +4*4*16, 4*16, 1			; 22 to 23
 MkGraVecHi Aliens +6*4*16, 4*16, 1			; 24 to 25
 MkGraVecHi Aliens +8*4*16, 4*16, 1			; 26 to 27
 MkGraVecHi Aliens +10*4*16, 4*16, 1		; 28 to 29
 MkGraVecHi Aliens +12*4*16, 4*16, 1		; 30 to 31
 MkGraVecHi Aliens +14*4*16, 4*16, 1		; 32 to 33
 MkGraVecHi Aliens +16*4*16, 4*16, 1		; 34 to 35
 MkGraVecHi Aliens +18*4*16, 4*16, 1		; 36 to 37
 MkGraVecHi Aliens +20*4*16, 4*16, 2		; 38 to 41 Feature object
 MkGraVecHi Aliens +24*4*16, 4*7, 1						; 42 to 43 1000pts
 MkGraVecHi Aliens +24*4*16 +2*4*7, 3*8, 1				; 44 to 45 Xtra Life
 MkGraVecHi Aliens +24*4*16 +2*4*7 +2*3*8, 2*8, 2		; 46 to 49 Flash bomb

 MkGraVecHi BigAl,			4*32, 1  		; 50 to 51 Big Alien 1 Part 1
 MkGraVecHi BigAl +2*4*32,	4*32, 1  		; 52 to 53 Big Alien 1 Part 2
 MkGraVecHi BigAl +4*4*32,	4*32, 1  		; 54 to 55 Big Alien 2 Part 1
 MkGraVecHi BigAl +6*4*32,	4*32, 1  		; 56 to 57 Big Alien 2 Part 2



\ This table converts 'Graphic Type' values into 'ObjGra' offsets for
\ the base graphic of their frames
 
.TGTypConv
 EQUB 0:EQUB 12:EQUB 14:EQUB 16
 EQUB 18:EQUB 20:EQUB 22:EQUB 24:EQUB 26
 EQUB 28:EQUB 30:EQUB 32:EQUB 34:EQUB 36
 EQUB 38:EQUB 42:EQUB 44:EQUB 46:EQUB 50
 EQUB 52:EQUB 54:EQUB 56
 
\ -------------------------------------
 
.Expl
\\ OPT FNLoadDat0("Section.ObExpl",&300)
INCBIN "object\Section\ObExpl.o"
 
.MyShip
\\ OPT FNLoadDat0("Section.ObMyShip",&180)
INCBIN "object\Section\ObMyShip.o"
 
.Aliens
\\ OPT FNLoadDat0("Section.ObAliens",&6A8)
INCBIN "object\Section\ObAliens.o"
 
.BigAl
\\ OPT FNLoadDat0("Section.ObBigAl",&400)
INCBIN "object\Section\ObBigAl.o"

\\ ]

\\ PRINT"Sp Graphic from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
 
\\ DEFFNLoadDat0(file$,size%)
\\ IFpass>=6 OSCLI"LOAD "+file$+" "+STR$~(O%)
\\ O%=O%+size%:P%=P%+size%
\\ =pass
 
\\ DEFFNMkGraVecLo(Strt%,Size%,Num%)
\\ IFStrt%<>0 N%=Strt%
\\ FORL%=Num%-1TO0STEP-1
\\ [OPT pass
\\ EQUB (N%+L%*Size%) MOD 256
\\ ]NEXT
\\ M%=Num%*Size%
\\ FORL%=Num%-1TO0STEP-1
\\ [OPT pass
\\  EQUB (N%+M%+L%*Size%) MOD 256
\\ ]NEXT
\\ N%=N%+2*M%
\\ =pass
 
\\ DEFFNMkGraVecHi(Strt%,Size%,Num%)
\\ IFStrt%<>0 N%=Strt%
\\ FORL%=Num%-1TO0STEP-1
\\ [OPT pass
\\  EQUB (N%+L%*Size%) DIV 256
\\ ]NEXT
\\ M%=Num%*Size%
\\ FORL%=Num%-1TO0STEP-1
\\ [OPT pass
\\  EQUB (N%+M%+L%*Size%) DIV 256
\\ ]NEXT
\\ N%=N%+2*M%
\\ =pass
