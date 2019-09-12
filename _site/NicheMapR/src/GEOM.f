       SUBROUTINE GEOM

C     NICHEMAPR: SOFTWARE FOR BIOPHYSICAL MECHANISTIC NICHE MODELLING

C     COPYRIGHT (C) 2018 MICHAEL R. KEARNEY AND WARREN P. PORTER

C     THIS PROGRAM IS FREE SOFTWARE: YOU CAN REDISTRIBUTE IT AND/OR MODIFY
C     IT UNDER THE TERMS OF THE GNU GENERAL PUBLIC LICENSE AS PUBLISHED BY
C     THE FREE SOFTWARE FOUNDATION, EITHER VERSION 3 OF THE LICENSE, OR (AT
C      YOUR OPTION) ANY LATER VERSION.

C     THIS PROGRAM IS DISTRIBUTED IN THE HOPE THAT IT WILL BE USEFUL, BUT
C     WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED WARRANTY OF
C     MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. SEE THE GNU
C     GENERAL PUBLIC LICENSE FOR MORE DETAILS.

C     YOU SHOULD HAVE RECEIVED A COPY OF THE GNU GENERAL PUBLIC LICENSE
C     ALONG WITH THIS PROGRAM. IF NOT, SEE HTTP://WWW.GNU.ORG/LICENSES/.

C	  THIS SUBROUTINE COMPUTES DIMENSIONS AND SURFACE AREAS REQUIRED FOR
C     SOLVING THE HEAT AND WATER BALANCES, GIVEN THE CHOSEN GEOMETRY

      IMPLICIT NONE

      DOUBLE PRECISION A,A1,A2,A3,A4,A4B,A5,A6,ABSAN,ABSMAX,ABSMIN,ABSSB
      DOUBLE PRECISION AEFF,AHEIT,AL,ALENTH,ALT,AMASS,ANDENS,AREA,AREF
      DOUBLE PRECISION ASEMAJR,ASILN,ASILP,AT,ATOT,ATOTAL,AV,AWIDTH,B,BP
      DOUBLE PRECISION BREF,BSEMINR,C,CONTDEP,CONTDEPTH,CONTH,CONTHOLE
      DOUBLE PRECISION CONTVOL,CONTW,CONTWET,CONVAR,CREF,CSEMINR
      DOUBLE PRECISION CUSTOMGEOM,CUTFA,D,DEPSUB,EMISAN,EMISSB,EMISSK
      DOUBLE PRECISION F12,F13,F14,F15,F16,F21,F23,F24,F25,F26,F31,F32
      DOUBLE PRECISION F41,F42,F51,F52,F61,FATCOND,FATOBJ,FATOSB,FATOSK
      DOUBLE PRECISION FLSHCOND,FLUID,G,GMASS,H2O_BALPAST,HC,HD,HDFORC
      DOUBLE PRECISION HDFREE,NEWDEP,P,PANT,PANTMAX,PDIF
      DOUBLE PRECISION PCTN,PCTP,PEYES,PHI,PHIMAX,PHIMIN,PI,PMOUTH
      DOUBLE PRECISION PTCOND,PTCOND_ORIG,QSOLR,R,R1,RAINFALL,RELHUM
      DOUBLE PRECISION RHO1_3,RINSUL,SHP,SIDEX,SIG,SKINT,SKINW,SPHEAT
      DOUBLE PRECISION SUBTK,TA,TOBJ,TOTLEN,TQSOL,TR,TRANS1,TSKIN,TSKY
      DOUBLE PRECISION TSUBST,TWING,VEL,VOL,WC,WCUT,WEVAP,WEYES,WQSOL
      DOUBLE PRECISION WRESP,ZEN,RAINMULT

      INTEGER CONTONLY,CONTYPE,GEOMETRY,IHOUR,LIVE,MICRO,NM
      INTEGER NODNUM,POND,WETMOD,WINGCALC,WINGMOD
      INTEGER RAINHOUR
      
      DIMENSION CUSTOMGEOM(8),SHP(3)

      COMMON/ANPARMS/RINSUL,R1,AREA,VOL,FATCOND
      COMMON/BEHAV2/GEOMETRY,NODNUM,CUSTOMGEOM,SHP
      COMMON/CONT/CONTH,CONTW,CONTVOL,CONTDEP,CONTHOLE,CONTWET,RAINMULT,
     & WETMOD,CONTONLY,CONTYPE,RAINHOUR
      COMMON/CONTDEPTH/CONTDEPTH
      COMMON/DIMENS/ALENTH,AWIDTH,AHEIT
      COMMON/ELLIPS/ASEMAJR,BSEMINR,CSEMINR
      COMMON/EVAP1/WEYES,WRESP,WCUT,AEFF,CUTFA,HD,PEYES,SKINW,
     & SKINT,HC,CONVAR,PMOUTH,PANT,PANTMAX
      COMMON/EVAP2/HDFREE,HDFORC
      COMMON/FUN2/AMASS,RELHUM,ATOT,FATOSK,FATOSB,EMISAN,SIG,FLSHCOND
      COMMON/FUN3/AL,TA,VEL,PTCOND,SUBTK,DEPSUB,TSUBST,PTCOND_ORIG
      COMMON/FUN4/TSKIN,R,WEVAP,TR,ALT,BP,H2O_BALPAST
      COMMON/FUN5/WC,ZEN,PDIF,ABSSB,ABSAN,ASILN,FATOBJ,NM
      COMMON/FUN6/SPHEAT,ABSMAX,ABSMIN,LIVE
      COMMON/PONDTEST/POND
      COMMON/RAINFALLS/RAINFALL
      COMMON/WCOND/TOTLEN,AV,AT
      COMMON/WDSUB1/ANDENS,ASILP,EMISSB,EMISSK,FLUID,G,IHOUR
      COMMON/WDSUB2/QSOLR,TOBJ,TSKY,MICRO
      COMMON/WINGFUN/RHO1_3,TRANS1,AREF,BREF,CREF,PHI,F21,F31,F41,F51,
     & SIDEX,WQSOL,PHIMIN,PHIMAX,TWING,F12,F32,F42,F52,F61,TQSOL,A1,A2,
     & A3,A4,A4B,A5,A6,F13,F14,F15,F16,F23,F24,F25,F26,WINGCALC,WINGMOD
      COMMON/WUNDRG/NEWDEP

      DATA PI/3.14159265/

      VOL=AMASS/ANDENS
      R=((3./4.)*VOL/PI)**(1./3.)
      R1=R-RINSUL
      D=2*R1
      AL=VOL**(1./3.) !JOHN MITCHEL'S CHARACTERISTIC DIMENSION FOR CONVECTION (1976)
      GMASS = AMASS*1000.

