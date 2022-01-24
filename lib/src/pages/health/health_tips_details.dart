import 'package:TenTwelveBlood/src/applications/classes/medical_tip/medical_tip_model.dart';
import 'package:TenTwelveBlood/src/elements/DrawerWidget.dart';
import 'package:flutter/material.dart';

class HealthTipsDetials extends StatelessWidget {
  const HealthTipsDetials({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MedicalTipModel medicalTips = ModalRoute.of(context).settings.arguments as MedicalTipModel;
    return Scaffold(
     appBar: AppBar(title: Text('বিস্তারিত')),
      drawer: DrawerWidget(),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(11),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(medicalTips.title,style: TextStyle(fontSize : 22,fontWeight: FontWeight.bold),),
                ),
              ),
              Flexible(
                flex: 9,
                child: SingleChildScrollView(
                  child: Container(
                    child : Text(medicalTips.details)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}