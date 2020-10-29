#!/usr/bin/env bash

DATA_DIR=./cnndm/processed
USER_DIR=./prophetnet
ARCH=ngram_transformer_prophet_large
CRITERION=ngram_language_loss
SAVE_DIR=./cnndm/finetune_cnndm_checkpoints
TENSORBOARD_LOGDIR=./cnndm/finetune_cnndm_tensorboard
PRETRAINED_MODEL=../downloads/prophetnet_large_pretrained_160G_14epoch_model.pt

fairseq-train \
--user-dir $USER_DIR --task translation_prophetnet --arch $ARCH \
--optimizer adam --adam-betas '(0.9, 0.999)' --clip-norm 0.1 \
--lr 0.0001 \
--lr-scheduler inverse_sqrt --warmup-init-lr 1e-07 --warmup-updates 1000 \
--dropout 0.1 --attention-dropout 0.1 --weight-decay 0.01 \
--criterion $CRITERION --label-smoothing 0.1 \
--update-freq 32  --max-sentences 2 \
--num-workers 4 \
--load-from-pretrained-model $PRETRAINED_MODEL \
--load-sep \
--ddp-backend=no_c10d --max-epoch 10 \
--max-source-positions 512 --max-target-positions 512 \
--skip-invalid-size-inputs-valid-test \
--seed 1 \
--save-dir $SAVE_DIR \
--keep-last-epochs 10 \
--tensorboard-logdir $TENSORBOARD_LOGDIR \
$DATA_DIR
