#!/usr/bin/env bash

SUFFIX=_ck9_pelt1.2_test_beam5
OUTPUT_FILE=courtlistener/output$SUFFIX.txt

grep ^H $OUTPUT_FILE | cut -c 3- | sort -n | cut -f3- | sed "s/ ##//g" > courtlistener/sort_hypo$SUFFIX.txt

python courtlistener/eval/postprocess_courtlistener.py --generated courtlistener/sort_hypo$SUFFIX.txt --export-clean courtlistener/clean.txt
python courtlistener/eval/package_output_courtlistener.py --output courtlistener/clean.txt --index courtlistener/original_data/opinions.idx --parquet .

