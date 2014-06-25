#include <stdio.h>
float calka(float, float, float);

int main(int argc, char*argv[]) {
    float start, koniec, krok, wynik;
    unsigned long long c_start, c_koniec;
    if(argc < 4) {
        printf("Podaj: wartosc poczatkowa, koncowa, krok:\n");
        scanf("%f %f %f", &start, &koniec, &krok);
    } else {
        sscanf(argv[1], "%f", &start);
        sscanf(argv[2], "%f", &koniec);
        sscanf(argv[3], "%f", &krok);
    }
    __asm__ __volatile__ ("rdtsc" : "=A" (c_start));
    wynik = calka(start, koniec, krok); // oblicz calke
    __asm__ __volatile__ ("rdtsc" : "=A" (c_koniec));
    printf("cykle: %llu\nint 1/x dx %f..%f = %f\n", (c_koniec - c_start), start, koniec, wynik);

    return 0;
}

