##通过openvcv训练车牌检测器模型 cascade 

OpenCV提供了两个程序可以训练自己的级联分类器`opencv_haartraining`与`opencv_traincascade`。`opencv_traincascade`是一个新程序，使用`OpenCV 2.x API` 以C++编写。这二者主要的区别是`opencv_traincascade`支持 `Haar`和 `LBP (Local Binary Patterns)`两种特征，并易于增加其他的特征。与Haar特征相比，LBP特征是整数特征，因此训练和检测过程都会比Haar特征快几倍。LBP和Haar特征用于检测的准确率，是依赖训练过程中的训练数据的质量和训练参数。训练一个与基于Haar特征同样准确度的LBP的分类器是可能的。


与其他分类器模型的训练方法类似，同样需要训练数据与测试数据；其中训练数据包含正样本pos与负样本neg。训练程序`opencv_haartraining.exe`与`opencv_traincascade.exe`对输入的数据格式是有要求的，所以需要相关的辅助程序：

`opencv_createsamples` 用来准备训练用的正样本数据和测试数据`opencv_createsamples` 能够生成能被`opencv_haartraining` 和 `opencv_traincascade` 程序支持的正样本数据。它的输出为以 `*.vec` 为扩展名的文件，该文件以二进制方式存储图像。


  正样本由`opencv_createsamples`生成。正样本可以由包含待检测物体的一张图片生成，也可由一系列标记好的图像生成。 
  
  在Picturer目录为项目的根目录。
  
  正样本是车牌图片，在项目根目录下创建pos文件夹，将所有正样本放到这个目录下，并创建pos.txt文件，文件的每行内容为 : 图片名 1 0 0 140 50. 其含义为1表示该图中有1个目标，0 0 表示改目标在图片中的起始坐标，140 50表示该目标的长度和高度。
  
  在项目根目录下创建neg文件夹，该文件夹用来保存所有负样本，父样本是任意的不包含车牌的图片，图片需要比正样本的图片大。在neg文件夹中创建neg.txt，该文件每行的内容为:`neg/负样本的文件名`  
  
  
  在项目根目录下执行以下命令: 
   
#### 利用opencv_createsamples生成训练数据集
   
  ```
  opencv_createsamples -vec sample.vec -info pos/info.txt -w 150 -h 40 -num 4
  -vec:输出的数据集文件  
  -info pos/pos.txt  :指定正样本文件。
  -w 150 -h 40 -num 40 : 正样本图片大小和数量  
  ```
  
#### 利用opencv_traincascade训练检测器（以xml文件保存） 
	
```  
  opencv_traincascade 
  		-data xml 		#模型xml文件保存的目录
  		-vec sample.vec 	#数据集文件
  		-bg neg/neg.txt 	#负样本描述文件
  		-numPos 40		#正样本数
  		-numNeg 40 		#负样本数
  		-numStages 10		#stages越多，训练效果越好。
  		-featureType LBP #LBP方式训练
  		-w 150 			#图片的大小
  		-h 40 
```

然后编写测试程序`test.py`


```
import cv2 
import sys 

face_detector = cv2.CascadeClassifier("/home/swann/Pictures/xml/cascade.xml")

frame = cv2.imread(sys.argv[1])
srcimg = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

watchs = face_detector.detectMultiScale(srcimg, 1.01, 4)
for (x,y,w,h) in watchs:
    print("x={},y={},w={},h={}".format(x,y,w,h))
    cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 255), 1)
cv2.imshow("test", frame)
cv2.waitKey(0)
```

执行`python test.py imagename `就能够进行测试。


在生成正样本的vec文件时，先后采用了4种不同的正样本图片，分别是包含车牌外围图片的正样本，包含车牌外围图片的GRAY图片正样本，仅包含车牌图片的正样本，仅包含车牌图片的GRAY图片正样本。四种方式生成`sample.vec`文件.

然后使用生成`sample.vec`进行训练生成`cascade.xml`文件，最后用`test.py`进行测试。 

```
opencv_createsamples -vec sample.vec -info pos/info.txt -w 150 -h 40 -num 40

opencv_traincascade -data xml -vec sample.vec -bg neg/neg.txt -numPos 40 -numNeg 200 -numStages 10 -w 150 -h 40 -minHitRate 0.999 -maxFalseAlarmRate 0.2 -weightTrimRate 0.95 -featureType LBP
```