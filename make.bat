
beebasm -i Prebuild.mak

beebasm -i Master.mak -di G2_BLANK.ssd -do Galaforce2BBC.ssd
@Echo. Done! .ssd image has been built
dir *.ssd
