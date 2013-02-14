#!/bin/bash

rm -f coffee/*~
coffee --output js/ --join Game.js --compile coffee/*.coffee 
