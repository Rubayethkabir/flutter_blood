import 'package:TenTwelveBlood/src/applications/state/medical_tip/medical_tip_state.dart';
import 'package:TenTwelveBlood/src/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class HealthTips extends StatefulWidget {
  const HealthTips({Key key}) : super(key: key);

  @override
  _HealthTipsState createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  ScrollController _scrollController;
  final _medicalTipStateRM = RM.get<MedicalTipState>();

  @override
  void didChangeDependencies() {
    _getAllMedicalTips();
    
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_medicalTipStateRM.state.loading){
        _getAllMedicalTips();
      }
    });
    super.didChangeDependencies();
  }
  void _getAllMedicalTips(){
    _medicalTipStateRM.setState((s) => s.getAllMedicalTip());
  }

  @override
  Widget build(BuildContext context) {

    return  Container(
       child: StateBuilder<MedicalTipState>(
         observe: () => _medicalTipStateRM,
         builder: (context,model) {
           return (model.state.medicalTipList.length > 0) ? ListView(
             controller: _scrollController,
             children: <Widget>[
               ...model.state.medicalTipList.map((e) => 
                 Padding(
                  padding: EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, medicalTipDetailsRoute, arguments: e);
                    },
                    child: Card(
                      elevation: 8,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                        child: Center(
                          child: Text(e.title.length > 45 ? e.title.substring(0,45) +" ..." : e.title, style: TextStyle(
                          fontSize: 14.0,
                          height: 1.6,
                          color: Colors.blue
                        ),
                        ),
                        ),
                      ),
                    ),
                  )
                )
               )
             ],
           ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,),);
         },
       )
      );
  }
}