// 可积条件的几何解释

import graph;
import geometry;
import interpolate; // 插值

srand(28539);

size(400);

pair O = (0, 0);
xaxis("$x$", -1, 12, Arrow);
yaxis("$y$", -1, 6, Arrow);
label("$O$", O, SW);

pair A = (1,3), B = (7, 3), C = (10, 4);
pair Z1 = (5, 4), Z2 = (8, 2);

real[] abcXvalue = {A.x, Z1.x, B.x, Z2.x, C.x};
real[] abcYvalue = {A.y, Z1.y, B.y, Z2.y, C.y};

real f0(real x) {
  // 埃尔米特插值
  return fspline(abcXvalue, abcYvalue)(x);
}

pair fp(real x) {
  real y = f0(x);
  pair P = (x, y);
  return P;
}


// 子区间数目
int intervalCount = 20;
real a = A.x, b = B.x, c = C.x;
real intervalLen = (C.x - A.x) / intervalCount;
real[] sliceXArr = new real[intervalCount + 1]; // 分点
pair[] slicePointArr = new pair[intervalCount + 1]; // x 轴上分点坐标
pair[] sliceFunPointArr = new pair[intervalCount + 1]; // 分点在函数图象上的点

for (int index = 0; index < sliceXArr.length; ++index) {
  real sliceX = a * (1 - (index * 1.0) / intervalCount) + c * ((index * 1.0) / intervalCount);

  // 微调各中间分点的位置，以实现随机划分小区间而不是均分
  if (index > 0 && index < sliceXArr.length - 1) {
    sliceX = sliceX + (unitrand() * 0.5 * intervalLen - 0.25 * intervalLen);
  }

  sliceXArr[index] = sliceX;
  slicePointArr[index] = (sliceX, 0);

  pair FP = (sliceX, f0(sliceX));
  sliceFunPointArr[index] = FP;

  draw(slicePointArr[index] -- sliceFunPointArr[index]);

  // 标注各个分点
  if (index == 0) {
    label("$a=x_0$", slicePointArr[index], NW);
  } else if (index == 1) {
    label("$x_1$", slicePointArr[index], S);
  } else if (index == sliceXArr.length - 2) {
    label("$x_{n-1}$", slicePointArr[index], S);
  } else if (index == sliceXArr.length - 1) {
    label("$x_n=b$", slicePointArr[index], NE);
  } else if (index >= sliceXArr.length / 2 - 1 && index < sliceXArr.length / 2) {
    label("$x_{i-1}$", slicePointArr[index], S);
  } else if (index >= sliceXArr.length / 2 && index < sliceXArr.length / 2 + 1) {
    label("$x_{i}$", slicePointArr[index], S);
  }
}


// 绘制各个小区间上的振幅
for (int index = 0; index < sliceXArr.length; ++index) {
  if (index == 0) {
    draw(slicePointArr[0] -- (slicePointArr[0].x, sliceFunPointArr[1].y));
    draw(sliceFunPointArr[0] -- (slicePointArr[1].x, sliceFunPointArr[0].y));
  } else if (index == sliceXArr.length - 1) {
    draw(slicePointArr[index] -- (slicePointArr[index].x, sliceFunPointArr[index-1].y));
    draw((slicePointArr[index-1].x, sliceFunPointArr[index].y) -- sliceFunPointArr[index]);
  } else {
    draw(slicePointArr[index] -- (slicePointArr[index].x, sliceFunPointArr[index-1].y));
    draw(slicePointArr[index] -- (slicePointArr[index].x, sliceFunPointArr[index+1].y));
    draw((slicePointArr[index-1].x, sliceFunPointArr[index].y) -- sliceFunPointArr[index]);
    draw((slicePointArr[index+1].x, sliceFunPointArr[index].y) -- sliceFunPointArr[index]);
  }

  if (index < sliceXArr.length - 1) {
    fill(sliceFunPointArr[index] -- (slicePointArr[index].x, sliceFunPointArr[index+1].y) -- sliceFunPointArr[index+1] -- (slicePointArr[index+1].x, sliceFunPointArr[index].y) -- cycle, mediumgray);
  }
}

// 绘制函数曲线
draw(graph(fp, A.x, C.x));