C      IF(NEWDEP.GT.0.)THEN ! HAS CLIMBED
C       PTCOND=0.
C      ELSE
C       PTCOND=PTCOND_ORIG
C      ENDIF

      IF((CONTH.GT.0.).AND.(POND.EQ.1))THEN !CONTAINER MODEL RUNNING
       R=CONTW/2./1000.
       R1=R-RINSUL
       D=2*R1
       IF(CONTDEP.GT.CONTH)THEN !MAKE SURE CONTAINER DOESN'T OVERFILL
        CONTDEP=CONTH
       ENDIF
       VOL=PI*R1**2.*(CONTDEP/1000.)
       AMASS=VOL*ANDENS
       IF(AMASS.LE.0.)THEN
        AMASS=0.
        CONTDEP=0.
       ENDIF
       IF(CONTYPE.EQ.1)THEN
C       CONTAINER IS SUNK INTO THE GROUND SO ONLY ONE OF THE CIRCLES OF THE CYLINDER EXPOSED TO CONVECTION/EVAP
        AREA=2.*PI*R1**2.+2.*PI*R1*(CONTDEP/1000.)
        AWIDTH=2.*R1
        ALENTH=CONTDEP/1000.
        ASILN=PI*R1**2.
        ASILP=AWIDTH*ALENTH
        AV=PI*R1**2.+2.*PI*R1*(CONTDEP/1000.)
        ATOT= AREA
        AT=AREA*SKINT
        IF((CONTDEP.LE.0.01).AND.(RAINFALL.EQ.0))THEN
         AEFF=0.
        ELSE
         AEFF=PI*R1**2.*SKINW
        ENDIF
        AL=CONTDEP/1000.
        GMASS=AMASS*1000.
        PEYES=0.
        GEOMETRY=1
        FATOSK=PI*R1**2./AREA
        FATOSB=0.
        FATOBJ=0.
        GO TO 999
       ENDIF
       IF(CONTYPE.EQ.0)THEN
