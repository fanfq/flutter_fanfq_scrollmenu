library seekbar;

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// SeekBar(
///   value: 0.5,
///   secondValue: 0.8,
///   progressColor: Colors.blue,
///   secondProgressColor: Colors.orange,
///   onStartTrackingTouch: () {
///     print('onStartTrackingTouch');
///   },
///   onProgressChanged: (value) {
///     print('onProgressChanged:$value');
///   },
///   onStopTrackingTouch: () {
///     print('onStopTrackingTouch');
///   },
/// )
class SeekBar extends StatefulWidget {
  final double progressWidth;
  final double thumbRadius;//移动点半径
  final double value;
  final int minValue;
  final int maxValue;


  //final double secondValue;
  final Color barColor;
  final Color progressColor;
  //final Color secondProgressColor;
  final Color thumbColor;
  final Function onStartTrackingTouch;
  final ValueChanged<int> onProgressChanged;
  final Function onStopTrackingTouch;

  SeekBar({
    Key? key,
    this.progressWidth = 2.0,
    this.thumbRadius = 8.0,//移动点半径
    this.value = 0.0,
    required this.minValue,
    required this.maxValue,
    //this.secondValue = 0.0,
    this.barColor = Colors.grey,//const Color(0x73FFFFFF),
    this.progressColor = Colors.white,
    //this.secondProgressColor = Colors.grey,//const Color(0xBBFFFFFF),
    this.thumbColor = Colors.blueAccent,
    required this.onStartTrackingTouch,
    required this.onProgressChanged,
    required this.onStopTrackingTouch,
  }) : super(key: key);

  @override
  _SeekBarState createState() {
    return _SeekBarState();
  }
}

class _SeekBarState extends State<SeekBar> {
  Offset _touchPoint = Offset.zero;

  double _value = 0.0;

  //double _secondValue = 0.0;

  bool _touchDown = false;

  _setValue() {
    _value = _touchPoint.dx / MediaQuery.of(context).size.width;//context.size.width;
    //_displayValue = (_maxValue * _value +).round();
  }

  _checkTouchPoint() {
    if (_touchPoint.dx <= 0) {
      _touchPoint = Offset(0, _touchPoint.dy);
    }
    if (_touchPoint.dx >= MediaQuery.of(context).size.width){// ;context.size.width) {
      _touchPoint = Offset(MediaQuery.of(context).size.width, _touchPoint.dy);
    }
  }

  @override
  void initState() {
    _value = widget.value > 1 ? 1 : widget.value < 0 ? 0 : widget.value;
    //_displayValue = (_value * _maxValue).round();
    // _secondValue = widget.secondValue > 1
    //     ? 1
    //     : widget.secondValue < 0 ? 0 : widget.secondValue;
    super.initState();
  }

  @override
  void didUpdateWidget(SeekBar oldWidget) {
    _value = widget.value > 1 ? 1 : widget.value < 0 ? 0 : widget.value;
    //_displayValue = (_value * _maxValue).round();
    // _secondValue = widget.secondValue > 1
    //     ? 1
    //     : widget.secondValue < 0 ? 0 : widget.secondValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragDown: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        _touchPoint = box.globalToLocal(details.globalPosition);
        _checkTouchPoint();
        setState(() {
          _setValue();
          _touchDown = true;
        });
        if (widget.onStartTrackingTouch != null) {
          widget.onStartTrackingTouch();
        }
      },
      onHorizontalDragUpdate: (details) {
        RenderBox box = context.findRenderObject() as RenderBox;
        _touchPoint = box.globalToLocal(details.globalPosition);
        _checkTouchPoint();
        setState(() {
          _setValue();
        });
        if (widget.onProgressChanged != null) {
          //widget.onProgressChanged(_value);
          widget.onProgressChanged((widget.maxValue * _value + widget.minValue).round());
        }
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          _touchDown = false;
        });
        if (widget.onStopTrackingTouch != null) {
          widget.onStopTrackingTouch();
        }
      },
      child: Container(
        constraints: BoxConstraints.expand(height: widget.thumbRadius * 3),//高度
        child: CustomPaint(
          painter: _SeekBarPainter(
            progressWidth: widget.progressWidth,
            thumbRadius: widget.thumbRadius,
            value: _value,
            minValue: widget.minValue,
            maxValue: widget.maxValue,
            //displayValue: _displayValue,
            //secondValue: _secondValue,
            barColor: widget.barColor,
            progressColor: widget.progressColor,
            //secondProgressColor: widget.secondProgressColor,
            thumbColor: widget.thumbColor,
            touchDown: _touchDown,
          ),
        ),
      ),
    );
  }
}

class _SeekBarPainter extends CustomPainter {
  final double progressWidth;
  final double thumbRadius;
  final double value;
  final int minValue;
  final int maxValue;
  //final int displayValue;
  //final double secondValue;
  final Color barColor;
  final Color progressColor;
  //final Color secondProgressColor;
  final Color thumbColor;
  final bool touchDown;

  _SeekBarPainter({
    required this.progressWidth,
    required this.thumbRadius,
    required this.value,
    required this.minValue,
    required this.maxValue,
    //required this.displayValue,
    //required this.secondValue,
    required this.barColor,
    required this.progressColor,
    //required this.secondProgressColor,
    required this.thumbColor,
    required this.touchDown,
  });

  @override
  bool shouldRepaint(_SeekBarPainter old) {
    return value != old.value ||
        //secondValue != old.secondValue ||
        touchDown != old.touchDown;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.square
      ..strokeWidth = progressWidth;

    final centerY = size.height / 2.0;
    final barLength = size.width - thumbRadius * 2.0;

    final Offset startPoint = Offset(thumbRadius, centerY);
    final Offset endPoint = Offset(size.width - thumbRadius, centerY);

    final Offset progressPoint =
    Offset(barLength * value + thumbRadius, centerY);

    //final Offset secondProgressPoint = Offset(barLength * secondValue + thumbRadius, centerY);


    paint.color = barColor;
    canvas.drawLine(startPoint, endPoint, paint);

    //paint.color = secondProgressColor;
    //canvas.drawLine(startPoint, secondProgressPoint, paint);

    paint.color = progressColor;
    canvas.drawLine(startPoint, progressPoint, paint);


    ///画移动点
    final Paint thumbPaint = Paint()..isAntiAlias = true;

    thumbPaint.color = Colors.transparent;
    canvas.drawCircle(progressPoint, centerY, thumbPaint);

    if (touchDown) {
      thumbPaint.color = thumbColor.withOpacity(0.6);
      canvas.drawCircle(progressPoint, thumbRadius, thumbPaint);
    }

    thumbPaint.color = thumbColor;
    canvas.drawCircle(progressPoint, thumbRadius * 0.75, thumbPaint);

    ///画移动点上的数值
    final paragraphStyle = ui.ParagraphStyle(textAlign: TextAlign.center,
        fontSize: 12,fontWeight: FontWeight.bold);


    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(color:Colors.blue))
      ..addText("${(maxValue * value + minValue).round()}");//${displayValue}    ${(maxValue * value + minValue).round()}
    var paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: 100));
    canvas.drawParagraph(paragraph, Offset(progressPoint.dx - paragraph.width/2, progressPoint.dy-paragraph.height - thumbRadius));

  }
}