\\
\\ Galaforce 2 ( BBC Micro ) from the original 6502 source code, adapted to assemble using beebasm
\\
\\ (c) Kevin Edwards 1987-2021
\\
\\ Twitter @KevEdwardsRetro
\\

\\ REM SAVE"$.Galaforce2.MainB"
\\ B%=P%
\\ [OPT pass
 
.PlayGame
 JSR TryStars
 LDX #2:LDY #4:JSR vdu19 \ colour 2 to blue
 JSR ShowLives:JSR ShowFlags \ Remove 'last game' flags/lives left!
 
 JSR HardReset      \ Init player 1/2 variables, 0 scores etc.
 LDA #0:STA Player  \ Make player 1 the first to start
 JSR ReadPlyr
 JSR TryStars
 
.NextLife
 JSR TryStars
 JSR ClrArrows \ Erase both arrows
 JSR PutArrow  \ Show next player's arrow
 JSR ShowLives:JSR ShowFlags \ Show next player's lives/level
 JSR reset
 JSR InitLev
 JSR TryStars
 JSR InitMe
 
 LDA Player:CLC:ADC #'1'-32:STA TxPlyr
 LDA level:JSR HunTenUn
 ORA #'0'-32:STA TxGalax+2
 TYA:ORA #'0'-32:STA TxGalax+1
 TXA:ORA #'0'-32:STA TxGalax+0
 
 LDY #2:JSR pstring
 SEC:ROR NoFx \ Disable FXs so tune can be played!
 LDY #10:JSR PlayTune
 LDY #3:JSR frame_delay
 LDA #220:JSR MoveMeDelay \ 220 frame delay or spc and allow me move/fire
 LDY #2:JSR pstring
 CLC:ROR NoFx \ Enable FXs, tune is over!
 
\ ------------------------------------------------------------
 
.main_loop
 BIT Escape:BMI Main2 \ Don't check Esc if already handling Escape
 LDA ObjSt+0:BPL Main2 \ Or if dead/exploding
 LSR A:BCS Main2
 
 BIT Demo:BPL Main4    \ If not demo mode
 JSR testspc:BEQ Main5 \ space bar has same effect as Escape in demo mode
 
.Main4
 LDX #&8F:JSR check_key:BNE Main2 \ If Escape not pressed
.Main5
 LDA #&80:STA Escape \ We are now in the 'Escape' phase
 JSR ExplNoB
 JSR DestrAll \ Tell processing code to explode ALL objects
 
.Main2
 LDA counter:AND #&F:BNE Main6
 JSR EorArrow \ Flash arrow on/off
 
.Main6
 CLI
 INC counter
 JSR TryStars:JSR TryMe
 JSR BullAlienCol
 JSR MeAlienCol
 JSR TryStars:JSR TryMe
 JSR MeAlBmbCol
 JSR DoSmart
 JSR ProcessAliens
 JSR InitInit
 JSR ProcessMyBombs
 JSR TryStars:JSR TryMe
 JSR ProcessAlBombs
 JSR OpKeys
 
 LDA ObjSt+0:BMI main_loop \ If my ID hasn't been killed off
 LDA ActAliens:ORA ActBullets:ORA ActAlBombs:BNE main_loop
 
 BIT Demo:BMI Main0
 LDA level:CMP HighestLev:BCC Main0 \ Not >= to highest level reached
.Main1
 STA HighestLev
 
.Main0
 BIT Escape:BPL Main3 \ If 'Escape' wasn't the cause of my death
 RTS
 
.Main3
 DEC DieDelay:BEQ HasDied
 JMP main_loop
 
\ ------------------------------------------------------------
 
.HasDied
 JSR PutArrow \ Show player's arrow
 JSR ShowLives \ Erase current player's lives
 DEC lives
 JSR ShwLiv   \ Show lives as digit
 JSR SavePlyr \ Save player's info in their private w/space
 LDA lives:BNE HasDi2
 JSR pgamovr
 LDY #22:JSR PlayTune
 LDY #250:JSR frame_delay:LDY #50:JSR frame_delay
 JSR pgamovr
 JSR hig \ See if score is a new high
 JMP SkpTun
 
.HasDi2
 LDY #16:JSR PlayTune
 LDY #100:JSR frame_delay
.SkpTun
 JSR ShowFlags \ Erase current player's level
 BIT FnumPlyr:BPL HasDi0
 
\ Process if 2 players
 
 LDA P1lives:ORA P2lives:BEQ HasDi1 \ Both players are now dead
 LDA Player:EOR #1:STA Player
 JSR ReadPlyr                 \ Get other player's info
 LDA lives:BNE HasDi3         \ Let him play if he's still got lives left
 LDA Player:EOR #1:STA Player \ Otherwise re-select last player again
 JSR ReadPlyr
.HasDi3
 JMP NextLife
 
\ Process if 1 player
 
.HasDi0
 LDA lives:BEQ HasDi1
 JMP NextLife
 
.HasDi1
 JSR ShowLives:JSR ShowFlags \ Re-show lives/level flags for last player
 RTS \ Back to 'Main' routine
 
\\ ]

\\ PRINT"Main loopB from &";~B%;" to &";~P%-1;" (";P%-B%;")"
\\ PAGE=PG%
\\ RETURN
