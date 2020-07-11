#! /bin/sh

set -e

devices=1
PYTHONPATH=../fairseq-0.8.0 
export CUDA_VISIBLE_DEVICES=${devices} 

s=en
t=zh
lp=${s}-${t}


python ../fairseq-0.8.0/generate.py \
      ../data/${lp}/data-bin/  --path ../model/${lp}/checkpoint_best.pt \
      --source-lang ${s} --target-lang ${t} --beam 5 --unkpen 5 \
      --batch-size 512  > temp.txt


# 得到预测句子
grep ^H temp.txt | cut -f3- > temp2.txt

# 去除bpe符号
sed -r 's/(@@ )| (@@ ?$)//g' < temp2.txt  > temp3.txt

# 计算bleu
perl ../requirements/mosesdecoder-master/scripts/generic/multi-bleu.perl data/en-zh/test.en-zh.tok.zh < temp3.txt 


# 提取纯预测文本
perl ../requirements/mosesdecoder-master/scripts/tokenizer/detokenizer.perl -l zh < temp3.txt  > predict.txt