C       CONTAINER IS SITTING ON SURFACE SO SIDES ARE EXPOSED TOO
        AREA=2.*PI*R1**2.+2.*PI*R1*(CONTDEP/1000.)
        AWIDTH=2.*R1
        ALENTH=CONTDEP/1000.
        ASILN=PI*R1**2.
        ASILP=AWIDTH*ALENTH
        AV=PI*R1**2
        ATOT=AREA
        AT=AREA*SKINT
        IF((CONTDEP.LE.0.01).AND.(RAINFALL.EQ.0))THEN
         AEFF=0.
        ELSE
         AEFF=PI*R1**2.*SKINW
        ENDIF
        AL=CONTDEP/1000.
        GMASS=AMASS*1000.
        PEYES=0.
        GEOMETRY=1
        FATOSK=PI*R1**2./AREA
        FATOSB=2.*PI*R1*(CONTDEP/1000.)/AREA
        FATOBJ=0.
        GO TO 999
       ENDIF
      ENDIF

      IF(WINGMOD.GE.1) THEN
C      WING MODEL RUNNING
       IF(WINGCALC.EQ.1)THEN
        ALENTH=BREF/100.
        AWIDTH=CREF/100.
        AHEIT= 0.01/100.
        ATOT=ALENTH*AWIDTH*2.+ALENTH*AHEIT*2.+AWIDTH*AHEIT*2.
        AREA=ATOT
        ASILN=ALENTH*AWIDTH
        ASILP=AWIDTH*AHEIT
        AL=ALENTH
        R=ALENTH/2.
        R1=R
        D=2.*R
        VOL=ALENTH*AWIDTH*AHEIT
        AV=ATOT/2.
        AEFF=0.
        GO TO 999
       ELSE
        A=((3./4.)*VOL/(PI*SHP(2)*SHP(3)))**(1./3.)
        ALENTH=A
        B=A*SHP(2)
        C=A*SHP(3)
        P=1.6075
        AREA=(4*PI*(((A**P*B**P+A**P*C**P+B**P*C**P))/3.)**(1/P))
        AV=AREA*PTCOND
        ATOT=AREA
        AEFF=SKINW*(AREA-AV)
        ASILN=PI*A*C
        ASILP=PI*B*C
        ASEMAJR=A
        BSEMINR=B
        CSEMINR=C
        GO TO 999
       ENDIF
      ENDIF

C     FLAT PLATE
      IF(GEOMETRY.EQ.0)THEN
C      ASSUME A CUBE FOR THE MOMENT
       AHEIT=(VOL/(SHP(2)*SHP(3)))**(1./3.)
       AWIDTH=AHEIT*SHP(2)
       ALENTH= AHEIT*SHP(3)
       ATOT=ALENTH*AWIDTH*2.+ALENTH*AHEIT*2.+AWIDTH*AHEIT*2.
       AREA=ATOT
       ASILN=ALENTH*AWIDTH
       ASILP=AWIDTH*AHEIT
       AL=AHEIT
       IF(AWIDTH.LE.ALENTH)THEN
        AL=AWIDTH
       ELSE
        AL=ALENTH
       ENDIF
       R=ALENTH/2.
       AV=ATOT*PTCOND
       AEFF=SKINW*(AREA-AV)
       GO TO 999
      ENDIF

C     CYLINDER
      IF(GEOMETRY.EQ.1)THEN
       R1=(VOL/(PI*SHP(2)*2.))**(1./3.)
       ALENTH=R1*SHP(2)
       AREA=2*PI*R1**2+2*PI*R1*ALENTH
       VOL=AMASS/ANDENS
       AWIDTH=2.*R1
       ASILN=AWIDTH * ALENTH
       ASILP=PI*R1**2
       AV=AREA*PTCOND
       ATOT=AREA
       IF(PANT.GT.1)THEN
        AEFF=(SKINW+PMOUTH)*(AREA-AV)
       ELSE
        AEFF=SKINW*(AREA-AV)
       ENDIF
       AL=ALENTH
       TOTLEN=ALENTH
       GO TO 999
      ENDIF

C     ELLIPSOID
      IF(GEOMETRY.EQ.2)THEN
       A=((3./4.)*VOL/(PI*SHP(2)*SHP(3)))**(1./3.)
       B=A*SHP(2)
       C=A*SHP(3)
       P=1.6075
       AREA=(4.*PI*(((A**P*B**P+A**P*C**P+B**P*C**P))/3.)**(1/P))
       AV=AREA*PTCOND
       ATOT=AREA
       IF(PANT.GT.1)THEN
        AEFF=(SKINW+PMOUTH)*(AREA-AV)
       ELSE
        AEFF=SKINW*(AREA-AV)
       ENDIF
       ASILN=PI*A*C
       ASILP=PI*B*C
       IF(ASILN.LT.ASILP)THEN
        ASILN=PI*B*C
        ASILP=PI*A*C
       ENDIF
       ASEMAJR=A
       BSEMINR=B
       CSEMINR=C
       GO TO 999
      ENDIF

