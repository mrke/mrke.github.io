---
title          : "Endotherm Models"
excerpt: Computing the heat balances of birds, mammals and other endotherms

---
<h1>Endotherm Models</h1>
<p>
Computing heat budgets for endotherms involves using the same principles as for ectotherms, but instead of solving for core temperature one typically solves for the metabolic rate or water loss rate, depending on whether the animal is in a hot or cold environment. 
<p>
There are two broad modelling algorithms for computing heat budgets for endotherms in NicheMapR, one simple but limited in scope, and one more complex but more generally applicable. 
<p>
The simple model is the function <a href="https://github.com/mrke/NicheMapR/blob/master/R/ellipsoid.R">ellipsoid</a>. This is an analytical model, i.e. can be solved directly without numerical methods, and is described in detail in Porter and Kearney (2009). As the name suggests, it is a model of an ellipsoid-shaped endotherm conceived as having an outer fur layer and an inner flesh layer. Given an air temperature and wind speed, the target core body temperature, as well as the particular shape and size of the ellipsoid, the fur depth and conductivity, and the flesh thermal conductivity, it will compute the required metabolic heat production. It is only designed to work for an environment where there is no solar radiation and the temperatures of the surrounding surfaces are the same as the air temperature ('black-body' conditions, as approximated in a room, a cave or deep shade). It has a crude method for determining required evaporative water loss in situations where the predicted metabolic rate is below the specified basal level.
<p>
The more complex model is a pared down, deconstructed version of the general endotherm model developed by Porter and colleagues over many years (see Mathewson and Porter 2013, including their <a href="https://journals.plos.org/plosone/article/file?id=10.1371/journal.pone.0072863.s007&type=supplementary">supplementary derivation</a>).
<p>
The version in NicheMapR includes a set of sub-functions written in FORTRAN and directly callable from R, as described in detail in the <a href="/NicheMapR/inst/doc/endotherm-components-tutorial">Endotherm Components Tutorial</a>. These functions can be used to estimate the heat balance of a single-part animal (e.g. a bird modelled as an ellipsoid) or could be used to build up a multi-part animal (e.g. a bat modelled as an ellipsoid torso plus two plate-shaped wings). It is currently a beta version and is yet to be fully documented and described by a software note. Some of the code for this model is not yet open source.
<p>
In combination, these functions allow the calculation of heat and water budgets by numerically solving for the skin temperature and the outer temperature of the insulation (fur or feathers) in the process of finding the required metabolic heat generation for a particular core temperature. It is explicit about the effects of air temperature, wind speed, solar and infrared radiation and humidity, and thus can be used for complex outdoor environments. It is also explicit about the dorsal and ventral properties of the organism as well as the environment the dorsal and ventral side is exposed to (e.g. solar radiation hitting the top of the animal more intensely than the bottom). The model takes more detailed input on the insulation properties than the ellipsoid function and can be solved for different geometries, specifically a plate, a cylinder, a sphere or an ellipsoid.
<p>
The overall strategy of solving the problem is to solve, for a given state of the animal (e.g. core temperature, posture, skin wetness) and environment, the heat exchange for an object of entirely dorsal properties experiencing the dorsal environment, and the same for the ventral case. Then a weighted mean metabolic rate is computed from the dorsal and ventral estimate. Finally, the respiratory heat loss is computed for the whole system to obtain a final estimate of the heat generation. If this value is less than the specified lowest allowable metabolic rate (e.g. basal for a resting animal, higher for an active animal), then a sequence of potential thermoregulatory responses is attempted to find a viable (physically possible) solution.
<p>
The exact nature of the configuration of these subroutines will depend on the details of how the species in question thermoregulates. In particular, it will depend on how the organism changes posture and pelage (e.g. piloerection), allows core temperature to rise, alters flesh conductivity, pants or sweats, and in what order. The function <a href="https://github.com/mrke/NicheMapR/blob/master/R/endoR_devel.R">endoR_devel</a> provides a typical example of a configuration, which under heat stress will first uncurl, then allow flesh conductivity to rise, then allow core temperature to rise, then pant and then sweat.
<p>
The <a href="https://github.com/mrke/NicheMapR/blob/master/R/endoR_devel.R">endoR_devel</a> function runs slowly due to the constant exchange between R and FORTRAN. The <a href="https://github.com/mrke/NicheMapR/blob/master/R/endoR.R">endoR</a> function, in contrast, is a wrapper to an equivalent algorithm entirely in FORTRAN and is around two orders of magnitude faster. The FORTRAN code for this algorithm (function SOLVENDO) is provided below and can be modified accordingly, after a working version has been developed in the (quicker and easier) R coding environment on the basis of the <a href="https://github.com/mrke/NicheMapR/blob/master/R/endoR_devel.R">endoR_devel</a> function.
<p>
The <a href="/NicheMapR/inst/doc/endotherm-model-tutorial">Endotherm Model Tutorial</a> provides examples of using the <a href="https://github.com/mrke/NicheMapR/blob/master/R/endoR.R">endoR</a> function. 
<p>
<h1>References</h1>
<p>
Mathewson, P. D., & Porter, W. P. (2013). Simulating Polar Bear Energetics during a Seasonal Fast Using a Mechanistic Model. PLoS One, 8(9), e72863. doi:10.1371/journal.pone.0072863
<p>
Porter, W. P., & Kearney, M. (2009). Size, shape, and the thermal niche of endotherms. Proceedings of the National Academy of Sciences, 106(Supplement 2), 19666–19672. doi:10.1073/pnas.0907321106
<p>

