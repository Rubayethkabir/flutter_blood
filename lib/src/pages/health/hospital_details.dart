import 'package:TenTwelveBlood/src/applications/classes/hospital/hospital_class.dart';
import 'package:TenTwelveBlood/src/elements/DrawerWidget.dart';
import 'package:flutter/material.dart';

class HospitalDetails extends StatelessWidget { 
  final HospitalClass hospital;
  HospitalDetails({Key key,this.hospital}) : super(key:key);
  @override 
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('হসপিটাল বিস্তারিত'),backgroundColor: Colors.teal,),
      drawer: DrawerWidget(),
      body: Column(
        children: <Widget>[
         Flexible(
           flex: 3,
           child: Container(
            padding: EdgeInsets.all(3),
            width: MediaQuery.of(context).size.width-5,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage( hospital.picture ?? 'https://sgp1.digitaloceanspaces.com/cosmosgroup/news/3369687_New%20Project%20(1).jpg'),
                fit: BoxFit.fill
              )
            ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top:5),
              alignment: Alignment.topCenter,
              child: Text(hospital.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold ),),
            )
          ),
          Flexible(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: <Widget> [
                    Text(hospital.details ?? 'বিস্তারিত কোন তথ্য খুঁজে পাওয়া যায় নাই ',textAlign: TextAlign.justify,),
                  ]
                ),
              )
            ), 
        ],
      ),
    );
  }
}