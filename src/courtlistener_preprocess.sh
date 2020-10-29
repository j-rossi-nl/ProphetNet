#!/usr/bin/env bash

#python courtlistener/preprocess_courtlistener.py \
#&& \
fairseq-preprocess \
--user-dir ./prophetnet \
--task translation_prophetnet \
--source-lang src --target-lang tgt \
--testpref ./courtlistener/courtlistener_tokenized/test \
--destdir ./courtlistener/processed --srcdict ./vocab.txt --tgtdict ./vocab.txt \
--workers 20