C     LIZARD
      IF(GEOMETRY.EQ.3)THEN
       ATOTAL=(10.4713*GMASS**0.688)/10000.
       AV=(0.425*GMASS**0.85)/10000.
       ATOT=ATOTAL
       VOL=AMASS/ANDENS
C      CONDUCTION - RADIATION, ETC DIMENSION. ASSUME L=2D=4R1;
C      THEN VOL=PI*R1**2*L = 4*PI*R1**3
       R1=(VOL/(4.*PI))**(1./3.)
C      NORMAL AND POINTING @ SUN SILHOUETTE AREA: PORTER & TRACY 1984
C      MAX. SILHOUETTE AREA (NORMAL TO THE SUN)
       ASILN=(3.798*GMASS**.683)/10000.
C      MIN. SILHOUETTE AREA (POINTING TOWARD THE SUN)
       ASILP=(0.694*GMASS**.743)/10000.
       AREA=ATOT
       AV=AREA*PTCOND
       AT=AREA*SKINT
       IF(PANT.GT.1)THEN
        AEFF=(SKINW+PMOUTH)*AREA-SKINW*AREA*PTCOND-SKINW*AREA*SKINT
       ELSE
        AEFF=SKINW*AREA-SKINW*AREA*PTCOND-SKINW*AREA*SKINT
       ENDIF
      ENDIF

      IF(GEOMETRY.EQ.4)THEN
C      AREA OF LEOPARD FROG (C.R. TRACY 1976 ECOL. MONOG.)
       ATOTAL=(12.79*GMASS**.606)/10000.
       AV=(0.425*GMASS**.85)/10000.
       ATOT=ATOTAL
C      NORMAL AND POINTING @ SUN SILHOUETTE AREA: EQ'N 11 TRACY 1976
       ZEN=0.
       PCTN=1.38171E-06*ZEN**4-1.93335E-04*ZEN**3.+
     & 4.75761E-03*ZEN**2.-0.167912*ZEN+45.8228
       ASILN=PCTN*ATOT/100.
       ZEN=90.
       PCTP=1.38171E-06*ZEN**4-1.93335E-04*ZEN**3.+
     & 4.75761E-03*ZEN**2.-0.167912*ZEN+45.8228
       ASILP=PCTP*ATOT/100.
       AREA=ATOT
       AV=AREA*PTCOND
       AT=AREA*SKINT
       IF(PANT.GT.1)THEN
        AEFF=(SKINW+PMOUTH)*AREA-SKINW*AREA*PTCOND-SKINW*AREA*SKINT
       ELSE
        AEFF=SKINW*AREA-SKINW*AREA*PTCOND-SKINW*AREA*SKINT
       ENDIF       
      ENDIF

C     USER-DEFINED GEOMETRY
      IF(GEOMETRY.EQ.5) THEN
       ATOTAL=(CUSTOMGEOM(1)*GMASS**CUSTOMGEOM(2))/10000.
       AV=(CUSTOMGEOM(3)*GMASS**CUSTOMGEOM(4))/10000.
       ATOT=ATOTAL
       VOL=AMASS/ANDENS
C      CONDUCTION - RADIATION, ETC DIMENSION. ASSUME L=2D=4R1;
C      THEN VOL=PI*R1**2*L = 4*PI*R1**3
       R1=(VOL/(4.*PI))**(1./3.)
C      NORMAL AND POINTING @ SUN SILHOUETTE AREA: PORTER & TRACY 1984
C      USER MUST DEFINE MAX. SILHOUETTE AREA (NORMAL TO THE SUN)
       ASILN=(CUSTOMGEOM(5)*GMASS**CUSTOMGEOM(6))/10000.
C      USER MUST DEFINE MIN. SILHOUETTE AREA (POINTING TOWARD THE SUN)
       ASILP=(CUSTOMGEOM(7)*GMASS**CUSTOMGEOM(8))/10000.
       AREA=ATOT
       AV=AREA*PTCOND
       AT=AREA*SKINT
       IF(PANT.GT.1)THEN
        AEFF=(SKINW+PMOUTH)*AREA-SKINW*AREA*PTCOND-SKINW*AREA*SKINT
       ELSE
        AEFF=SKINW*AREA-SKINW*AREA*PTCOND-SKINW*AREA*SKINT
       ENDIF
      ENDIF

999   CONTINUE

      RETURN
      END