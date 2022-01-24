import 'package:TenTwelveBlood/src/applications/classes/images.dart';
import 'package:TenTwelveBlood/src/elements/DrawerWidget.dart';
import 'package:TenTwelveBlood/src/pages/health/health_tips.dart';
import 'package:TenTwelveBlood/src/router/route_constants.dart';
import 'package:TenTwelveBlood/src/widgets/row_cell.dart';
import 'package:flutter/material.dart';

class Health extends StatefulWidget {
  Health({Key key}) : super(key: key);

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('স্বাস্থ্য')),
      drawer: DrawerWidget(),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        firstRowCellNameImage(context, Images.hospitalImage,
                            "চিকিৎসাগার", hospitalRoute, Colors.blue),
                        firstRowCellNameImage(context, Images.doctorImage,
                            "ডাক্তার", doctorRoute, Colors.blue),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      'কিছু স্বাস্থ্য বিষয়ক পরামর্শ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                )),
            Flexible(
                flex: 16,
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: HealthTips(),
                ))
          ],
        ),
      ),
    );
  }
}
