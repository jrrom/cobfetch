#!/bin/bash

mkdir -p dist
cobc -x cobfetch.cbl cobweb-pipes.cob pipe-run.cbl -o dist/cobfetch