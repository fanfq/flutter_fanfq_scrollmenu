import 'package:flutter/material.dart';

class AppbarEditer extends AppBar {



  final Function onCancelListener;
  final Function onOkListener;

  final ValueChanged<int> onUndoListener;
  final ValueChanged<int> onRedoListener;

  late int undoValue = 0;
  late int redoValue = 0;

  AppbarEditer({
    Key? key,
    required this.onCancelListener,
    required this.onOkListener,
    required this.onUndoListener,
    required this.onRedoListener,
    required this.undoValue,
    required this.redoValue
  }): super(key: key);


  @override
  State<AppBar> createState() => _AppbarEditer();
}

class _AppbarEditer extends State<AppbarEditer>{

   //int _undoValue =0;
   //int _redoValue =0;

  @override
  void initState() {
    //_undoValue = widget.undoValue;
    //_redoValue = widget.redoValue;

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    TextStyle defaultTextStyle = TextStyle(
        fontSize: 10, color: Colors.white);

    TextStyle disabledTextStyle = TextStyle(
        fontSize: 10, color: Colors.grey);

    return AppBar(
      //title: Text('自定义 AppBar'),
      centerTitle: true,
      title:

      Container(
        alignment: Alignment.center,

        child:Center(

          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Ink(
                child: InkResponse(
                  onTap: (){
                    //print('撤销');

                    if(widget.undoValue > 0){
                      setState((){
                        widget.undoValue -- ;
                      });
                      widget.onUndoListener(widget.undoValue);
                    }
                  },

                  child:Column(
                    children: [
                      Icon(Icons.undo,color: Colors.white,),
                      Text('${widget.undoValue}',style: widget.undoValue == 0?disabledTextStyle:defaultTextStyle,),
                    ],
                  ),
                ),
              ),


              Ink(
                child: InkResponse(
                  onTap: (){
                    //print('恢复');
                    if(widget.redoValue>0){
                      setState((){
                        widget.redoValue -- ;
                      });
                      widget.onRedoListener(widget.redoValue);
                    }
                  },

                  child:Column(
                    children: [
                      Icon(Icons.redo,color: Colors.white,),
                      Text('${widget.redoValue}',style: widget.redoValue == 0?disabledTextStyle:defaultTextStyle,),
                    ],
                  ),
                ),
              ),

            ],
          ),

          // child:Column(
          //   children: [
          //     Icon(Icons.undo,color: Colors.redAccent,),
          //     Text('0',style: defaultTextStyle,),
          //   ],
          // ),
          //child: Icon(Icons.undo),
        ),

      ),


      // Container(
      //   child:Center(
      //     child:Row(
      //       children: [
      //         Icon(Icons.undo),
      //         Text("0"),
      //         Text("0"),
      //         Icon(Icons.redo),
      //       ],
      //     ),
      //   )
      // ),



      backgroundColor: Colors.pink,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          //print('取消');
          widget.onCancelListener();
        },
      ),
      actions: <Widget>[
        // Center(
        //   child: Text('所有订单'),
        // ),
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            //print('确定');
            widget.onOkListener();
          },
        ),
      ],
    );
  }

}