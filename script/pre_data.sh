#!/bin/sh

set -e

s=en
t=zh
lp=${s}-${t}
data_dir=../data/${lp}
model_dir=../model/${lp}
moses_decoder=../requirements/mosesdecoder-master
subword_nmt=../requirements/subword-nmt


for lang in $s $t; do
  for f in train valid test;do
    perl ${moses_decoder}/scripts/tokenizer/tokenizer.perl -l ${lang} < ${data_dir}/${f}.${lp}.${lang} > ${data_dir}/${f}.${lp}.tok.${lang}

    # 如果是中，额外进行一步分词处理
    if [ ${lang} = zh ];then
      python -m jieba -d " " ${data_dir}/${f}.${lp}.tok.${lang} > ${data_dir}/temp.txt
      mv ${data_dir}/temp.txt ${data_dir}/${f}.${lp}.tok.${lang}
    fi
    
    # bpecode用网上提供的，省得学习
    python ${subword_nmt}/apply_bpe.py -c ${data_dir}/bpecodes.txt < ${data_dir}/${f}.${lp}.tok.${lang} > ${data_dir}/${f}.${lp}.tok.bpe.${lang}
  done
done


PYTHONPATH=../fairseq-0.8.0 python ../fairseq-0.8.0/preprocess.py  --source-lang ${s} --target-lang ${t} \
  --trainpref  ${data_dir}/train.${lp}.tok.bpe  --validpref ${data_dir}/valid.${lp}.tok.bpe  --testpref ${data_dir}/test.${lp}.tok.bpe \
  --destdir ${data_dir}/data-bin --workers 4



