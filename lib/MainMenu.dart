import 'package:belajar_flutter_karywan_app/HeaderMenu.dart';
import 'package:belajar_flutter_karywan_app/Karyawan.dart';
import 'package:belajar_flutter_karywan_app/KaryawanReport.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {

  const MainMenu({Key key}) : super(key: key);
  @override
  _MainMenu createState() => _MainMenu();
}

class _MainMenu extends State<MainMenu>
  with TickerProviderStateMixin {

  List<Widget> listViews = List<Widget>();

  //list icon yang akan ditampilkan 
  List<String> iconListData = [
    "lib/images/employee-icon.png",
    "lib/images/attendance-icon.png",
    "lib/images/report-icon.png",
    "lib/images/logout-icon.png",
  ];

  //list nama untuk masing-masing icon  
  List<String> iconListDataText = [
    "Karyawan",
    "Absen",
    "Laporan",
    "Logout",
  ];

  @override
  void initState() {
    listViews.add(HeaderMenu());
    listViews.add(buildMenu());
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return listViews[index];
      },
    );
  }

  Widget buildMenu() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
            ),
            
            GridView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List.generate(
                iconListData.length,
                (index) {
                  return buildIconMenu(
                    iconListData[index],
                    iconListDataText[index],
                  );
                },
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 1.0,
              ),
            ),
          ],
        ) 
      ),
    );
  }

  Widget buildIconMenu(final String imagepath, String imageText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topRight: Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: Offset(1.1, 1.1),
            blurRadius: 10.0),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          splashColor: Colors.lightBlue.withOpacity(0.2),
          onTap: () {
            //mengatasi klik untuk masing-masing icon 
            if (imageText == "Karyawan"){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                  new Karyawan() 
                )
              );
            }
            if(imageText == "Absen"){
            }
            if(imageText == "Laporan"){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
                  new KaryawanReport() 
                )
              );
            }
            if(imageText == "Logout"){
            }
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
                child: Image.asset(imagepath, height: 80.0,),
              ),
              Text(
                imageText,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
