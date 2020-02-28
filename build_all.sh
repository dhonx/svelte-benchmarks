#!/usr/bin/env bash

cd 'big-table' && npm run build;
cd ..
cp -r big-table/public builds/big-table

cd 'dbmon' && npm run build;
cd ..
cp -r dbmon/public builds/dbmon

cd 'uptime' && npm run build;
cd ..
cp -r uptime/public builds/uptime

cd 'svg' && npm run build;
cd ..
cp -r svg/public builds/svg
