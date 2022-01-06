
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderMenu extends StatefulWidget{
  const HeaderMenu({Key key}) : super(key: key);
  @override
  _HeaderMenu createState() => _HeaderMenu();
}

class _HeaderMenu extends State<HeaderMenu>{
  @override 
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: new BorderRadius.only(
          bottomLeft: const Radius.circular(120.0),
          bottomRight: const Radius.circular(120.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 13.0,
            offset: Offset(0, 13),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Center(child: Text("Good Evening", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)),
          ),
          Center(child: Text("PT Indonesia Santuy", style: TextStyle(fontSize: 13, color: Colors.white),)),
          Container(
            padding: EdgeInsets.fromLTRB(10,10,10,10),
            height: 130,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10.0),
                                        child: Text("DJanuar Aransyah ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        child: Text("CTO The Santuy Company"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Spacer(),
                                  new Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                      border: Border.all(color: Colors.redAccent)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Image.asset("lib/images/face-man.png", height: 70.0, width: 70.0,),
                                    ) 
                                  ),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                              ],
                            )
                          )
                        ],
                      ),
                    )
                  ]
                ),
              ),
            )
          )
        ],
      )
    );  
  }
}