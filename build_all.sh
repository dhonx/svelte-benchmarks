#!/usr/bin/env bash

cd './big-table' && npm run build;
cd ..

cd './dbmon' && npm run build;
cd ..

cd './uptime' && npm run build;
cd ..

cd './svg' && npm run build;
cd ..