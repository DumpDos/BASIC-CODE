100 '*Boudy auteur DEMODIA(module N°3 d'un serveur monovoie) pour l'EPI
110 CLS:COLOR 2,0:LOCATE 8,1:PRINT "Mode (E)ssai ou (N)ormal :"
120 RU$=INKEY$
130 IF RU$ <> "E" AND RU$ <> "e" AND RU$ <> "n" AND RU$ <> "N" THEN
120
140 '--------------Date et ouverture du fichier communication-------------
150 CLS:KEY OFF
160 DATF$=MID$(DATE$,4,3)+LEFT$(DATE$,2)+RIGHT$(DATE$,5)
170 A$="":M$="":P$="":C$="":CLOSE:OPEN "com1:1200,E,7,1,RS,DS,CD" AS #1
180 '---------Attributs videotexte et ACCENTS -tailles caractères-------------
190 EC$=CHR$(25)+CHR$(67)+CHR$(101):'E Accent circonflexe
200 ET$=CHR$(25)+CHR$(72)+CHR$(101):'E Trema
210 IC$=CHR$(25)+CHR$(67)+CHR$(105):'I Accent circonflexe
220 IT$=CHR$(25)+CHR$(72)+CHR$(105):'I Trema
230 EA$=CHR$(25)+CHR$(66)+CHR$(101):'E Accent aigu
240 EG$=CHR$(25)+CHR$(65)+CHR$(101):'E Accent grave
250 AA$=CHR$(25)+CHR$(65)+CHR$(97) :'A Accent
260 CLI$=CHR$(27)+CHR$(72):'Clignotement
270 IV$=CHR$(27)+CHR$(93):'Inverse vidéo
280 DL$=CHR$(27)+CHR$(78):'Double largeur
290 DH$=CHR$(27)+CHR$(77):'Double hauteur
300 DB$=CHR$(27)+CHR$(79):'Double taille
310 RT$=CHR$(15):'Retour au vidéotexte précédent
320 ON ERROR GOTO 1030
330 IF RU$="e" OR RU$="E" THEN 450
340 '---------------Détection de sonnerie----port 1022 de la RS232--------
350 COLOR 2,0:PRINT"SERVEUR EN FONCTIONNEMENT"
360 AP=AP+1: PRINT"NOMBRE D'APPELS=";AP:PRINT"valeur du port 1022=";INP(1022)
370 A=INP(1022) :IF A=0 OR A=160 THEN 370
380 '-----Temporisation pour réception code sonnerie et touche du MINITEL---
390 W=5:GOSUB 840:'temporisation
400 PRINT #1,CHR$(27);"9";"o":PRINT #1,CHR$(27);"9";"h":'connexion
410 GOSUB 780:'temporisation pour saisie
420 'A$=INPUT$(1,#1)
430 W=5:GOSUB 840:'temporisation 40 GOSUB 780:'temporisation pour saisie
450 '------------DIALOGUE EN DIRECT(module N°3 du serveur)--------------
460 LOCATE 15,15:COLOR 18,0:PRINT"ATTENTION DIALOGUE EN DIRECT----> Appuyez sur une touche"
470 'W=7:GOSUB 30520:'temporisation
480 GOSUB 730:X=4:Y=1:GOSUB 740:PRINT#1,DH$+"INTERROGATION INTERLOCUTEUR MINITEL EN COURS..."
490 'W=5:GOSUB 30520:'temporisation
500 'PLAY"MB CD EFG"
510 PLAY"O3 L4 C L2 EE L8 E L4 EE D C F L1 L4"
520 FOR I=1 TO 100:BEEP
530 IF INKEY$<>"" THEN 560 ELSE NEXT
540 GOSUB 730
550 PRINT#1,CLI$;"DESOLE IL N'Y A PERSONNE !......... AU REVOIR*******>" :CLS:PRINT"essai terminé,relançez le programme":COLOR 2,0:CLS:GOTO 170
      560 A$="":GOSUB 730:X=5:Y=5:GOSUB 740:PRINT#1,"BONJOUR ! C'EST LE ";DATF$;" DEBUT DIALOGUE*******> A VOUS":GOSUB 790:GOSUB 820
