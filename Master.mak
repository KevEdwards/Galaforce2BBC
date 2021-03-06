\\
\\ Galaforce 2
\\
\\ (C) Kevin Edwards 1988-2018
\\

objstrt%=&E00
objend%=&5800
modu%=&400
dowsize%=&B00
sceaddr%=&800+modu%+(objend%-objstrt%)+dowsize%

	INCLUDE "src\CONST.asm"
	INCLUDE "src\ZPWORK.asm"
	INCLUDE "src\ABSWORK.asm"
 
	\\ Module Code block ( &900 - &CFF )
	ORG &900	
	INCLUDE "src\Module.asm"

	\\ Main Code block - source files assembled in the same order as the original
	ORG objstrt%
	INCLUDE "src\Sprites.asm"
	INCLUDE "src\Sprites2.asm"
	INCLUDE "src\Main.asm"
	INCLUDE "src\MainB.asm"
	INCLUDE "src\Rout1.asm"
	INCLUDE "src\Rout2.asm"
	INCLUDE "src\High.asm"
	INCLUDE "src\Subr1.asm"
	INCLUDE "src\Subr1B.asm"
	INCLUDE "src\Subr1C.asm"
	INCLUDE "src\Subr2.asm"
	INCLUDE "src\DataFiles.asm"
	INCLUDE "src\Flags.asm"
	INCLUDE "src\ObjPro.asm"
	INCLUDE "src\ObjPro2.asm"
	INCLUDE "src\Object1.asm"
	INCLUDE "src\Object2.asm"
	INCLUDE "src\Object3.asm"
	INCLUDE "src\SpGra.asm"
	INCLUDE "src\PatIn1.asm"
	INCLUDE "src\PatDat1.asm"
	INCLUDE "src\PatDat2.asm"
	INCLUDE "src\PatDat3.asm"
	INCLUDE "src\Sect1.asm"
	INCLUDE "src\Sect2.asm"
	INCLUDE "src\Vectors1.asm"
	INCLUDE "src\Vectors2.asm"
	INCLUDE "src\StartUp.asm"		; Must be the last file!

	objcodeend = P%
	PRINT"Code start  = ",~objstrt%
	PRINT"End of code = ",~last-1
	PRINT"Length      = ",~last-objstrt%,"    (",last-objstrt%,") bytes"
	PRINT"Bytes left  = ",~objend%-last,"   (",objend%-last,") bytes"


	\\ Load Music driver binary file
	\\	OSCLI" LOAD MOBJ "+STR$~(&800+modu%+(&4400-objstrt%))
	ORG &4400
	INCBIN "object\MOBJ.o"


	\\ Output Object code binaries to the image
	SAVE "Mod", &900, &900 + modu%, &900, &900

	PRINT "Saving Obj ", ~objstrt%, ~objcodeend, ~gogo, ~objstrt%
	SAVE "Obj", objstrt%, objcodeend, gogo, objstrt%

	\\ Save Main Basic Loader ( gets tokenised forst )
	PUTBASIC "bas_extra\L.bas.txt" ,"$.L"

	\\ Copy the Loader into the disk image - generated by the pre-build step
	PUTFILE "LoadGam", "$.LoadGam", &700, &700

	\\ Loading screen
	\\	PUTFILE "src\GALASCR.IMG", "$.GALASCR", &5800
