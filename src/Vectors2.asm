\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Vectors2"
\\ B%=P%
\\ [OPT pass
 
.TPatDatLo
 EQUB PtD0 MOD &100
 EQUB PtD1 MOD &100
 EQUB PtD2 MOD &100
 EQUB PtD3 MOD &100
 EQUB PtD4 MOD &100
 EQUB PtD5 MOD &100
 EQUB PtD6 MOD &100
 EQUB PtD7 MOD &100
 EQUB PtD8 MOD &100
 EQUB PtD9 MOD &100
 EQUB PtD10 MOD &100
 EQUB PtD11 MOD &100
 EQUB PtD12 MOD &100
 EQUB PtD13 MOD &100
 EQUB PtD14 MOD &100
 EQUB PtD15 MOD &100
 EQUB PtD16 MOD &100
 EQUB PtD17 MOD &100
 EQUB PtD18 MOD &100
 EQUB PtD19 MOD &100
 EQUB PtD20 MOD &100
 EQUB PtD21 MOD &100
 EQUB PtD22 MOD &100
 EQUB PtD23 MOD &100
 EQUB PtD24 MOD &100
 EQUB PtD25 MOD &100
 EQUB PtD26 MOD &100
 EQUB PtD27 MOD &100
 EQUB PtD28 MOD &100
 EQUB PtD29 MOD &100
 EQUB PtD30 MOD &100
 EQUB PtD31 MOD &100
 EQUB PtD32 MOD &100
 EQUB PtD33 MOD &100
 EQUB PtD34 MOD &100
 EQUB PtD35 MOD &100
 EQUB PtD36 MOD &100
 EQUB PtD37 MOD &100
 EQUB PtD38 MOD &100
 EQUB PtD39 MOD &100
 EQUB PtD40 MOD &100
 EQUB PtD41 MOD &100
 EQUB PtD42 MOD &100
 EQUB PtD43 MOD &100
 EQUB PtD44 MOD &100
 EQUB PtD45 MOD &100
 EQUB PtD46 MOD &100
 EQUB PtD47 MOD &100
 EQUB PtD48 MOD &100
 EQUB PtD49 MOD &100
 EQUB PtD50 MOD &100
 EQUB PtD51 MOD &100
 EQUB PtD52 MOD &100
 EQUB PtD53 MOD &100
 EQUB PtD54 MOD &100
 EQUB PtD55 MOD &100
 EQUB PtD56 MOD &100
 EQUB PtD57 MOD &100
 EQUB PtD58 MOD &100
 EQUB PtD59 MOD &100
 EQUB PtD60 MOD &100
 
.TPatDatHi
 EQUB PtD0 DIV &100
 EQUB PtD1 DIV &100
 EQUB PtD2 DIV &100
 EQUB PtD3 DIV &100
 EQUB PtD4 DIV &100
 EQUB PtD5 DIV &100
 EQUB PtD6 DIV &100
 EQUB PtD7 DIV &100
 EQUB PtD8 DIV &100
 EQUB PtD9 DIV &100
 EQUB PtD10 DIV &100
 EQUB PtD11 DIV &100
 EQUB PtD12 DIV &100
 EQUB PtD13 DIV &100
 EQUB PtD14 DIV &100
 EQUB PtD15 DIV &100
 EQUB PtD16 DIV &100
 EQUB PtD17 DIV &100
 EQUB PtD18 DIV &100
 EQUB PtD19 DIV &100
 EQUB PtD20 DIV &100
 EQUB PtD21 DIV &100
 EQUB PtD22 DIV &100
 EQUB PtD23 DIV &100
 EQUB PtD24 DIV &100
 EQUB PtD25 DIV &100
 EQUB PtD26 DIV &100
 EQUB PtD27 DIV &100
 EQUB PtD28 DIV &100
 EQUB PtD29 DIV &100
 EQUB PtD30 DIV &100
 EQUB PtD31 DIV &100
 EQUB PtD32 DIV &100
 EQUB PtD33 DIV &100
 EQUB PtD34 DIV &100
 EQUB PtD35 DIV &100
 EQUB PtD36 DIV &100
 EQUB PtD37 DIV &100
 EQUB PtD38 DIV &100
 EQUB PtD39 DIV &100
 EQUB PtD40 DIV &100
 EQUB PtD41 DIV &100
 EQUB PtD42 DIV &100
 EQUB PtD43 DIV &100
 EQUB PtD44 DIV &100
 EQUB PtD45 DIV &100
 EQUB PtD46 DIV &100
 EQUB PtD47 DIV &100
 EQUB PtD48 DIV &100
 EQUB PtD49 DIV &100
 EQUB PtD50 DIV &100
 EQUB PtD51 DIV &100
 EQUB PtD52 DIV &100
 EQUB PtD53 DIV &100
 EQUB PtD54 DIV &100
 EQUB PtD55 DIV &100
 EQUB PtD56 DIV &100
 EQUB PtD57 DIV &100
 EQUB PtD58 DIV &100
 EQUB PtD59 DIV &100
 EQUB PtD60 DIV &100
 
\\ ]

\\ PRINT"Vectors 2  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
