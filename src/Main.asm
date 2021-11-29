\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.Main"
\\ B%=P%
\\ [OPT pass
 
  EQUS "Galaforce 2 ver 1.0000 "
\\  EQUS TIME$  \ Date/time stamp the object code
  EQUS " Fri,03 Jul 1998.12:48:01"
  EQUS " (c) Kevin Edwards"
 
\ ------------------------------------------------------------
 
\\ Re-map EQUS strings for the rest of the source, DO NOT re-map the EQUS strings above!
MAPCHAR ' ','Z', 0

.start
 LDA #26:JSR oswrch \ Restore default windows
 LDA #12:JSR oswrch \ CLS
 JSR InitStars
 SEI
 LDA #Event MOD &100:STA &220
 LDA #Event DIV &100:STA &221
 CLI
 JSR INITSOUND
 LDA #14:LDX #4:JSR osbyte \ Enable 'vsync' event
 CLC:ROR Demo   \ Flag that we're not in demo mode
 CLC:ROR NoFx
 JSR HardReset  \ Show 0 for both scores,lives=4,level=1 etc
 JSR ShowLives:JSR ShowFlags \ Show 'reset' lives/flags
 LDY #0:JSR PlotOptB \ Show P
 LDY #1:JSR PlotOptB \ Show S
 LDY #2:JSR PlotOptB \ Show K
 LDY #3:JSR PlotOptB \ Show 1
 
\ ------------------------------------------------------------
 
.Header
 LDY #4:JSR PlayTune
.Heade0
 LDA #20:JSR oswrch      \ Reset palette
 LDX #2:LDY #5:JSR vdu19 \ colour 2 to magenta
 
 JSR DispHead:JSR WtLoop:JSR DispHead \ Main header page
 BIT RetPress:BMI IntoOpt     \ Into options if Return pressed
 BIT TimeOut:BPL NewGame
 LDX #2:LDY #2:JSR vdu19              \ colour 2 to green
 LDY #14:JSR pstring                  \ Today's best fighters
 JSR phi:JSR WtLoop:JSR phi           \ High score table
 LDY #14:JSR pstring
 BIT RetPress:BMI IntoOpt     \ Into options if Return pressed
 BIT TimeOut:BPL NewGame
 
.IntoDemo
 LDX #&80:BMI NeGam0 \ Always, force demo mode
.NewGame
 LDX #0 \ Select non-demo mode
.NeGam0
 STX Demo
 JSR PlayGame
 JMP Header
 
.IntoOpt
 JSR Options \ Cheat option/skip level etc..
 JMP Heade0
 
\ ------------------------------------------------------------
 
.WtLoop
 CLC:ROR TimeOut \ Clear time out flag
 CLC:ROR RetPress \ Clear 'Return pressed' flag
 LDA #250:STA LoopA \ Delay in frames before time out
.WtLo0
 DEC LoopA:BEQ WtLo2 \ Time-out has occured
 JSR testspc:BEQ WtLo3 \ If space pressed, use selected num of players
 LDX #&B6:JSR check_key:BEQ WtLo1
 JSR fx19
 JSR TryStars
 JSR Extras
 LDX #3:JSR OpKeysB \ Check P S K and CTRL!
 JMP WtLo0
 
.WtLo2
 SEC:ROR TimeOut \ Timed out, space wasn't pressed
 RTS
 
.WtLo3
 JSR TryStars
 JSR testspc:BEQ WtLo3 \ Wait until space released!
 RTS
 
.WtLo1
 SEC:ROR RetPress \ Flag 'Return' pressed
 RTS
 
\\ ]

\\ PRINT"Main loop  from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
