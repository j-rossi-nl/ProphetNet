#!/usr/bin/env bash

python src/cnndm/preprocess_cnn_dm.py

fairseq-preprocess \
--user-dir ./prophetnet \
--task translation_prophetnet \
--source-lang src --target-lang tgt \
--trainpref ./cnndm/prophetnet_tokenized/train --validpref ./cnndm/prophetnet_tokenized/valid --testpref ./cnndm/prophetnet_tokenized/test \
--destdir ./cnndm/processed --srcdict ./vocab.txt --tgtdict ./vocab.txt \
--workers 20
