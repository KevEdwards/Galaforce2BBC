\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.SceLGam"
\\ MODE7:HIMEM=&6000

HIMEM=&6000
oscli=&FFF7
 
loadaddr=&700		\ REM Where this loader loads and executes at
mainexec=&5800		\ REM Execution address of main program just loaded
size=&58-&E+8		\ REM Size of main file (in pages) to be downloaded
 
\\ FORpass=4TO6STEP2
\\ P%=loadaddr:O%=HIMEM
\\ [OPT pass
 
ORG loadaddr
 
.start
 LDX #loadmod MOD 256
 LDY #loadmod DIV 256
 JSR oscli
 LDX #loadobj MOD 256
 LDY #loadobj DIV 256
 JSR oscli
 
 LDA #&8C:LDX #&C:JSR &FFF4	\ *TAPE
 
 SEI
 LDX #&F:LDA #0
.killroms
 STA &2A1,X
 DEX:BPL killroms
 CLI
 
 LDX #size
 LDY #0
.download
 LDA &1900,Y:STA &E00,Y
 INY:BNE download
 INC download+2:INC download+5
 DEX:BNE download
 
 JMP mainexec
 
.loadmod
 EQUS "LOAD Mod 900", &D
 
.loadobj
 EQUS "LOAD Obj 1900", &D
 
\\ ]NEXT
\\ PRINT'" *SAVE LoadGam "+STR$~(HIMEM)+" "+STR$~(O%)+" "+STR$~(start)+" "+STR$~(loadaddr)

