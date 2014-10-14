#!/bin/bash

rm -f coffee/*~
rm -f js/Game.js
coffee --output js/ --join Game.js --compile coffee/*.coffee 
