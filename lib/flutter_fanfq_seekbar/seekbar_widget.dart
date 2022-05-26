
import 'package:flutter/material.dart';
import 'package:flutter_fanfq_scrollmenu/flutter_fanfq_seekbar/progress_value.dart';


abstract class BaseSeekBar extends StatefulWidget{

}

class SeekBarWidget extends StatefulWidget{

  final int startValue;
  final int endValue;
  final int defaultValue;
  final bool isCenter;//左右滑动
  final int value;
  final ValueChanged<ProgressValue> onValueChanged;


  const SeekBarWidget({
    Key? key,
    required this.value,
    required this.onValueChanged,
    required this.startValue,
    required this.endValue,
    required this.defaultValue,
    required this.isCenter,

  }): super(key: key);

  @override
  State<SeekBarWidget> createState() => _SeekBarWidget();
}

class _SeekBarWidget extends State<SeekBarWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}