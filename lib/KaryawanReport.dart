import 'package:belajar_flutter_karywan_app/Model/KaryawanModel.dart';
import 'package:belajar_flutter_karywan_app/Repository/DbLite.dart';
import 'package:belajar_flutter_karywan_app/WidgetHelper/PopupHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class KaryawanReport extends StatefulWidget {
 const KaryawanReport({Key key}) : super(key: key);
  
  @override
  _KaryawanReportState createState() => new _KaryawanReportState();
}

class _KaryawanReportState extends State<KaryawanReport>{
  final db = new DbLite(); 
  List<KaryawanModel> modelList = List<KaryawanModel>();

  @override
  void initState() {
    super.initState();
    db.getDataKaryawan().then((value) {
      modelList = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container();
        }
        else{
          return Scaffold(
            appBar: AppBar(
              title: Text("Laporan Karyawan"),
              backgroundColor: Colors.redAccent,
              elevation: 0.0,
            ),
            body: Container(
              color: Colors.white,
              height: _height,
              width: _width,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: 
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                          child: Row(
                            children: [
                              Icon(Icons.view_list, color: Colors.grey),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Laporan Data Karyawan", style: TextStyle(fontSize: 20),),
                              )
                            ],
                          ),
                        ) 
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:50, right: 10),
                        child: Divider(thickness: 2,),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:100, right: 10, bottom: 10),
                        child: Divider(thickness: 2,),
                      ),
                      Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: ListView.builder(
                            itemCount: modelList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              return Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                child: ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.redAccent
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(modelList[index].id.toString()),
                                      ],
                                    ) 
                                  ), 
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(modelList[index].nama),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.phone, size: 13, color: Colors.green,),
                                            Text(" " + modelList[index].telp, style: TextStyle(fontSize: 12, color: Colors.grey),),
                                            Container(
                                              height: 20,
                                              child: VerticalDivider(color: Colors.red, thickness: 1,),
                                            ),
                                            Icon(Icons.email, size: 13, color: Colors.orangeAccent,),
                                            Text(" " + modelList[index].email, style: TextStyle(fontSize: 12, color: Colors.grey),),
                                          ],
                                        ) 
                                      ),
                                      (index == modelList.length -1) ? Container() : Divider(thickness: 2,)
                                    ],
                                  ) 
                                ),
                                secondaryActions: [
                                  IconSlideAction(
                                    caption: 'Ubah',
                                    color: Colors.green,
                                    icon: Icons.edit,
                                    onTap: () {},
                                  ),
                                  IconSlideAction(
                                    caption: 'Hapus',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () => {
                                      _deleteKaryawan(modelList[index])
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ) 
                      )
                    ],
                  ) 
                )
              ),
            ),
          );
        }
      }
    );
  }

  //fungsi save 
  void _deleteKaryawan(KaryawanModel model){
    final db = new DbLite(); 
    PopupHelper().alertDialogCuprtino(context, "Mohon tunggu...");
    Future.delayed( Duration(seconds: 3), (){
      db.deleteKaryawan(model.id).then((value){ //hapus data yg ada di database
        if(value > 0){
          setState(() {
            modelList.remove(model); //hapus data yg ada di list
          });
          Navigator.of(context, rootNavigator: true).pop();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new WillPopScope(
                  onWillPop: () async => false,
                  child: new CupertinoAlertDialog(
                  title: new Text("Yeay, data berhasil dihapus", style: TextStyle(fontSize: 12), ),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: (){
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: new Text("Ok"),
                    )
                  ],
                ),
              );
            }
          );
        }else{
          Navigator.of(context, rootNavigator: true).pop();
          PopupHelper().alertDialogCuprtinoMsg(context, "Oops, terjadi kesalahan!");
        }
      });
    });
  }
}
