## 食用说明
1. 在data下提供有en-zh的bpecode，可以直接用，不用学习
2. requirements里面有moses和subword-nmt，不用安装
3. script下有数据预处理、训练、解码的脚本，只需要准备数据就可以直接运行，如果运行不了检查一下路径

## 食用方法
1. 准备好双语数据，划分成训练集、验证集、测试集，按照博客中的命名方式命名
2. 虽然有提供工具包，但是为了避免出错，最好安装一下环境，pip install fairseq jieba subword-nmt
3. 进入script下，直接运行脚本即可


博客 https://blog.csdn.net/MoreAction_/article/details/107252080
