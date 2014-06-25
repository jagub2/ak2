program:
    Program sluzy do dodawania liczb zapisanych w zapisie heksadecymalnym, poprzedzonych przedrostkiem (0x), program zaklada, ze wprowadzone liczby sa poprawne. Liczby z przedzialu <10-15> - w heksie to A-F - musza byc wpisane jako WIELKIE litery; gdy program napotka na znak inny niz dozwolony ([0-9A-F]), to przeskakuje na koniec programu. Aby zakonczyc wczytywanie liczb, nalezy wcisnac tylko enter, bez dodatkowych znakow.
    W %r15 znajduje sie tymczasowa wartosc aktualnej liczby, w %r13 jest starsza czesc sumy, a w %r14 mlodsza. Wynik na te chwile mozna obejrzec w gdb.

