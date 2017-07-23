100 '*Boudy auteur DEMODIA(module N°3 d'un serveur monovoie) pour
l'EPI
110 CLS:COLOR 2,0:LOCATE 8,1:PRINT "Mode (E)ssai ou (N)ormal :"
120 RU$=INKEY$
130 IF RU$ <> "E" AND RU$ <> "e" AND RU$ <> "n" AND RU$ <> "N" THEN
120
140 '--------------Date et ouverture du fichier communication---------
----
150 CLS:KEY OFF
160 DATF$=MID$(DATE$,4,3)+LEFT$(DATE$,2)+RIGHT$(DATE$,5)
170 A$="":M$="":P$="":C$="":CLOSE:OPEN "com1:1200,E,7,1,RS,DS,CD" AS
#1
180 '---------Attributs videotexte et ACCENTS -tailles caractères-----
--------
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
340 '---------------Détection de sonnerie----port 1022 de la RS232----
----
350 COLOR 2,0:PRINT"SERVEUR EN FONCTIONNEMENT"
360 AP=AP+1: PRINT"NOMBRE D'APPELS=";AP:PRINT"valeur du port
1022=";INP(1022)
370 A=INP(1022) :IF A=0 OR A=160 THEN 370
380 '-----Temporisation pour réception code sonnerie et touche du
MINITEL---
390 W=5:GOSUB 840:'temporisation
400 PRINT #1,CHR$(27);"9";"o":PRINT #1,CHR$(27);"9";"h":'connexion
410 GOSUB 780:'temporisation pour saisie
420 'A$=INPUT$(1,#1)
430 W=5:GOSUB 840:'temporisation
