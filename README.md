# TransitionAnimationDemo
转场动画

下面这张图是还没有成功present过的，这个时候动画的比例是对的，可以从日志看到percent从0~1，动画也正好是一整个动画
![image](https://github.com/xypng/TransitionAnimationDemo/blob/master/Gif/presentedView.gif?raw=true)

下面这张图是先present，之后动画的比例就不对了，从日志可以看到不管是present还是dismiss，动画都在0.5时就完成了。
![image](https://github.com/xypng/TransitionAnimationDemo/blob/master/Gif/dismissView.gif?raw=true)
