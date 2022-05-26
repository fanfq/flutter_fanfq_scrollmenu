import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_fanfq_appbar/appbar_editer.dart';
import 'flutter_fanfq_scrollmenu/scrollmenu_item_widget.dart';
import 'flutter_fanfq_scrollmenu/scrollmenu_widget.dart';
import 'flutter_fanfq_seekbar/seekbar.dart';
import 'flutter_fanfq_seekbar/seekbar_bidirectional.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'com.fanfq.flutter_fanfq_scrollmenu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late String title = "0";
  int scrollMenuSelectedIndex = 0;//scrollmenu 菜单选中index

  int _undo = 0;
  int _redo = 0;

  @override
  void initState() {
    _undo = 4;
    _redo = 10;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {




    return Scaffold(

      appBar: AppbarEditer(
          undoValue: _undo,
          redoValue:  _redo,
          onCancelListener:(){
            print('取消');
          },
          onOkListener:(){
            print('确定');
          },
          onUndoListener:(undoValue){
            print('undoValue:${undoValue}');
          },
          onRedoListener:(redoValue){
            print('redoValue:${redoValue}');

            _redo = redoValue;

            if(redoValue == 7){

              setState((){
                print('set _undo = 9');
                _undo = 9;
              });
            }
          },
      ),

      body: ListView(
          children: [

            Divider(height: 1,color:Colors.grey),
            ///功能区
            //initCupertinoSlider(),
            //menuBarEditArea(),
            initSeekBar(),
            Divider(height: 1,color:Colors.grey),
            initSeekBar2(),

            ///分割线
            Divider(height: 1,color:Colors.grey),

            ///scrollmenu 区
            ScrollMenuWidget(
              items:{
                "1xx待收货":Icons.local_mall_outlined,
                "2xx待收货":Icons.local_mall_outlined,
                "3xx待收货":Icons.local_mall_outlined,
                "4xx待收货":Icons.local_mall_outlined,
                "5xx待收货":Icons.local_mall_outlined,
                "6xx待收货":Icons.local_mall_outlined,
                "7xx待收货":Icons.local_mall_outlined,
                "8xx待收货":Icons.local_mall_outlined,
                "9xx待收货":Icons.local_mall_outlined,
                "10xx待收货":Icons.local_mall_outlined,
                "11xx待收货":Icons.local_mall_outlined,
                "12xx待收货":Icons.local_mall_outlined,
              },
              click: (index){
                print("mainthread click event:${index}");
                setState((){
                  title = "currentIndex:${index}";
                  scrollMenuSelectedIndex = index;
                });

                if(index == 3){
                  setState((){
                    print('set _undo = 9');
                    _undo = 9;
                  });
                }
              },
              currentIndex: scrollMenuSelectedIndex,
            ),
          ],
        )


    );
  }

  @override
  void initData() {
    super.initState();

    //Zitems = _items();
  }


  Widget menuBarEditArea(){

    //title
    //------ value

   return Container(

     //
     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
     child: Column(
       children: [
         Row(children:[Text("title"),],),

          Row(
             children:[
               Text("0"),
               //initCupertinoSlider(),
               Text("50"),
             ],
           ),

       ],
     ),


          // child:Column(
          //       children: [
          //         Row(children:[Text("title"),],),
          //         Row(
          //           children:[
          //             Text("values"),
          //             initCupertinoSlider(),
          //             Text("valuee"),
          //           ],
          //         ),
          //       ],
          //     ),



    );
  }


  Widget initSeekBar(){
    return

      Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),

        child:SeekBar(
        value: 0,
        minValue: 0,
        maxValue: 50,
        //secondValue: 0.8,
        progressColor: Colors.blue,
        barColor: Colors.redAccent,
        //secondProgressColor: Colors.grey,
        onStartTrackingTouch: () {
          print('onStartTrackingTouch');
        },
        onProgressChanged: (value) {
          print('onProgressChanged:$value');
        },
        onStopTrackingTouch: () {
          print('onStopTrackingTouch');
        }
      ),
    );
  }


  Widget initSeekBar2(){
    return

      Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),

        child:SeekBar_Bidirectional(
            value: 0.5,
            minValue: 0,
            maxValue: 100,
            //secondValue: 0.8,
            progressColor: Colors.blue,
            barColor: Colors.redAccent,
            //secondProgressColor: Colors.grey,
            onStartTrackingTouch: () {
              print('onStartTrackingTouch');
            },
            onProgressChanged: (value) {
              print('onProgressChanged:$value');
            },
            onStopTrackingTouch: () {
              print('onStopTrackingTouch');
            }
        ),
      );
  }


  /// 苹果风格滑动条
  // double _slidervalue = 0;
  // Widget initCupertinoSlider() {
  //   return CupertinoSlider(
  //     // ///将视频分为5段 只能滑动到5段上的某个位置
  //     divisions: 50,
  //
  //     ///已滑动过得颜色
  //     activeColor: Colors.red,
  //
  //     ///未滑动的颜色
  //     thumbColor: Colors.grey,
  //
  //     ///默认为0.0。必须小于或等于[最大值]
  //     ///如果[max]等于[min]，则滑块被禁用。
  //     min: 0,
  //
  //     ///默认为1.0。必须大于或等于[min]。
  //     ///如果[max]等于[min]，则滑块被禁用。
  //     max: 50,
  //
  //     ///当前进度 取值(0 - 1)
  //     value: _slidervalue,
  //
  //     //进度条进度 返回值为(0-1)
  //     onChanged: (double value) {
  //       setState(() {
  //         _slidervalue = value;
  //         //拖动进度条改变视频长度
  //         print("滑动$value");
  //       });
  //     },
  //     //滑动开始回调
  //     onChangeStart: (double value) {
  //       print("滑动开始$value");
  //     },
  //     //滑动结束回调
  //     onChangeEnd: (double value) {
  //       print("滑动结束$value");
  //     },
  //   );
  // }


}