~~~ FORTRAN
      subroutine SOLVENDO(INPUT,TREG,MORPH,ENBAL,MASBAL)
     
      implicit none
~~~

~~~
      DOUBLE PRECISION EMISAN, SHAPE, FATOBJ,FSKREF,FGDREF,NESTYP,PCTDIF
      DOUBLE PRECISION ABSSB,FLTYPE,ELEV,BP,NITESHAD,SHADE,QSOLR
      DOUBLE PRECISION RoNEST,Z,VEL,TS,TFA,FABUSH,FURTHRMK,RH,TCONDSB
      DOUBLE PRECISION TBUSH,TC,PCTBAREVAP,FLYHR,FURWET,AK1,AK2,PCTEYES
      DOUBLE PRECISION DIFTOL,SKINW,TSKY,TVEG,TAREF,DELTAR,RQ,TIMACT
      DOUBLE PRECISION O2GAS, N2GAS, CO2GAS,RELXIT,PANT,EXTREF,UNCURL
      DOUBLE PRECISION AKMAX,AK1inc,TCMAX,RAISETC,TCREF,Q10,QBASREF
      DOUBLE PRECISION PANTMAX,MXWET,SWEAT
      DOUBLE PRECISION QGEN, QBASAL,TA, SHAPEB_MAX, SHAPEB_REF, SHAPEB,
     & DHAIRD, DHAIRV, LHAIRD, LHAIRV, ZFURD, ZFURV, RHOD, RHOV, REFLD, 
     & REFLV, MAXPTVEN, IRPROPout
      DOUBLE PRECISION, DIMENSION(3) :: KEFARA,BETARA,B1ARA,DHAR,LHAR,
     & RHOAR,ZZFUR,REFLFR
      DOUBLE PRECISION FURTST,R2
      DOUBLE PRECISION AMASS, ANDENS, FATPCT, ZFUR, SUBQFAT,
     & DHARA, RHOARA, PCOND, GEOMout
      DOUBLE PRECISION VOL,D,MASFAT,VOLFAT,ALENTH,AWIDTH,AHEIT,ATOT,
     & ASILN,ASILP,GMASS,AREASKIN,FLSHVL,FATTHK,ASEMAJ,BSEMIN,
     & CSEMIN,CONVSK,CONVAR,R1,ASIL
      DOUBLE PRECISION FAVEG,FASKY,FAGRD,FANEST,C3,C4,C5,C6,C7,
     & F_FACTORout
      DOUBLE PRECISION CZ,ABSAND,ABSANV,PI,QNORM,QSOLAR,QSDIR,QSOBJ,
     & QSSKY,QSRSB,QSDIFF,QDORSL,QVENTR,SOLARout,ZEN
      DOUBLE PRECISION QCONV,HC,HCFREE,HCFOR,HD,HDFREE,HDFORC,ANU,RE,GR,
     & PR,RA,SC,CONVOUT,SURFAR,TENV
      DOUBLE PRECISION SIMULSOLout,SIMULOUT
      DOUBLE PRECISION FABUSHREF,FATOBJREF,FASKYREF,FAGRDREF,FAVEGREF
      DOUBLE PRECISION KEFF,QSLR,RDXDEP,XR,X,RSKIN,RFLESH,RFUR
      DOUBLE PRECISION RRAD,LEN,AREACND,KFURCMPRS,CD,ZFURCOMP,ZL
      DOUBLE PRECISION FURVARS,GEOMVARS,ENVVARS,TRAITS,IPT
      DOUBLE PRECISION TGRD,TLOWER
      DOUBLE PRECISION ZBRENTin,GEND,GENV,DMULT,QMIN,QM1,QM2,QSUM,TAEXIT
      DOUBLE PRECISION TLUNG,TOL,VMULT,ZBRENTout,Q10mult,HTOVPR,SWEATGS
      DOUBLE PRECISION EVAPGS,INPUT,PANTING,TSKINMAX
      DOUBLE PRECISION SHAPEB_LAST,AK1LAST,TCLAST,PANTLAST,SKINWLAST
      DOUBLE PRECISION SAMODE,ORIENT,MAXPCOND
      DOUBLE PRECISION TREG,MORPH,ENBAL,MASBAL,sigma
      DOUBLE PRECISION GEVAP,PCTO2,PCTN2,PCTCO2,O2STP,O2MOL1,
     & N2MOL1,AIRML1,O2MOL2,N2MOL2,AIRML2,AIRVOL,RESPFN,QRESP,RESPGEN
      DOUBLE PRECISION TFAD,TSKCALCAVD,QCONVD,QCONDD,QGENNETD,QSEVAPD,
     & QRADD,QSLRD,QRSKYD,QRBSHD,QRVEGD,QRGRDD,QFSEVAPD,NTRYD,SUCCESSD
      DOUBLE PRECISION TFAV,TSKCALCAVV,QCONVV,QCONDV,QGENNETV,QSEVAPV,
     & QRADV,QSLRV,QRSKYV,QRBSHV,QRVEGV,QRGRDV,QFSEVAPV,NTRYV,SUCCESSV
      DOUBLE PRECISION QIR,QIROUTD,QIRIND,QIROUTV,QIRINV,QSOL,QIRIN,
     & QMET,QEVAP,QIROUT,QCOND,SHAPEC
      
      INTEGER S
    
      DIMENSION IRPROPout(27),GEOMout(25),CONVOUT(14),F_FACTORout(9),
     & SOLARout(8),SIMULSOLout(2,15),SIMULOUT(15),FURVARS(9),
     & GEOMVARS(16),TRAITS(9),ENVVARS(17),ZBRENTin(16),ZBRENTout(15),
     & INPUT(85),TREG(15),MORPH(20),ENBAL(10),MASBAL(10)

      PI = ACOS(-1.0d0)
      
      QGEN=input(1)
      QBASAL=input(2)
      TA=input(3)
      SHAPEB_MAX=input(4)
      SHAPEB_REF=input(5)
      SHAPEB=input(6)
      DHAIRD=input(7)
      DHAIRV=input(8)
      LHAIRD=input(9)
      LHAIRV=input(10)
      ZFURD=input(11)
      ZFURV=input(12)
      RHOD=input(13)
      RHOV=input(14)
      REFLD=input(15)
      REFLV=input(16)
      MAXPTVEN=input(17)
      SHAPE=input(18)
      EMISAN=input(19)
      FATOBJ=input(20)
      FSKREF=input(21)
      FGDREF=input(22)
      NESTYP=input(23)
      PCTDIF=input(24)
      ABSSB=input(25)
      SAMODE=input(26)
      FLTYPE=input(27)
      ELEV=input(28)
      BP=input(29)
      NITESHAD=input(30)
      SHADE=input(31)
      QSOLR=input(32)
      RoNEST=input(33)
      Z=input(34)
      VEL=input(35)
      TS=input(36)
      TFA=input(37)
      FABUSH=input(38)
      FURTHRMK=input(39)
      RH=input(40)
      TCONDSB=input(41)
      TBUSH=input(42)
      TC=input(43)
      PCTBAREVAP=input(44)
      FLYHR=input(45)
      FURWET=input(46)
      AK1=input(47)
      AK2=input(48)
      PCTEYES=input(49)
      DIFTOL=input(50)
      SKINW=input(51)
      TSKY=input(52)
      TVEG=input(53)
      TAREF=input(54)
      DELTAR=input(55)
      RQ=input(56)
      TIMACT=input(57)
      O2GAS=input(58)
      N2GAS=input(59)
      CO2GAS=input(60)
      RELXIT=input(61)
      PANT=input(62)
      EXTREF=input(63)
      UNCURL=input(64)
      AKMAX=input(65)
      AK1inc=input(66)
      TCMAX=input(67)
      RAISETC=input(68)
      TCREF=input(69)
      Q10=input(70)
      QBASREF=input(71)
      PANTMAX=input(72)
      MXWET=input(73)
      SWEAT=input(74)
      TGRD=input(75)
      AMASS=input(76)
      ANDENS=input(77)
      SUBQFAT=input(78)
      FATPCT=input(79)
      PCOND=input(80)
      MAXPCOND = input(81)
      ZFURCOMP = input(82)
      PANTING=input(83)
      ORIENT=input(84)
      SHAPEC=input(85)
      
      TSKINMAX=TC ! initialise
      Q10mult=1. ! initialise
      
      do while(QGEN < QBASAL)

       !### IRPROP, infrared radiation properties of fur

       !# call the IR properties subroutine
       CALL IRPROP(TA, SHAPEB_MAX, SHAPEB_REF, SHAPEB, DHAIRD, DHAIRV, 
     &  LHAIRD, LHAIRV, ZFURD, ZFURV, RHOD, RHOV, REFLD, REFLV,
     &  MAXPTVEN, ZFURCOMP,IRPROPout)
      
       !# output
       KEFARA = IRPROPout(2:4) !# effective thermal conductivity of fur array, mean, dorsal, ventral (W/mK)
       BETARA = IRPROPout(5:7) !# term involved in computing optical thickess (1/mK2)
       B1ARA = IRPROPout(8:10) !# optical thickness array, mean, dorsal, ventral (m)
       DHAR = IRPROPout(11:13) !# fur diameter array, mean, dorsal, ventral (m)
       LHAR = IRPROPout(14:16) !# fur length array, mean, dorsal, ventral (m)
       RHOAR = IRPROPout(17:19) !# fur density array, mean, dorsal, ventral (1/m2)
       ZZFUR = IRPROPout(20:22) !# fur depth array, mean, dorsal, ventral (m)
       REFLFR = IRPROPout(23:25) !# fur reflectivity array, mean, dorsal, ventral (fractional, 0-1)
       FURTST = IRPROPout(26) !# test of presence of fur (length x diamater x density x depth) (-)
       KFURCMPRS = IRPROPout(27) ! # effictive thermal conductivity of compressed ventral fur (W/mK)
       !### GEOM, geometry

       !# input
       DHARA = DHAR(1) !# fur diameter, mean (m) (from IRPROP)
       RHOARA = RHOAR(1) !# hair density, mean (1/m2) (from IRPROP)
       ZFUR = ZZFUR(1) !# fur depth, mean (m) (from IRPROP)

       !# call the subroutine
       CALL GEOM(AMASS,ANDENS,FATPCT,SHAPE,ZFUR,SUBQFAT,SHAPEB,
     &  SHAPEB_REF,SHAPEC,DHARA,RHOARA,PCOND,SAMODE,ORIENT,GEOMout)
 
       !# output
       VOL = GEOMout(1) !# volume, m3
       D = GEOMout(2) !# characteristic dimension for convection, m
       MASFAT = GEOMout(3) !# mass body fat, kg
       VOLFAT = GEOMout(4) !# volume body fat, m3
       ALENTH = GEOMout(5) !# length, m
       AWIDTH = GEOMout(6) !# width, m
       AHEIT = GEOMout(7) !# height, m
       ATOT = GEOMout(8) !# total area, m2
       ASIL = GEOMout(9) !# silhouette area, m2
       ASILN = GEOMout(10) !# silhouette area parallel to sun, m2
       ASILP = GEOMout(11) !# silhouette area parallel to sun, m2
       GMASS = GEOMout(12) !# mass, g
       AREASKIN = GEOMout(13) !# area of skin, m2
       FLSHVL = GEOMout(14) !# flesh volume, m3
       FATTHK = GEOMout(15) !# fat layer thickness, m
       ASEMAJ = GEOMout(16) !# semimajor axis length, m
       BSEMIN = GEOMout(17) !# b semiminor axis length, m
       CSEMIN = GEOMout(18) !# c semiminor axis length, m (currently only prolate spheroid)
       CONVSK = GEOMout(19) !# area of skin for evaporation (total skin area - hair area), m2
       CONVAR = GEOMout(20) !# area for convection (total area minus ventral area, as determined by PCOND), m2
       R1 = GEOMout(21) !# shape-specific core-skin radius in shortest dimension, m
       R2 = GEOMout(22) !# shape-specific core-fur/feather interface radius in shortest dimension, m
       
       !### F_FACTOR, radiation configuration factors
       call F_FACTOR(SHADE, NITESHAD, QSOLR, FATOBJ, NESTYP,
     &  RoNEST, R1, FGDREF, FSKREF, AREASKIN, EMISAN,F_FACTORout)

       FAVEG = F_FACTORout(1) !# configuration factor to vegetation
       FASKY = F_FACTORout(2) !# configuration factor to sky
       FAGRD = F_FACTORout(3) !# configuration factor to ground
       FANEST = F_FACTORout(4) !# configuration factor to nest wall
       !# constants for infra-red exchange calculatiosn AREASKIN*CONFIG*EMISAN*SIG
       C3 = F_FACTORout(5) !# sky
       C4 = F_FACTORout(6) !# ground
       C5 = F_FACTORout(7) !# object
       C6 = F_FACTORout(8) !# vegetation (shade)
       C7 = F_FACTORout(9) !# nest 

       !### SOLAR, solar radiation

       !# solar radiation normal to sun's rays
       ZEN = pi/180.*Z !# convert degrees to radians
       if(Z.lt.90.)then !# compute solar radiation on a surface normal to the direct rays of the sun
        CZ = cos(ZEN)
        QNORM = QSOLR/CZ
       else !# diffuse skylight only
        QNORM = QSOLR
       endif

       ABSAND = 1 - REFLFR(2) !# solar absorptivity of dorsal fur (fractional, 0-1)
       ABSANV = 1 - REFLFR(3) !# solar absorptivity of ventral fur (fractional, 0-1)

       CALL SOLAR(ATOT, ABSAND, ABSANV, ABSSB, ASIL, PCTDIF, 
     &  QNORM, SHADE, QSOLR, FASKY, FATOBJ, FAVEG, SOLARout)

       QSOLAR = SOLARout(1) !# total (global) solar radiation (W) QSOLAR,QSDIR,QSOBJ,QSSKY,QSRSB,QSDIFF,QDORSL,QVENTR
       QSDIR = SOLARout(2) !# direct solar radiaton (W)
       QSOBJ = SOLARout(3) !# lateral diffuse solar radiation (W)
       QSSKY = SOLARout(4) !# diffuse solar radiation from sky (W)
       QSRSB = SOLARout(5) !# diffuse solar radiation reflected from substrate (W)
       QSDIFF = SOLARout(6) !# total diffuse solar radiation (W)
       QDORSL = SOLARout(7) !# total dorsal solar radiation (W)
       QVENTR = SOLARout(8) !# total ventral solar radiaton (W)

       !### CONV, convection

       !# input
       SURFAR = CONVAR !# surface area for convection, m2 (from GEOM)
       TENV = TA !# fluid temperature (?C)

       !# run subroutine
       CALL CONV(TS, TENV, SHAPE, SURFAR, FLTYPE, FURTST, D, TFA, 
     &  VEL, ZFUR, BP, ELEV, CONVout)

       QCONV = CONVout(1) !# convective heat loss (W)
       HC = CONVout(2) !# combined convection coefficient
       HCFREE = CONVout(3) !# free convection coefficient
       HCFOR = CONVout(4) !# forced convection coefficient
       HD = CONVout(5) !# mass transfer coefficient
       HDFREE = CONVout(6) !# free mass transfer coefficient
       HDFORC = CONVout(7) !# forced mass transfer coefficient
       ANU = CONVout(8) !# Nusselt number (-)
       RE = CONVout(9) !# Reynold's number (-)
       GR = CONVout(10) !# Grasshof number (-)
       PR = CONVout(11) !# Prandlt number (-)
       RA = CONVout(12) !# Rayleigh number (-)
       SC = CONVout(13) !# Schmidt number (-)
       BP = CONVout(14) !# barometric pressure (Pa)
 
       !# reference configuration factors
       FABUSHREF = FABUSH !# nearby bush
       FATOBJREF = FATOBJ !# nearby object
       FASKYREF = FASKY !# sky
       FAGRDREF = FAGRD !# ground
       FAVEGREF = FAVEG !# vegetation

       !### SIMULSOL, simultaneous solution of heat balance
       !# repeat for each side, dorsal and ventral, of the animal

       DO 1, S=1,2
        !# set infrared environment
        TVEG = TAREF !# assume vegetation casting shade is at 1.2 m (reference) air temperature (?C)
        TLOWER = TGRD
        !# Calculating solar intensity entering fur. This will depend on whether we are calculating the fur temperature for the dorsal side or the ventral side. The dorsal side will have solar inputs from the direct beam hitting the silhouette area as well as diffuse solar scattered from the sky and objects. The ventral side will have diffuse solar scattered off the substrate.
        !# Resetting config factors and solar depending on whether the dorsal side (S=1) or ventral side (S=2) is being estimated.
        IF(QSOLAR.GT.0.0)THEN
         if(S==1)THEN
          FASKY = FASKYREF/(FASKYREF+FATOBJREF+FAVEGREF)
          FATOBJ = FATOBJREF/(FASKYREF+FATOBJREF+FAVEGREF)
          FAVEG = FAVEGREF/(FASKYREF+FATOBJREF+FAVEGREF)
          FAGRD = 0.0
          FABUSH = 0.0
          if(FATOBJ == 0.0)THEN
           QSLR = 2.*QSDIR+((QSSKY/FASKYREF)*FASKY)
          else
           QSLR = 2.*QSDIR+((QSSKY/FASKYREF)*FASKY)+((QSOBJ/
     &      FATOBJREF)*FATOBJ)
          ENDIF
         else
          FASKY = 0.0
          FATOBJ = 0.0
          FAVEG = 0.0
          FAGRD = FAGRDREF/(1. - FAGRDREF - FATOBJREF - FABUSHREF)
          FABUSH = FABUSHREF/(1. - FAGRDREF - FATOBJREF - FABUSHREF)
          QSLR = (QVENTR/(1. - FASKYREF - FATOBJREF - FAVEGREF))*
     &     (1.-(2.*PCOND)) ! NB edit - adjust for PCOND
         ENDIF
        else
         QSLR = 0.0
         if(S==1)then
          FASKY = FASKYREF/(FASKYREF+FATOBJREF+FAVEGREF)
          FATOBJ = FATOBJREF/(FASKYREF+FATOBJREF+FAVEGREF)
          FAVEG = FAVEGREF/(FASKYREF+FATOBJREF+FAVEGREF)
          FAGRD = 0.0
          FABUSH = 0.0
         else
          FASKY = 0.0
          FATOBJ = 0.0
          FAVEG = 0.0
          FAGRD = FAGRDREF/(1. - FAGRDREF - FATOBJREF - FAVEGREF)
          FABUSH = FABUSHREF/(1. - FAGRDREF - FATOBJREF - FAVEGREF)
         ENDIF
        ENDIF

        !# set fur depth and conductivity
        !# index for KEFARA, the conductivity, is the average (1), front/dorsal (2), back/ventral(3) of the body part
        if((QSOLR.GT.0).OR.(ZZFUR(2).NE.ZZFUR(3)))THEN
         if(S == 1)THEN
          ZL = ZZFUR(2)
          KEFF = KEFARA(2)
         else
          ZL = ZZFUR(3)
          KEFF = KEFARA(3)
         ENDIF
        else
         ZL = ZZFUR(1)
         KEFF = KEFARA(1)
        ENDIF

        RDXDEP = 1. !# not used yet - relates to radiation through fur
        XR = RDXDEP !# not used yet - relates to radiation through fur
        X = RDXDEP !# not used yet - relates to radiation through fur
        RSKIN = R1 !# body radius (including fat), m
        RFLESH = R1 - FATTHK !# body radius flesh only (no fat), m
        RFUR = R1 + ZL !# body radius including fur, m
        D = 2. * RFUR !# diameter, m
        RRAD = RSKIN + (XR * ZL) !# effective radiation radius, m
        LEN = ALENTH !# length, m

        !# Correcting volume to account for subcutaneous fat
        if((SUBQFAT.EQ.1.).AND.(FATTHK.GT.0.0))THEN
         VOL = FLSHVL
        ENDIF

        !# Calculating the "Cd" variable: Qcond = Cd(Tskin-Tsub), where Cd = Conduction area*((kfur/zfur)+(ksub/subdepth))
        IF(S==2)THEN ! doing ventral side, add conduction
         AREACND = ATOT * (PCOND *2)
         CD = AREACND * ((KFURCMPRS/ZFURCOMP))
         CONVAR = CONVAR - AREACND ! #NB edit - Adjust area used for convection to account for PCOND. This is sent in to simulsol & used for CONV, RAD
        ELSE  ! #doing dorsal side, no conduction. No need to adjust areas used for convection. 
         AREACND = 0
         CD = AREACND * ((KFURCMPRS/ZFURCOMP))
        ENDIF

        !# package up inputs
        FURVARS = (/LEN,ZFUR,FURTHRMK,KEFF,BETARA,FURTST,ZL/)
        GEOMVARS = (/SHAPE,SUBQFAT,CONVAR,VOL,D,CONVAR,CONVSK,RFUR,
     &   RFLESH,RSKIN,XR,RRAD,ASEMAJ,BSEMIN,CSEMIN,CD/)
        ENVVARS = (/FLTYPE,TA,TS,TBUSH,TVEG,TLOWER,TSKY,TCONDSB,RH,
     &   VEL,BP,ELEV,FASKY,FABUSH,FAVEG,FAGRD,QSLR/)
        TRAITS = (/TC,AK1,AK2,EMISAN,FATTHK,FLYHR,FURWET,PCTBAREVAP,
     &   PCTEYES/)

        !# set IPT, the geometry assumed in SIMULSOL: 1 = cylinder, 2 = sphere, 3 = ellipsoid
        if((SHAPE.eq.1.).or.(SHAPE.eq.3.).or.(SHAPE.eq.5.))THEN
         IPT = 1.
        ENDIF
        if(SHAPE.eq.2.)THEN
         IPT = 2.
        ENDIF
        If(SHAPE.eq.4.)THEN
         IPT = 3.
        ENDIF

        !# call SIMULSOL
        CALL SIMULSOL(DIFTOL, IPT, FURVARS, GEOMVARS, ENVVARS, TRAITS,
     &   TFA, SKINW, TS, SIMULOUT)
        SIMULSOLout(S,:) = SIMULOUT
