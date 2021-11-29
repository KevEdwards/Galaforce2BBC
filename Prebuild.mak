
\\ Galaforce 2 Prebuild process

	\\ Build LoadGam - this is the code responsible for loading the main game code
	INCLUDE "src\SceLGam.asm"

	\\ Save to final disk Image
	PRINT"Saving LoadGam", ~loadaddr, ~P%
	SAVE "LoadGam", loadaddr, P%

