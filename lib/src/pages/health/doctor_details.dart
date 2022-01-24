import 'package:TenTwelveBlood/src/applications/classes/doctor/doctor_class.dart';
import 'package:TenTwelveBlood/src/elements/DrawerWidget.dart';
import 'package:flutter/material.dart';

class DoctorDetails extends StatelessWidget { 
  final DoctorClass doctor;
  DoctorDetails({Key key,this.doctor}) : super(key:key);
  @override 
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ডাক্তার বিস্তারিত'),backgroundColor: Colors.teal,),
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
                image: NetworkImage( doctor.picture ?? 'https://sgp1.digitaloceanspaces.com/cosmosgroup/news/3369687_New%20Project%20(1).jpg'),
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
              child: Text(doctor.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold ),),
            )
          ),
          Flexible(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: <Widget> [
                    Text(doctor.details ?? 'বিস্তারিত কোন তথ্য খুঁজে পাওয়া যায় নাই ',textAlign: TextAlign.justify,),
                  ]
                ),
              )
            ), 
        ],
      ),
    );
  }
}