1      CONTINUE
      
       TSKINMAX=max(SIMULSOLout(1,2), SIMULSOLout(2,2))
      
       !### ZBRENT and RESPFUN

       !# Now compute a weighted mean heat generation for all the parts/components = (dorsal value *(FASKY+FAVEG+FATOBJ))+(ventral value*FAGRD)
       GEND = SIMULSOLout(1, 5)
       GENV = SIMULSOLout(2, 5)
       DMULT = FASKYREF + FAVEGREF + FATOBJ
       VMULT = 1. - DMULT !# Assume that reflectivity of veg below = ref of soil so VMULT left as 1 - DMULT
       X = GEND * DMULT + GENV * VMULT !# weighted estimate of metabolic heat generation

       !# reset configuration factors
       FABUSH = FABUSHREF !# nearby bush
       FATOBJ = FATOBJREF !# nearby object
       FASKY = FASKYREF !# sky
       FAGRD = FAGRDREF !# ground
       FAVEG = FAVEGREF !# vegetation

       !# lung temperature and temperature of exhaled air
       TLUNG =(TC + (SIMULSOLout(1, 2) + SIMULSOLout(2, 2)) * 0.5) * 0.5 !# average of skin and core
       TAEXIT = min(TA + DELTAR, TLUNG) !# temperature of exhaled air, ?C

       !# now guess for metabolic rate that balances the heat budget while allowing metabolic rate
       !# to remain at or above QBASAL, via 'shooting method' ZBRENT
       QMIN = QBASAL
       IF((TA.LT.TC).AND.(TSKINMAX.LT.TC))THEN
        QM1 = QBASAL * 2.* (-1.)
        QM2 = QBASAL * 50.
       ELSE
        QM1 = QBASAL * 50.* (-1.)
        QM2 = QBASAL * 2.
       ENDIF

       QSUM = X
       TOL = AMASS * 0.01
       ZBRENTin = (/TA, O2GAS, N2GAS, CO2GAS, BP, QMIN, RQ, TLUNG,
     &  GMASS, EXTREF, RH, RELXIT, TIMACT, TAEXIT, QSUM, PANT/)
      
       !# call ZBRENT subroutine which calls RESPFUN
       CALL ZBRENT(QM1, QM2, TOL, ZBRENTin, ZBRENTout)
       !colnames(ZBRENTout) = c("RESPFN","QRESP","GEVAP", "PCTO2", "PCTN2", "PCTCO2", "RESPGEN", "O2STP", "O2MOL1", "N2MOL1", "AIRML1", "O2MOL2", "N2MOL2", "AIRML2", "AIRVOL")

       QGEN = ZBRENTout(7)
       SHAPEB_LAST = SHAPEB
       AK1LAST = AK1
       TCLAST = TC
       PANTLAST = PANT
       SKINWLAST = SKINW
       if(SHAPEB.lt.SHAPEB_MAX)THEN
        SHAPEB = SHAPEB + UNCURL
       else
        SHAPEB = SHAPEB_MAX
        if(AK1.lt.AKMAX)THEN
         AK1 = AK1 + AK1inc
        else
         AK1 = AKMAX
         if(TC.lt.TCMAX)THEN
          TC = TC + RAISETC
          Q10mult = Q10**((TC - TCREF)/10.)
          QBASAL = QBASREF * Q10mult
         else
          TC = TCMAX
          Q10mult = Q10**((TC - TCREF)/10.)
          QBASAL = QBASREF * Q10mult
          if(PANT.lt.PANTMAX)THEN
           !#PANT = PANT + PANTING
           !PANTSTEP = PANTSTEP + 1
           PANT = PANT + PANTING
           !PANT = PANTMAX - (PANTMAX - 1) * exp(-0.01 / (PANTMAX / 10.) * PANTSTEP)
           !PANTTEST = FLOAT(INT(PANT * 1000.0 + 0.5)) / 1000.0
           !# if(PANT > PANTMAX / 10)THEN
           !#   SKINW = SKINW + SWEAT
           !#   if(SKINW > MXWET | SWEAT == 0)THEN
           !#     SKINW = MXWET
           !#   ENDIF
           !# ENDIF
          else
           PANT = PANTMAX
           SKINW = SKINW + SWEAT
           if((SKINW.GT.MXWET).OR.(SWEAT.eq.0.))THEN
            SKINW = MXWET
            RETURN
           ENDIF
          ENDIF
         ENDIF
        ENDIF
       ENDIF
      END DO
      
      ! SIMULSOL output, dorsal
      TFAD=SIMULSOLout(1, 1) ! temperature of feathers/fur-air interface, deg C
      TSKCALCAVD=SIMULSOLout(1, 2) ! averagek skin temperature, deg C
      QCONVD=SIMULSOLout(1, 3) ! convection, W
      QCONDD=SIMULSOLout(1, 4) ! conduction, W
      QGENNETD=SIMULSOLout(1, 5) ! heat generation from flesh, W
      QSEVAPD=SIMULSOLout(1, 6) ! cutaneous evaporative heat loss, W
      QRADD=SIMULSOLout(1, 7) ! radiation lost at fur/feathers/bare skin, W
      QSLRD=SIMULSOLout(1, 8) ! solar radiation, W
      QRSKYD=SIMULSOLout(1, 9) ! sky radiation, W
      QRBSHD=SIMULSOLout(1, 10) ! bush/object radiation, W
      QRVEGD=SIMULSOLout(1, 11) ! overhead vegetation radiation (shade), W
      QRGRDD=SIMULSOLout(1, 12) ! ground radiation, W
      QFSEVAPD=SIMULSOLout(1, 13) ! fur evaporative heat loss, W
      NTRYD=SIMULSOLout(1, 14) ! solution attempts, #
      SUCCESSD=SIMULSOLout(1, 15) ! successful solution found? (0 no, 1 yes)

      ! SIMULSOL output, ventral
      TFAV=SIMULSOLout(2, 1) ! temperature of feathers/fur-air interface, deg C
      TSKCALCAVV=SIMULSOLout(2, 2) ! averagek skin temperature, deg C
      QCONVV=SIMULSOLout(2, 3) ! convection, W
      QCONDV=SIMULSOLout(2, 4) ! conduction, W
      QGENNETV=SIMULSOLout(2, 5) ! heat generation from flesh, W
      QSEVAPV=SIMULSOLout(2, 6) ! cutaneous evaporative heat loss, W
      QRADV=SIMULSOLout(2, 7) ! radiation lost at fur/feathers/bare skin, W
      QSLRV=SIMULSOLout(2, 8) ! solar radiation, W
      QRSKYV=SIMULSOLout(2, 9) ! sky radiation, W
      QRBSHV=SIMULSOLout(2, 10) ! bush/object radiation, W
      QRVEGV=SIMULSOLout(2, 11) ! overhead vegetation radiation (shade), W
      QRGRDV=SIMULSOLout(2, 12) ! ground radiation, W
      QFSEVAPV=SIMULSOLout(2, 13) ! fur evaporative heat loss, W
      NTRYV=SIMULSOLout(2, 14) ! solution attempts, #
      SUCCESSV=SIMULSOLout(2, 15) ! successful solution found? (0 no, 1 yes)

      RESPFN=ZBRENTout(1) ! heat sum (should be near zero), W
      QRESP=ZBRENTout(2) ! respiratory heat loss, W
      GEVAP=ZBRENTout(3) ! respiratory evaporation (g/s)
      PCTO2=ZBRENTout(4) ! O2 concentration (%)
      PCTN2=ZBRENTout(5) ! N2 concentration (%)
      PCTCO2=ZBRENTout(6) ! CO2 concentration (%)
      RESPGEN=ZBRENTout(7) ! metabolic heat (W)
      O2STP=ZBRENTout(8) ! O2 in rate at STP (L/s)
      O2MOL1=ZBRENTout(9) ! O2 in (mol/s)
      N2MOL1=ZBRENTout(10) ! N2 in (mol/s)
      AIRML1=ZBRENTout(11) ! air in (mol/s)
      O2MOL2=ZBRENTout(12) ! O2 out (mol/s)
      N2MOL2=ZBRENTout(13) ! N2 out (mol/s)
      AIRML2=ZBRENTout(14) ! air out (mol/s)
      AIRVOL=ZBRENTout(15) ! air out at STP (L/s)

      HTOVPR = 2.5012E+06 - 2.3787E+03 * TA
      SWEATGS = (SIMULSOLout(1,6) + SIMULSOLout(2,6)) * 0.5 
     &  / HTOVPR * 1000
      EVAPGS = ZBRENTout(3) + SWEATGS

      HTOVPR=2.5012E+06 - 2.3787E+03 * TA ! latent heat of vapourisation, W/kg/C
      SWEATGS=(QSEVAPD + QSEVAPV) * 0.5 / HTOVPR * 1000 ! water lost from skin, g/s
      EVAPGS=GEVAP + SWEATGS ! total evaporative water loss, g/s
      sigma=5.6697E-8
      QIR=QIRIN - QIROUT
      QIROUTD=sigma * EMISAN * AREASKIN * (TSKCALCAVD + 273.15)**4
      QIRIND=QRADD * (-1.) + QIROUTD
      QIROUTV=sigma * EMISAN * AREASKIN * (TSKCALCAVD + 273.15)**4
      QIRINV=QRADV * (-1.) + QIROUTV

      QSOL=QSLRD * DMULT + QSLRV * VMULT ! solar, W
      QIRIN=QIRIND * DMULT + QIRINV * VMULT ! infrared in, W
      QMET=RESPGEN ! metabolism, W
      QEVAP=QSEVAPD * DMULT + QSEVAPV * VMULT + QFSEVAPD * DMULT + 
     & QFSEVAPV * VMULT + QRESP ! evaporation, W
      QIROUT=QIROUTD * DMULT + QIROUTV * VMULT ! infrared out, W
      QCONV=QCONVD * DMULT + QCONVV * VMULT ! convection, W
      QCOND=QCONDD * DMULT + QCONDV * VMULT ! conduction, W

      TREG=(/TC, TLUNG, TSKCALCAVD, TSKCALCAVV, TFAD, TFAV, SHAPEB, 
     & PANT, SKINW, AK1, KEFARA(1), KEFARA(2), KEFARA(3), KFURCMPRS, 
     & Q10mult/)
      !names(treg)=c("TC", "TLUNG", "TSKIN_D", "TSKIN_V", "TFA_D", "TFA_V", "SHAPEB", "PANT", "SKINWET", "K_FLESH", "K_FUR", "K_FUR_D", "K_FUR_V", "K_COMPFUR", "Q10")

      MORPH=(/ATOT, VOL, D, MASFAT, FATTHK, FLSHVL, ALENTH, AWIDTH, 
     & AHEIT, R1, R2, ASIL, ASILN, ASILP, AREASKIN, CONVSK, CONVAR, 
     & AREACND, FASKY, FAGRD/)
      !names(morph)=c("AREA", "VOLUME", "CHAR_DIM", "MASS_FAT", "FAT_THICK", "FLESH_VOL", "LENGHT", "WIDTH", "HEIGHT", "DIAM_FLESH", "DIAM_FUR", "AREA_SIL", "AREA_SILN", "AREA_ASILP", "AREA_SKIN", "AREA_SKIN_EVAP", "AREA_CONV", "F_SKY", "F_GROUND")
      
      ENBAL=(/QSOL, QIRIN, QMET, QEVAP, QIROUT, QCONV, QCOND, RESPFN, 
     & max(NTRYD, NTRYV), min(SUCCESSD, SUCCESSV)/)
      !names(enbal)=c("QSOL", "QIRIN", "QMET", "QEVAP", "QIROUT", "QCONV", "QCOND", "ENB", "NTRY", "SUCCESS")

      MASBAL=(/AIRVOL, O2STP, GEVAP, SWEATGS, O2MOL1, 
     & O2MOL2, N2MOL1, N2MOL2, AIRML1, AIRML2/) * 3600
      !names(masbal)=c("AIR_L", "O2_L", "H2OResp_g", "H2OCut_g", "O2_mol_in", "O2_mol_out", "N2_mol_in", "N2_mol_out", "AIR_mol_in", "AIR_mol_out")

      RETURN
      END
```