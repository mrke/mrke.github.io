      SUBROUTINE COND

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

C     SUBROUTINE FOR CALCULATING HEAT TRANSFER TO THE SUBSTRATE
C     ORIGINALLY DEVELOPED FOR A GARTER SNAKE, THAMNOPHIS ELEGANS

      IMPLICIT NONE

      DOUBLE PRECISION A1,A2,A3,A4,A4B,A5,A6,AL,ALT,AMASS,ANDENS,AREF
      DOUBLE PRECISION ASILP,AT,ATOT,AV,BP,BREF,CREF,CUSTOMGEOM,DEPSEL
      DOUBLE PRECISION DEPSUB,EMISAN,EMISSB,EMISSK,F12,F13,F14,F15,F16
      DOUBLE PRECISION F21,F23,F24,F25,F26,F31,F32,F41,F42,F51,F52,F61
      DOUBLE PRECISION FATOSB,FATOSK,FLSHCOND,FLUID,G,H2O_BALPAST
      DOUBLE PRECISION HSHSOI,HSOIL,MSHSOI,MSOIL,PHI,PHIMAX,PHIMIN
      DOUBLE PRECISION PSHSOI,PSOIL,PTCOND,PTCOND_ORIG,QCOND,QCONV
      DOUBLE PRECISION QIRIN,QIROUT,QMETAB,QRESP,QSEVAP,QSOLAR,R
      DOUBLE PRECISION RELHUM,RHO1_3,SHP,SIDEX,SIG,SUBTK,SUBTK2,TA
      DOUBLE PRECISION TCORES,TOTLEN,TQSOL,TR,TRANS1,TSHSOI,TSKIN
      DOUBLE PRECISION TSOIL,TSUBST,TWING,VEL,WEVAP,WQSOL,XTRY,ZSOIL

      INTEGER IHOUR,GEOMETRY,NODNUM,WINGMOD,WINGCALC

      DIMENSION TSOIL(25),TSHSOI(25),ZSOIL(10),DEPSEL(25),TCORES(25)
      DIMENSION CUSTOMGEOM(8),SHP(3)
      DIMENSION MSOIL(25),MSHSOI(25),PSOIL(25),PSHSOI(25),HSOIL(25)
     & ,HSHSOI(25)

      COMMON/FUN1/QSOLAR,QIRIN,QMETAB,QRESP,QSEVAP,QIROUT,QCONV,QCOND
      COMMON/FUN2/AMASS,RELHUM,ATOT,FATOSK,FATOSB,EMISAN,SIG,FLSHCOND
      COMMON/WINGFUN/RHO1_3,TRANS1,AREF,BREF,CREF,PHI,F21,F31,F41,F51
     &,SIDEX,WQSOL,PHIMIN,PHIMAX,TWING,F12,F32,F42,F52
     &,F61,TQSOL,A1,A2,A3,A4,A4B,A5,A6,F13,F14,F15,F16,F23,F24,F25,F26
     &,WINGCALC,WINGMOD
      COMMON/FUN3/AL,TA,VEL,PTCOND,SUBTK,DEPSUB,TSUBST,PTCOND_ORIG
      COMMON/FUN4/TSKIN,R,WEVAP,TR,ALT,BP,H2O_BALPAST
      COMMON/DEPTHS/DEPSEL,TCORES
      COMMON/WDSUB1/ANDENS,ASILP,EMISSB,EMISSK,FLUID,G,IHOUR
      COMMON/WCOND/TOTLEN,AV,AT
      COMMON/SOIL/TSOIL,TSHSOI,ZSOIL,MSOIL,MSHSOI,PSOIL,PSHSOI,HSOIL,
     & HSHSOI
      COMMON/GUESS/XTRY
      COMMON/BEHAV2/GEOMETRY,NODNUM,CUSTOMGEOM,SHP

C     SOIL THERMAL COND. (SUBTK =0.35W/M-C)
C     WOOD ALSO HAS A THERMAL COND. 0.10-0.35 W/M-C
C     CHANGE SUBSTRATE THERMAL CONDUCTIVITY DEPENDING ON WHETHER ON THE GROUND OR NOT.

C     !!NOTE THAT FRACTION CONTACTING GROUND CURRENTY SET TO ZERO IF CLIMBING IN SUB. GEOM!!

      IF(DEPSEL(IHOUR).GT.0.0000)THEN
C      ABOVE GROUND - USE WOOD THERMAL CONDUCTIVITY FOR SUBSTRATE
       SUBTK2=0.10
      ELSE
C      USE STANDARD SOIL THERMAL CONDUCTIVITY
       SUBTK2=SUBTK
      ENDIF

      QCOND=AV*(SUBTK2/(ZSOIL(2)/100.))*(TSKIN-TSUBST) ! CONDUCTION HEAT FLOW

      RETURN
      END