570 '-------------Editeur de texte MINITEL élémentaire-------------------
580 Y=5:X=9
590 GOSUB 750:GOSUB 780
600 IF X=20 THEN GOSUB 730:GOTO 560
610 IF ASC(A$)=19 THEN GOSUB 890
620 IF A$="#" THEN COLOR 2,0:CLS:PRINT"ESSAI terminé RELANCER LE Programme":COLOR 2,0:CLS :END
630 DIA$=DIA$+A$:GOSUB 740:PRINT#1,DIA$;
640 IF RIGHT$(DIA$,1)<> "*" THEN 590
650 IF RIGHT$(DIA$,1)="*" THEN CLS:COLOR 2,0:PRINT DIA$:DIA$=""
660 INPUT "DIALOGUE:";ODIA$:DI=LEN(ODIA$):A$="":FOR I=1 TO DI:A$=MID$(ODIA$,I,1):GOSUB 940:ODIALO$=ODIALO$+A$:A$="":NEXT I
670 X=X+2:GOSUB 740:PRINT#1,ODIALO$;"*******>";"A VOUS....":FOR I=1 TO 10:PRINT#1,CHR$(7):NEXT:GOSUB 740:X=X+2:Y=1:ODIALO$=""
680 IF X=>20 THEN X=1:GOSUB 730:GOTO 560
690 COLOR 2,0:CLS
700 GOTO 590
710 RESUME
720 '--------------Routines MINITEL---------------------------------
730 PRINT #1,CHR$(12):RETURN:'nettoyage écran
740 PRINT#1,CHR$(31);CHR$(X+64);CHR$(Y+64);:RETURN:'équivalent locate gwbasic
750 PRINT#1,CHR$(31);:RETURN:'Mise du curseur à 0
760 FOR I=1 TO 100:PRINT I:X=20:Y=12:GOSUB 740:PRINT#1,"Patientez..":NEXT:RETURN:'temporisation affichage
770 IF ASC(A$)=19 THEN PRINT#1,"Touche interdite!..":RETURN:'erreur de frappe
780 W=10:TE!=TIMER:WHILE TIMER<TE!+W :IF EOF(1) THEN WEND:GOTO 870:ELSE A$=INPUT$(1,#1):RETURN:'temporisation dans la saisie des données et commande de déconnexion ou retour au menu
790 X=20:Y=14:GOSUB 740:PRINT#1,"Pour achever";IV$;" Appuyer sur *":RETURN
800 X=21:Y=14:GOSUB 740:PRINT#1,"Pour Corriger Appuyer sur # ":RETURN
810 X=22:Y=19:GOSUB 740:PRINT#1,"Pour continuer SUITE":RETURN
820 X=21:Y=2:GOSUB 740:PRINT#1,"Pour revenir au Menu";IV$;"SOMMAIRE":RETURN
830 X=23:Y=15:GOSUB 740:PRINT#1,"Pour corriger CORRECTION":RETURN
840 TE!=TIMER :'Temporisation
850 WHILE TIMER<TE!+W:WEND:'Temporisation
860 W=0:PRINT"TEMPORISATION REALISEE":RETURN:'Temporisation
870 PRINT#1,CHR$(27);"9";"g":CLOSE:GOTO 170 :'déconnexion
880 '----------------------Test pour les touches:--------- ENVOI(A),SUITE(H)-RETOUR(B)-CORRECTION(G)-GUIDE(D)-SOMMAIRE(F)-ANNULATION(E)-REPETITION(C)-CONNEXION-FIN(I)
890 GOSUB 780
900 IF A$="A" OR A$="H" OR A$="B" OR A$="G" OR A$="C" OR A$="D" OR A$="I" THEN GOSUB 770:GOTO 560
910 IF A$="F" THEN 560
920 RETURN
930 '-----------------Lecture des accents pour le MINITEL----------------
940 IF A$="é" THEN A$=EA$
950 IF A$="ê" THEN A$=EC$
960 IF A$="ë" THEN A$=ET$
970 IF A$="è" THEN A$=EG$
980 IF A$="î" THEN A$=IC$
990 IF A$="ï" THEN A$=IT$
1000 IF A$="ô" THEN A$=OC$
1010 IF A$="à" THEN A$=AA$
1020 RETURN
1030 RESUME
