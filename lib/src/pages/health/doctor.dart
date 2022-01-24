import 'package:TenTwelveBlood/src/applications/classes/images.dart';
import 'package:TenTwelveBlood/src/applications/state/doctor/doctor_state.dart';
import 'package:TenTwelveBlood/src/elements/DrawerWidget.dart';
import 'package:TenTwelveBlood/src/pages/health/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Doctor extends StatefulWidget {
  const Doctor({Key key}) : super(key: key);

  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  ScrollController _scrollController;
  final _doctorState = RM.get<DoctorState>();

  @override
  void didChangeDependencies() {
    _getAllDoctorList();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_doctorState.state.loading) {
        _getAllDoctorList();
      }
    });
    super.didChangeDependencies();
  }

  void _getAllDoctorList() {
    _doctorState.setState((s) => s.getAllDoctorList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ডাক্তার সমূহ")),
      drawer: DrawerWidget(),
      body: Container(
          child: StateBuilder(
        observe: () => _doctorState,
        builder: (context, model) {
          return (model.state.doctorList.length > 0) ? Padding(
            padding: EdgeInsets.all(3),
            child: ListView(
              controller: _scrollController,
              children: <Widget>[
                ...model.state.doctorList.map((e) => 
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                  child: GestureDetector(
                      onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorDetails(doctor:e)));
                      },
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 7),
                            Image.network(
                              e.picture ?? Images.defaultImage,
                              height: 180,
                              width: 220,
                            ),
                            Text(e.name),
                            Text('Jahid Hasan Shovo'),
                            Text('MBBS , FCPS'),
                            SizedBox(height: 7),
                          ],
                        ),
                      )),
                ),
                )
              ],
            ),
          ) : Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,),);
        },
      )),
    );
  }
}
