noah@LaptopNoah:~$ ./AufgabeE.sh
grep: lookbehind assertion is not fixed length
grep: lookbehind assertion is not fixed length
Connected to haraldmueller.ch.
220 ProFTPD Server (ProFTPD) [82.195.251.67]
331 Password required for schoolerinvoices
230 User schoolerinvoices logged in
550 /out/AP22bKos: No such file or directory
local: kombinierte_input.csv remote: kombinierte_input.csv
229 Entering Extended Passive Mode (|||64806|)
150 Opening BINARY mode data connection for kombinierte_input.csv
100% |****************************************************************************************|   244        9.69 MiB/s    --:-- ETA
226 Transfer complete
244 bytes sent in 00:00 (58.14 KiB/s)
221 Goodbye.
QR-Rechnungen erfolgreich hochgeladen.

noah@LaptopNoah:~$ cat kombinierte_input.csv
RefNr,Betrag,Name,IBAN
24018,,41301000000012497;CH1889144876152963546;Autoleasing AG;Aareweg 100;5000 Aarau,41010000001234567
24019,,41301000000012497;CH1989144212313785138;Carlo Caprez;Carrosseriestrasse 2;7000 St. Gallen,41010000001234567
noah@LaptopNoah:~$