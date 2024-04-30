#!../../bin/darwin-x86/toyIoc

#- You may have to change toyIoc to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/toyIoc.dbd"
toyIoc_registerRecordDeviceDriver pdbbase

## Load record instances
# dbLoadTemplate "db/user.substitutions"
# dbLoadRecords "db/toyIocVersion.db", "user=zhezhang"
# dbLoadRecords "db/dbSubExample.db", "user=zhezhang"
dbLoadRecords "db/sphere.db", "P=SPHERE"

#- Set this to see messages from mySub
#-var mySubDebug 1

#- Run this to trace the stages of iocInit
#-traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=zhezhang"
