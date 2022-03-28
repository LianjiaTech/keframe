# Flutter 流畅度优化组件 Keframe

![image](https://user-images.githubusercontent.com/40540394/123200939-50503d80-d4e4-11eb-8db0-afcc3c32423a.png)


   + [列表流畅度优化](#列表流畅度优化)
   + [页面切换流畅度提升：](#页面切换流畅度提升)
   + [如何使用？](#如何使用)
     - [项目依赖：](#项目依赖)
     - [快速上手](#快速上手)
   + [构造函数说明：](#构造函数说明)
   + [Example 示例说明：](#Example示例说明)
     - [1、列表中实际 item 尺寸已知的情况](#1列表中实际-item-尺寸已知的情况)
     - [2、列表中实际 item 高度未知的情况](#2列表中实际-item-高度未知的情况)
     - [3、预估一屏 item 的数量](#3预估一屏-item-的数量)
     - [4、非列表场景](#4非列表场景)
   + [分帧的成本](#分帧的成本)
   + [优化前后对比演示](#优化前后对比演示)
   + [相关原理分析：](#相关原理分析)
   
Language: [English](README.md) | 中文简体

[![null-safe](https://img.shields.io/badge/nullsafe-2.0.4-brightgreen)](https://pub.dev/packages/keframe)
[![null-safe](https://img.shields.io/badge/normal-1.0.3-brightgreen)](https://pub.dev/packages/keframe)
[![GitHub stars](https://img.shields.io/github/stars/LianjiaTech/keframe)](https://github.com/LianjiaTech/keframe/stargazers)
[![GitHub license](https://img.shields.io/github/license/LianjiaTech/keframe)](https://github.com/LianjiaTech/keframe/blob/master/LICENSE)


### 列表流畅度优化

这是一个通用的流畅度优化方案，通过分帧渲染优化由构建导致的卡顿，例如页面切换或者复杂列表快速滚动的场景。

代码中 [example](app-profile.apk)(可以直接下载运行) 运行在 VIVO X23（骁龙 660），相同操作下优化前后 200 帧采集数据指标对比（gif 在文章最后）：

| 优化前 |  优化后 |
| --- | --- |
| <img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4233166557ec4b4da0133fe8a9b17325~tplv-k3u1fbpfcp-watermark.image" alt="优化前" style="zoom:50%;" /> | <img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6db4a156eaa14bb8b6acb27549788b63~tplv-k3u1fbpfcp-watermark.image" alt="优化后" style="zoom:50%;" /> |

监控工具来自：[fps_monitor](https://github.com/Nayuta403/fps_monitor)，指标详细信息：[页面流畅度不再是谜！调试神器开箱即用，Flutter FPS检测工具](https://juejin.cn/post/6947911434424549384)

- 流畅：一帧耗时低于 18ms
- 良好：一帧耗时在 18ms-33ms 之间
- 轻微卡顿：一帧耗时在 33ms-67ms 之间
- 卡顿：一帧耗时大于 66.7ms

采用分帧优化后，卡顿次数从 **平均 33.3 帧出现了一帧**，降低到 **200 帧中仅出现了一帧**，峰值也**从 188ms 降低到 90ms**。卡顿现象大幅减轻，流畅帧占比显著提升，整体表现更流畅。下方是详细数据。

|                            | 优化前  | 优化后 |
| -------------------------- | ------- | ------ |
| 平均多少帧出现一帧卡顿     | 33.3    | 200    |
| 平均多少帧出现一帧轻微卡顿 | 8.6     | 66.7   |
| 最大耗时                   | 188.0ms | 90.0ms |
| 平均耗时                   | 27.0ms  | 19.4ms |
| 流畅帧占比                 | 40%     | 64.5%  |

****

### 页面切换流畅度提升：

在打开一个页面或者 Tab 切换时，系统会渲染整个页面并结合动画完成页面切换。对于复杂页面，同样会出现卡顿掉帧。借助分帧组件，将页面的构建逐帧拆解，通过 DevTools 中的性能工具查看。切换时一帧的峰值由 **112.5ms 降低到 30.2 ms**，整体切换过程更加流畅。

| ![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c0ce341f0a2d4fceb0ad123fd4834ce2~tplv-k3u1fbpfcp-watermark.image) | ![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0c571a755ac84f39b52d57a13856a243~tplv-k3u1fbpfcp-watermark.image) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |

三位开发者的实际使用效果 [Keframe 优化实践合集](https://juejin.cn/post/6984606303641403406)

***

### 如何使用？

#### 项目依赖：

在 `pubspec.yaml` 中添加 `keframe` 依赖 

```yaml
dependencies: 
  keframe: version
```

组件仅区分非空安全与空安全版本

非空安全使用： `1.0.2`

空安全版本使用： `2.0.2`

#### 快速上手

如下图所示

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/83d16f3b2a3e45b79fc73d7a52774696~tplv-k3u1fbpfcp-watermark.image)

假如现在页面由 A、B、C、D 四部分组成，每部分耗时 10ms，在页面时构建为 40ms。使用分帧组件  `FrameSeparateWidget` 嵌套每一个部分。页面构建时会在第一帧渲染简单的占位，在后续四帧内分别渲染 A、B、C、D。

对于列表，在每一个 item 中嵌套 `FrameSeparateWidget`，并将 `ListView` 嵌套在 `SizeCacheWidget` 内。

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ffecd49bf9ba4379984a22ef79663104~tplv-k3u1fbpfcp-watermark.image)

***

### 构造函数说明：

FrameSeparateWidget ：分帧组件，将嵌套的 widget 单独一帧渲染

| 类型   | 参数名      | 是否必填 | 含义                                                         |
| ------ | ----------- | -------- | ------------------------------------------------------------ |
| Key    | key         | 否       |                                                              |
| int    | index       | 否       | 分帧组件 id，使用 SizeCacheWidget 的场景必传，SizeCacheWidget 中维护了 index 对应的 Size 信息 |
| Widget | child       | 是       | 实际需要渲染的 widget                                        |
| Widget | placeHolder | 否       | 占位 widget，尽量设置简单的占位，不传默认是 Container()      |

SizeCacheWidget：缓存子节点中，分帧组件嵌套的**实际 widget 的尺寸信息**

| 类型   | 参数名        | 是否必填 | 含义                                                   |
| ------ | ------------- | -------- | ------------------------------------------------------ |
| Key    | key           | 否       |                                                        |
| Widget | child         | 是       | 子节点中如果包含分帧组件，则缓存**实际的 widget 尺寸** |
| int    | estimateCount | 否       | 预估屏幕上子节点的数量，提高快速滚动时的响应速度       |

***

### Example 示例说明：

卡顿的页面往往都是由多个复杂 widget 同时渲染导致。通过为复杂的 widget 嵌套分帧组件 `FrameSeparateWidget`。渲染时，分帧组件会在第一帧同时渲染多个 `palceHolder`，之后连续的多帧内依次渲染复杂子项，以此提升页面流畅度。

例如 example 中的优化前示例：

```dart
ListView.builder(
              itemCount: childCount,
              itemBuilder: (c, i) => CellWidget(
                color: i % 2 == 0 ? Colors.red : Colors.blue,
                index: i,
              ),
            )
```

其中 `CellWidget` 高度为 60，内部嵌套了三个 `TextField` 的组件（整体构建耗时在 9ms 左右）。

优化仅需为每一个 item 嵌套分帧组件，并为其设置 `placeHolder`（placeHolder 尽量简单，样式与实际 item 接近即可）。

在列表情况下，给 ListView 嵌套 `SizeCacheWidget`，同时建议将预加载范围 `cacheExtent` 设置大一点，例如 500（该属性默认为 250），提升慢速滑动时候的体验。

例如：

```dart
SizeCacheWidget(
              child: ListView.builder(
                cacheExtent: 500,
                itemCount: childCount,
                itemBuilder: (c, i) => FrameSeparateWidget(
                  index: i,
                  placeHolder: Container(
                    color: i % 2 == 0 ? Colors.red : Colors.blue,
                    height: 60,
                  ),
                  child: CellWidget(
                    color: i % 2 == 0 ? Colors.red : Colors.blue,
                    index: i,
                  ),
                ),
              ),
            ),
```

下面是几种场景说明：

#### 1、列表中实际 item 尺寸已知的情况

实际 item 高度已知的情况下（每个 item 高度为 60），将占位设置与实际 item 高度一致即可，查看 example 中 分帧优化 1。

```dart
FrameSeparateWidget(
                index: i,
                placeHolder: Container(
                  color: i % 2 == 0 ? Colors.red : Colors.blue,
                  height: 60,// 与实际 item 高度保持一致
                ),
                child: CellWidget(
                  color: i % 2 == 0 ? Colors.red : Colors.blue,
                  index: i,
                ),
              )
```

#### 2、列表中实际 item 高度未知的情况

现实场景中，列表往往是根据数据下发展示，无法一开始预知 item 的尺寸。

例如，example 中 分帧优化 2， `placeHolder` （高度40）与实际 item （高度60）尺寸不一致，
由于每一个 item 分在不同帧完成渲染，因此会出现列表「抖动」的情况。

这时可以给 placeholder 设置一个近似的高度。并且在将 ListView 嵌套在 SizeCacheWidget 中。对于已渲染过的 widget 会强制设置 `palceHolder` 的尺寸，同时将`cacheExtent`调大。这样在来回滑动过程中，已经渲染过的 item 将不会出现跳动情况。

例如，example 中 分帧优化 3

```dart
SizeCacheWidget(
              child: ListView.builder(
                cacheExtent: 500,
                itemCount: childCount,
                itemBuilder: (c, i) => FrameSeparateWidget(
                  index: i,
                  placeHolder: Container(
                    color: i % 2 == 0 ? Colors.red : Colors.blue,
                    height: 40,
                  ),
                  child: CellWidget(
                    color: i % 2 == 0 ? Colors.red : Colors.blue,
                    index: i,
                  ),
                ),
              ),
            ),
```

实际效果如下：

<img src="https://user-images.githubusercontent.com/40540394/123904966-fa780b80-d9a3-11eb-9afe-c1023e265a75.gif" alt="Screenrecording_20210611_194905.gif" style="zoom:50%;" />



#### 3、预估一屏 item 的数量

如果能粗略估计一屏能展示的实际 item 的最大数量，例如 10。将 SizeCacheWidget 的 `estimateCount ` 属性设置为 10*2。快速滚动场景构建响应更快，并且内存更稳定。例如，example 中的 分帧优化4

```dart
...
SizeCacheWidget(
              estimateCount: 20,
              child: ListView.builder(
...
```

此外，也可以给 item 嵌套透明度/位移等动画，优化视觉上的效果。

效果如下图：

| ![Screenrecording_20210315_133310.gif](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/bb7d1361ae7842df954bb1c559e2ec54~tplv-k3u1fbpfcp-watermark.image) | ![Screenrecording_20210315_133848.gif](https://user-images.githubusercontent.com/40540394/123905372-c9e4a180-d9a4-11eb-94d0-4190710828f5.gif) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |

#### 4、非列表场景

对于非列表场景，一般不存在流畅度问题，不过在初次进入的时候任然可能出现卡顿。同样的，可以将复杂的模块分到不同帧渲染，避免初次进入的卡顿。例如，我们将为优化例子中底部的操作区域嵌套分帧组件：

```dart
FrameSeparateWidget(
    child: operateBar(),
    index: -1,
)
```

****



### 分帧的成本

当然分帧方案也非十全十美，在我看来主要有两点成本：

1、额外的构建开销：整个构建过程的构建消耗由「n * widget消耗 」变成了「n *（ widget + 占位）消耗 + 系统调度 n 帧消耗」。可以看出，额外的开销主要由占位的复杂度决定。如果占位只是简单的 Container，测试后发现整体构建耗时大概提升在 15 % 左右。这种额外开销对于当下的移动设备而言，成本几乎可以不计。

2、视觉上的变化：如同上面的演示，组件会将 item 分帧渲染，页面在视觉上出现占位变成实际 widget 的过程。但其实由于列表存在缓存区域（建议将缓存区调大），在高端机或正常滑动情况下用户并无感知。而在中低端设备上快速滑动能感觉到切换的过程，但比严重顿挫要好。

***
### 如果项目对你有所帮助，并且你愿意分享。可以发送你优化前后的对比到我的邮箱 762579473@qq.com 非常感谢！
### 如果有任何问题，欢迎与我联系；如果对你有所启发，不要忘了 start ✨✨✨✨ Thanks~
### 优化前后对比演示 

注：gif 帧率只有20

| 优化前 |  优化后 |
| --- | --- |
| ![优化前](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2f20f593cc144b72a1df4bdae57a165c~tplv-k3u1fbpfcp-watermark.image) | ![优化后](https://user-images.githubusercontent.com/40540394/123905087-3c08b680-d9a4-11eb-9485-4cdf21c38ad2.gif) |

***

### 相关原理分析：

[ListView流畅度翻倍！！Flutter卡顿分析和通用优化方案](https://juejin.cn/post/6940134891606507534)

