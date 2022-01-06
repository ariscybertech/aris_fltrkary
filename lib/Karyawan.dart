import 'package:belajar_flutter_karywan_app/MainMenu.dart';
import 'package:belajar_flutter_karywan_app/Model/KaryawanModel.dart';
import 'package:belajar_flutter_karywan_app/Repository/DbLite.dart';
import 'package:belajar_flutter_karywan_app/WidgetHelper/PopupHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Karyawan extends StatefulWidget {
  final String state;
  const Karyawan({Key key, this.state}) : super(key: key);
  
  @override
  _KaryawanState createState() => new _KaryawanState();
}

class _KaryawanState extends State<Karyawan>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _ctrTxtName = TextEditingController(), 
        _ctrTxtPhone = TextEditingController(),
        _ctrTxtEmail = TextEditingController();

  int _idDepartment, _idJabatan;
  List<DropdownClass> _jabatan = new List<DropdownClass>();
  List<DropdownClass> _department = new List<DropdownClass>();
    
  
  @override
  void initState() {

    final db = new DbLite(); 
    db.getDataKaryawan().then((value) {
      print(value);
    });   
   
    //list jabatan
    _jabatan.add(new DropdownClass(0, "Officer"));
    _jabatan.add(new DropdownClass(1, "Senior Officer"));
    _jabatan.add(new DropdownClass(2, "Assistant Manager"));
    _jabatan.add(new DropdownClass(3, "Manager"));
   
    //list department
    _department.add(new DropdownClass(0, "Operation"));
    _department.add(new DropdownClass(1, "Marketing"));
    _department.add(new DropdownClass(2, "IT"));
    _department.add(new DropdownClass(3, "SDM"));
   super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Karyawan"),
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        height: _height,
        width: _width,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: new SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 180.0),
                        child: Text("Input Data", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)
                      ),
                    ]
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 45.0, left: 45.0),
                    child: new TextFormField(
                      controller: _ctrTxtName,
                      decoration:  InputDecoration(
                        labelText: 'Nama', 
                        icon: Icon(Icons.person),
                      ),
                      style: new TextStyle(color: Colors.redAccent),
                      keyboardType: TextInputType.text,
                      validator: (value){
                        return _validateName(value);
                      },
                    ),
                  ),  
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 45.0, left: 45.0),
                    child: new TextFormField(
                      controller: _ctrTxtPhone,
                      decoration: const InputDecoration(labelText: 'No Telp', icon: Icon(Icons.phone)),
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                      style: new TextStyle(color: Colors.redAccent),
                      validator: (value){
                        return _validateTelp(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 45.0, left: 45.0),
                    child: new TextFormField(
                      controller: _ctrTxtEmail,
                      decoration: const InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(color: Colors.deepOrange),
                      validator: (value){
                        return _validateEmail(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 45.0, left: 45.0),
                      child: new FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.business),
                            labelText: 'Department',
                          ),
                          child: new DropdownButtonHideUnderline(
                            child: new DropdownButton(
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  _idDepartment = newValue;
                                });
                              },
                              items: _department.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item.value),
                                  value: item.id,
                                );
                              }).toList(),
                              value: _idDepartment,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 45.0, left: 45.0),
                      child: new FormField(
                      builder: (FormFieldState state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.recent_actors),
                            labelText: 'Jabatan',
                          ),
                          child: new DropdownButtonHideUnderline(
                            child: new DropdownButton(
                              value: _idJabatan,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  _idJabatan = newValue;
                                });
                              },
                              items: _jabatan.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item.value),
                                  value: item.id,
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: SizedBox(
                          width: 300.0, // match_parent
                          child: new RaisedButton(
                            onPressed: (){
                              if(_formKey.currentState.validate()){
                                
                                var karyawanModel = new KaryawanModel(nama: _ctrTxtName.text.trim(), 
                                  telp: _ctrTxtPhone.text.trim(), email: _ctrTxtEmail.text.trim(),
                                  department: _idDepartment, jabatan: _idJabatan);
                                _saveKaryawan(karyawanModel);
                              }

                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: new Text('Simpan'),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                          ),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ) 
          )
        ),
      ),
    );
  }

  //validasi
  String _validateName(String value) {
    if (value.length < 3)
      return 'Nama maksimal lebih dari 3 karakter';
    else
      return null;
  }

  String _validateTelp(String value) {
    if (value.length != 12)
      return 'Nomor telp harus berisi 12 digit';
    else
      return null;
  }

  String _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Alamat email tidak benar';
    else
      return null;
  }

  //fungsi save 
  void _saveKaryawan(KaryawanModel karayawanModel){
    final db = new DbLite(); 
    PopupHelper().alertDialogCuprtino(context, "Mohon tunggu...");
    Future.delayed( Duration(seconds: 3), (){
      db.saveKaryawan(karayawanModel).then((value){
        if(value > 0){
          Navigator.of(context, rootNavigator: true).pop();
          //Navigator.of(context, rootNavigator: true).pop();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new WillPopScope(
                  onWillPop: () async => false,
                  child: new CupertinoAlertDialog(
                  title: new Text("Yeay, data berhasil disimpan", style: TextStyle(fontSize: 12), ),
                  actions: <Widget>[
                    new FlatButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                            new MainMenu() 
                          )
                        );
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

class DropdownClass {
  final int id;
  final String value;
  
  DropdownClass(this.id, this.value);
}