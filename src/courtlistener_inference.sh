#!/usr/bin/env bash

SUFFIX=_ck9_pelt1.2_test_beam5
BEAM=5
LENPEN=1.2
CHECK_POINT=cnndm/finetune_cnndm_checkpoints/checkpoint9.pt
OUTPUT_FILE=courtlistener/output$SUFFIX.txt
SCORE_FILE=courtlistener/score$SUFFIX.txt

fairseq-generate courtlistener/processed \
--path $CHECK_POINT \
--user-dir prophetnet \
--task translation_prophetnet \
--batch-size 32 \
--gen-subset test \
--beam $BEAM \
--num-workers 4 \
--min-len 45 \
--max-len-b 110 \
--no-repeat-ngram-size 3 \
--lenpen $LENPEN \
2>&1 > $OUTPUT_FILE \
&& \
grep ^H $OUTPUT_FILE | cut -c 3- | sort -n | cut -f3- | sed "s/ ##//g" > courtlistener/sort_hypo$SUFFIX.txt
