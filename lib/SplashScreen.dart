import 'dart:async';

import 'package:belajar_flutter_karywan_app/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  Future<void> _initializeState() async {
    Future.delayed(
      Duration(seconds: 5),
      (){
        try{
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                new MyHomePage(title: 'Karyawan App'),
              )
            );
        }catch(e){
        }
      },
    );
  }

  @override
  void initState(){
    super.initState();
    _initializeState();
  }
  @override
  Widget build(BuildContext build){
    return new Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/images/welcome-splash.png"),
          fit: BoxFit.fill
        ) ,
      ),
    );
  }
}