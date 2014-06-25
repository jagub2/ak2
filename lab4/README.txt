Program ma za zadanie ustawic odpowiednie zaokraglenie oraz precyzje
dzialan, poza tym program liczy calke 1/x dla zadanych wartosci.
Program moze zostac uruchomiony bez argumentow, wtedy zostanie wyswietlone
zapytanie o podanie wartosci poczatkowej, koncowej oraz kroku.
Mozna rowniez uruchomic program z argumentami:
./program WART_POCZATKOWA WART_KONCOWA KROK PRECYZJA TRYB_ZAOKRAGLENIA

precyzja:
0 - pojedyncza precyzja
1 - podwojna precyzja
2 - rozszerzona podwojna precyzja (domyslnie)

tryb zaokraglenia:
0 - zaokraglij do najblizszej (domyslnie)
1 - zaokraglij w dol
2 - zaokraglij w gore
3 - zaokraglij do zera

Wynik dzialania programu bedzie wygladal podobnie (jak widac po CW, wybrano 
domyslne ustawienia precyzji i zaokraglania):

$ ./program 1 10 0.1 2 0
control word:
byl: 037f; jest: 037f
int 1/x dx 1.000000..10.000000 = 2.348409

W zaleznosci od wybranej precyzji i trybu zaokraglania wyniki moga sie
nieznacznie roznic.

Makefile zawiera regule test.

