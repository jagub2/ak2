#!/bin/bash
cat test.txt | ./program > wynik.txt
if [ "$(diff wynik.txt wzor.txt)" == "" ]; then
    echo "Test zakonczyl sie powodzeniem"
else
    echo "Test NIE zakonczyl sie powodzeniem";
fi
