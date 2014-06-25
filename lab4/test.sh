#!/bin/bash
TESTY=(
	$(echo 0.001 1000 0.001 0 0 | ./program | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 0 1 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 0 2 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 0 3 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 1 0 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 1 1 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 1 2 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 1 3 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 2 0 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 2 1 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 2 2 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 2 3 | tail -n 2 | head -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 100 2 0 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 10 2 0 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 1 2 0 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.1 2 0 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.01 2 0 | tail -n 1 | awk 'NF>1{print $NF}')
	$(./program 0.001 1000 0.001 2 0 | tail -n 1 | awk 'NF>1{print $NF}') 
	$(./program 0.001 1000 0.0001 2 0 | tail -n 1 | awk 'NF>1{print $NF}')
)

WYNIKI=(
	007f
	047f
	087f
	0c7f
	027f
	067f
	0a7f
	0e7f
	037f
	077f
	0b7f
	0f7f
	100002.828953
	10005.177214
	1007.482828
	109.771177
	21.936676
	14.392726
	13.866343
)

OPISY=(
	"CW, proba 1"
	"CW, proba 2"
	"CW, proba 3"
	"CW, proba 4"
	"CW, proba 5"
	"CW, proba 6"
	"CW, proba 7"
	"CW, proba 8"
	"CW, proba 9"
	"CW, proba 10"
	"CW, proba 11"
	"CW, proba 12"
	"wynik liczenia calki: 1/x dx 0.001..1000, krok 100"
	"wynik liczenia calki: 1/x dx 0.001..1000, krok 10"
	"wynik liczenia calki: 1/x dx 0.001..1000, krok 1"
	"wynik liczenia calki: 1/x dx 0.001..1000, krok 0.1"
	"wynik liczenia calki: 1/x dx 0.001..1000, krok 0.01"
	"wynik liczenia calki: 1/x dx 0.001..1000, krok 0.001"
	"wynik liczenia calki: 1/x dx 0.001..1000, krok 0.0001"
)

for i in ${!TESTY[*]}; do
    echo -n "Testuje ${OPISY[$i]}..."
    if [ ${TESTY[$i]} == ${WYNIKI[$i]} ]; then
        echo "SUKCES"
    else
        echo "PORAZKA"
    fi
done

