

import 'package:flutter/material.dart';

class ScrollMenuItemWidget extends StatelessWidget {

  ///文字
  final String text;

  ///序列号
  final int index;

  ///图标
  final IconData icon;

  ///event
  final ValueChanged<int> click;

  final double width;
  final double height;
  final bool isActive;
  final bool isEnd; // 是否为末尾
  final Color? activeColor; // 点击后的颜色 没传取主题色
  final Color? backgroundColor; // 背景色
  final Color? borderColor; // 边框色
  final TextStyle? textStyle; // 文字样式
  final TextStyle? activeTextStyle; //  选中的文字样式

  const ScrollMenuItemWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.index,
    required this.click,
    this.isActive = false,
    this.width = 40,
    this.isEnd = false,
    this.height = 40,
    this.activeColor,
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
    this.activeTextStyle}):super(key:key);

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = TextStyle(
        fontSize: 10, color: isActive ? Colors.redAccent : Colors.black);
    Color defaultIconColor = isActive ? Colors.redAccent : Colors.black;

    return Material(


      child: Ink( //点击水波纹特效
        width: width,
        height: height,

        child: InkResponse(
          onTap: (){
            //print("scrollmenu item:${index}");
            click(index);//点击事件回调
          },
          child: Center(
            child: Column(
                children: [
                  SizedBox(height: 10),
                  Icon(icon,color: defaultIconColor,size: 22,),
                  SizedBox(height: 5),
                  Text(text,style: defaultTextStyle),
                ],
            ),
          ),
        ),
      ),
    );
  }


}



