import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopupHelper {

  void alertDialogCuprtino(BuildContext context, String sType){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => false,
          child: new CupertinoAlertDialog(
          title: new Text(sType),
          content: new CupertinoActivityIndicator(radius: 13.0),
        ),
        );
      }
    );
  }

  void alertDialogCuprtinoMsg(BuildContext context, String sMsg){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child: new CupertinoAlertDialog(
            title: new Text(sMsg, style: TextStyle(fontSize: 12), ),
            actions: <Widget>[
              new FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: new Text("Ok"),
              )
            ],
          ),
        );
      }
    );
  }
}