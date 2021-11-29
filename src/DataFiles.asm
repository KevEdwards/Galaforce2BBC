\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.DataFiles"
\\ B%=P%
\\ [OPT pass
 
.CharSet
 \\ OPT FNLoadFil2("Section.CHARDAT",&127)
INCBIN "object\Section\CHARDAT.o"

.SpCharSet
 \\ OPT FNLoadFil2("Section.SpFont",&CD)
 INCBIN "object\Section\SpFont.o"

.ArrowGra
 \\ OPT FNLoadFil2("Section.ObArrow",&20)
 INCBIN "object\Section\ObArrow.o"

\\ ]

\\ PRINT"Data Files from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%:RETURN
 
\\ DEFFNLoadFil2(fsp$,size%)
\\ IF pass>=6 OSCLI"LOAD "+fsp$+" "+STR$~(O%)
\\ O%=O%+size%:P%=P%+size%
\\ =pass
