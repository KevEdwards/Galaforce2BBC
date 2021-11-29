\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Vectors1"
\\ B%=P%
\\ [OPT pass
 
.TSecLo
 EQUB Sect0 MOD &100
 EQUB Sect1 MOD &100
 EQUB Sect2 MOD &100
 EQUB Sect3 MOD &100
 EQUB Sect4 MOD &100
 EQUB Sect5 MOD &100
 EQUB Sect6 MOD &100
 EQUB Sect7 MOD &100
 EQUB Sect8 MOD &100
 EQUB Sect9 MOD &100
 EQUB Sect10 MOD &100
 EQUB Sect11 MOD &100
 EQUB Sect12 MOD &100
 EQUB Sect13 MOD &100
 EQUB Sect14 MOD &100
 EQUB Sect15 MOD &100
 
.TSecHi
 EQUB Sect0 DIV &100
 EQUB Sect1 DIV &100
 EQUB Sect2 DIV &100
 EQUB Sect3 DIV &100
 EQUB Sect4 DIV &100
 EQUB Sect5 DIV &100
 EQUB Sect6 DIV &100
 EQUB Sect7 DIV &100
 EQUB Sect8 DIV &100
 EQUB Sect9 DIV &100
 EQUB Sect10 DIV &100
 EQUB Sect11 DIV &100
 EQUB Sect12 DIV &100
 EQUB Sect13 DIV &100
 EQUB Sect14 DIV &100
 EQUB Sect15 DIV &100
 
.TPatInLo
 EQUB PtI0 MOD &100
 EQUB PtI1 MOD &100
 EQUB PtI2 MOD &100
 EQUB PtI3 MOD &100
 EQUB PtI4 MOD &100
 EQUB PtI5 MOD &100
 EQUB PtI6 MOD &100
 EQUB PtI7 MOD &100
 EQUB PtI8 MOD &100
 EQUB PtI9 MOD &100
 EQUB PtI10 MOD &100
 EQUB PtI11 MOD &100
 EQUB PtI12 MOD &100
 EQUB PtI13 MOD &100
 EQUB PtI14 MOD &100
 EQUB PtI15 MOD &100
 EQUB PtI16 MOD &100
 EQUB PtI17 MOD &100
 EQUB PtI18 MOD &100
 EQUB PtI19 MOD &100
 EQUB PtI20 MOD &100
 EQUB PtI21 MOD &100
 EQUB PtI22 MOD &100
 EQUB PtI23 MOD &100
 EQUB PtI24 MOD &100
 EQUB PtI25 MOD &100
 EQUB PtI26 MOD &100
 EQUB PtI27 MOD &100
 EQUB PtI28 MOD &100
 EQUB PtI29 MOD &100
 EQUB PtI30 MOD &100
 EQUB PtI31 MOD &100
 EQUB PtI32 MOD &100
 EQUB PtI33 MOD &100
 EQUB PtI34 MOD &100
 EQUB PtI35 MOD &100
 EQUB PtI36 MOD &100
 EQUB PtI37 MOD &100
 EQUB PtI38 MOD &100
 EQUB PtI39 MOD &100
 EQUB PtI40 MOD &100
 EQUB PtI41 MOD &100
 EQUB PtI42 MOD &100
 EQUB PtI43 MOD &100
 EQUB PtI44 MOD &100
 EQUB PtI45 MOD &100
 EQUB PtI46 MOD &100
 EQUB PtI47 MOD &100
 EQUB PtI48 MOD &100
 EQUB PtI49 MOD &100
 EQUB PtI50 MOD &100
 EQUB PtI51 MOD &100
 
.TPatInHi
 EQUB PtI0 DIV &100
 EQUB PtI1 DIV &100
 EQUB PtI2 DIV &100
 EQUB PtI3 DIV &100
 EQUB PtI4 DIV &100
 EQUB PtI5 DIV &100
 EQUB PtI6 DIV &100
 EQUB PtI7 DIV &100
 EQUB PtI8 DIV &100
 EQUB PtI9 DIV &100
 EQUB PtI10 DIV &100
 EQUB PtI11 DIV &100
 EQUB PtI12 DIV &100
 EQUB PtI13 DIV &100
 EQUB PtI14 DIV &100
 EQUB PtI15 DIV &100
 EQUB PtI16 DIV &100
 EQUB PtI17 DIV &100
 EQUB PtI18 DIV &100
 EQUB PtI19 DIV &100
 EQUB PtI20 DIV &100
 EQUB PtI21 DIV &100
 EQUB PtI22 DIV &100
 EQUB PtI23 DIV &100
 EQUB PtI24 DIV &100
 EQUB PtI25 DIV &100
 EQUB PtI26 DIV &100
 EQUB PtI27 DIV &100
 EQUB PtI28 DIV &100
 EQUB PtI29 DIV &100
 EQUB PtI30 DIV &100
 EQUB PtI31 DIV &100
 EQUB PtI32 DIV &100
 EQUB PtI33 DIV &100
 EQUB PtI34 DIV &100
 EQUB PtI35 DIV &100
 EQUB PtI36 DIV &100
 EQUB PtI37 DIV &100
 EQUB PtI38 DIV &100
 EQUB PtI39 DIV &100
 EQUB PtI40 DIV &100
 EQUB PtI41 DIV &100
 EQUB PtI42 DIV &100
 EQUB PtI43 DIV &100
 EQUB PtI44 DIV &100
 EQUB PtI45 DIV &100
 EQUB PtI46 DIV &100
 EQUB PtI47 DIV &100
 EQUB PtI48 DIV &100
 EQUB PtI49 DIV &100
 EQUB PtI50 DIV &100
 EQUB PtI51 DIV &100
 
 
\\ ]

\\ PRINT"Vectors 1  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN