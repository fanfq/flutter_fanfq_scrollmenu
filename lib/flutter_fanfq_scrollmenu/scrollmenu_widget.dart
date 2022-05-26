

import 'package:flutter/material.dart';
import 'package:flutter_fanfq_scrollmenu/flutter_fanfq_scrollmenu/scrollmenu_item_widget.dart';

class ScrollMenuWidget extends StatefulWidget {

  final Map<String, IconData> items; // title:checked 的形式 返回值为 key:true/false
  final void Function(int) click; // 点击回调 返回第n个的选中情况
  // final double? width;
  // final double? height;
  final int currentIndex; // 当前选中
  // final bool isHorizontal; // 横向
  // final Color? activeColor; // 点击后的颜色 没传取主题色
  // final Color? backgroundColor; // 背景色
  // final Color? borderColor; // 边框色
  // final TextStyle? textStyle; // 文字样式
  // final TextStyle? activeTextStyle; //  选中的文字样式

  const ScrollMenuWidget(
      {Key? key,
        required this.items,
        required this.click,
        // this.width,
        // this.height,
        this.currentIndex = 0,
        // this.isHorizontal = false,
        // this.activeColor,
        // this.backgroundColor,
        // this.borderColor,
        // this.textStyle,
        // this.activeTextStyle
      }): super(key: key);

  @override
  State<ScrollMenuWidget> createState() => _ScrollMenuWidget();

}

class _ScrollMenuWidget extends State<ScrollMenuWidget> {

  int currentIndex = 0; // 当前选中
  //bool isHorizontal = false; // 是否横向

  @override
  void initState() {
    // 初始化当前选中
    currentIndex = widget.currentIndex;
    //isHorizontal = widget.isHorizontal;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    int index = 0; // 遍历自增 index
    int size = widget.items.length;

    return Container(
      //margin: const EdgeInsets.symmetric(vertical: 20.0),
      color: Colors.white,
      height: 60.0,
      child: ListView(
        scrollDirection: Axis.horizontal,//水平
        children: widget.items.keys.map((key){
          return ScrollMenuItemWidget(
            text:key,
            icon: widget.items[key]!,
            index:index,
            click:(index){
              setState((){
                currentIndex = index;
              });
              //print("scrollmenu:${index}");
              widget.click(index);//回调
            },
            height:70,
            width:70,
            isActive: index == currentIndex,
            isEnd: index++ == size-1,
          );
        }).toList(),
      ),
    );
  }

}