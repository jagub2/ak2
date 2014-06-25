#!/bin/bash
TESTY=(
	$(./program 0.001 1000 0.001 | tail -n 1 | awk 'NF>1{print $NF}')
	$(echo 0.001 1000 0.001 | ./program | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 100 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 10 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 1 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.1 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.01 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.0001 | tail -n 1 | awk 'NF>1{print $NF}')
)

WYNIKI=(
	13.776099
	13.776099
	4.361701
	6.578142
	8.867340
	11.125427
	13.053598
	13.223969
)

OPISY=(
	"przekazywanie wartosci jako argumenty programu"
	"przekazywanie wartosci bezposrednio do programu"
	"calke 1/x dx 0.001..1000, krok 100"
	"calke 1/x dx 0.001..1000, krok 10"
	"calke 1/x dx 0.001..1000, krok 1"
	"calke 1/x dx 0.001..1000, krok 0.1"
	"calke 1/x dx 0.001..1000, krok 0.01"
	"calke 1/x dx 0.001..1000, krok 0.001"
	"calke 1/x dx 0.001..1000, krok 0.0001"
)

echo "Testy 1 & 2 sprawdzaja calke 1/x dx 0.001..1000, krok 0.001"
for i in ${!TESTY[*]}; do
    echo -n "Testuje ${OPISY[$i]}..."
    if [ ${TESTY[$i]} == ${WYNIKI[$i]} ]; then
        echo "SUKCES"
    else
        echo "PORAZKA"
    fi
done

