# 2s-AGCN-Paddle

## 1 简介

This is the unofficial code based on **PaddlePaddle** of CVPR 2019 paper:

[Two-Stream Adaptive Graph Convolutional Networks for Skeleton-Based Action Recognition](https://openaccess.thecvf.com/content_CVPR_2019/papers/Shi_Two-Stream_Adaptive_Graph_Convolutional_Networks_for_Skeleton-Based_Action_Recognition_CVPR_2019_paper.pdf)

![模型结构图](https://github.com/ELKYang/2s-AGCN-paddle/blob/main/images/model_structure.png)

2s-AGCN是发表在CVPR2019上的一篇针对ST-GCN进行改进的文章，文章提出双流自适应卷积网络，针对原始ST-GCN的缺点进行了改进。在现有的基于GCN的方法中，图的拓扑是手动设置的，并且固定在所有图层和输入样本上。另外，骨骼数据的二阶信息（骨骼的长度和方向）对于动作识别自然是更有益和更具区分性的，在当时方法中很少进行研究。因此，文章主要提出一个基于骨架节点和骨骼两种信息融合的双流网络，并在图卷积中的邻接矩阵加入自适应矩阵，大幅提升骨骼动作识别的准确率，也为后续的工作奠定了基础（后续的骨骼动作识别基本都是基于多流的网络框架）。

论文地址：[2s-AGCN Paper](https://openaccess.thecvf.com/content_CVPR_2019/papers/Shi_Two-Stream_Adaptive_Graph_Convolutional_Networks_for_Skeleton-Based_Action_Recognition_CVPR_2019_paper.pdf)

原论文代码地址：[2s-AGCN Code](https://github.com/lshiwjx/2s-AGCN)

## 2 复现精度

> 在NTU-RGBD数据集上的测试效果如下

|         |  CS   |  CV  |
| :-----: | :---: | :--: |
| Js-AGCN | 85.8% |      |
| Bs-AGCN | 86.7% |      |
| 2s-AGCN | 88.5% |      |

在NTU-RGBD上达到验收标准：X-Sub=88.5%, X-View=95.1%

训练日志：日志			VisualDL可视化日志：VDL			模型权重：Model_weight

## 3 数据集及数据预处理

数据集地址：[NTU-RGBD](https://github.com/shahroudy/NTURGB-D)，下载后将其放到如下目录

```
-data\  
  -nturgbd_raw\  
    -nturgb+d_skeletons\
 	...
   -samples_with_missing_skeletons.txt
```

