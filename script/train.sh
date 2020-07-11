#! /bin/sh

set -e

devices=1
PYTHONPATH=../fairseq-0.8.0 
export CUDA_VISIBLE_DEVICES=${devices} 

s=en
t=zh
lp=${s}-${t}

python ../fairseq-0.8.0/train.py ../data/${lp}/data-bin  \
    --arch transformer --source-lang ${s} --target-lang ${t}  \
    --optimizer adam  --lr 0.001 --min-lr '1e-09' --adam-betas '(0.9, 0.98)' \
    --lr-scheduler inverse_sqrt --max-tokens 4096  --dropout 0.3 \
    --criterion label_smoothed_cross_entropy  --label-smoothing 0.1 \
    --max-update 50000  --warmup-updates 4000 --warmup-init-lr '1e-07' \
    --keep-last-epochs 10 --num-workers 8 --save-dir ../model/${lp} 

