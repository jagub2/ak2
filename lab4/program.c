#include <stdio.h>
double calka(double, double, double);
void set_fpu(unsigned short);
unsigned short get_fpu();

int main(int argc, char*argv[]) {
    double start, koniec, krok, wynik;
    unsigned short precyzja, zaokraglenie, fpucw;
    fpucw = 0;
    wynik = 0;
    if(argc < 6) {
        printf("Podaj: wartosc poczatkowa, koncowa, krok, precyzje i tryb zaokraglenia:\n"
                "precyzja:\n"
                "0 - pojedyncza precyzja\n"
                "1 - podwojna precyzja\n"
                "2 - rozszerzona podwojna precyzja (domyslnie)\n"
                "tryb zaokraglenia:\n"
                "0 - zaokraglij do najblizszej (domyslnie)\n"
                "1 - zaokraglij w dol\n"
                "2 - zaokraglij w gore\n"
                "3 - zaokraglij do zera\n");
        scanf("%lf %lf %lf %hu %hu", &start, &koniec, &krok, &precyzja, &zaokraglenie);
    } else {
        sscanf(argv[1], "%lf", &start);
        sscanf(argv[2], "%lf", &koniec);
        sscanf(argv[3], "%lf", &krok);
        sscanf(argv[4], "%hu", &precyzja);
        sscanf(argv[5], "%hu", &zaokraglenie);
    }
    fpucw = get_fpu(); // pobierz stare flagi
    printf("control word:\nbyl: %04x; ", fpucw);
    // wyliczenie odpowiedniej wartosci control word, na podstawie precyzji i zaokraglenia
    if(precyzja > 2) precyzja = 2; // jezeli precyzja > 2, to ustaw domyslna (rozszerzona podwojna)
    if(zaokraglenie > 3) zaokraglenie = 0; // jesli zaokraglenie > 3, to ustaw domyslne (do najblizszej)
    if(precyzja > 0) ++precyzja; // ustaw odpowiednia wartosc dla flagi precyzji (w uzyciu jest 0, 2, 3)
    precyzja <<= 8; // przesun precyzje na odpowiednie miejsce
    zaokraglenie <<= 10; // tak samo tryb zaokraglenia
    fpucw = 0x7f; // ustaw inne flagi (na podstawie wartosci domyslnej)
    fpucw |= precyzja; // dolacz nowe flagi
    fpucw |= zaokraglenie;
    set_fpu(fpucw); // ustaw nowe
    fpucw = get_fpu(); // pobierz nowe
    printf("jest: %04x\n", fpucw);

    wynik = calka(start, koniec, krok); // oblicz calke
    printf("int 1/x dx %lf..%lf = %lf\n", start, koniec, wynik);

    return 0;
}
