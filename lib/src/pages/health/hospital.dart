import 'package:TenTwelveBlood/src/applications/state/hospital/hospital_state.dart';
import 'package:TenTwelveBlood/src/elements/DrawerWidget.dart';
import 'package:TenTwelveBlood/src/pages/health/hospital_details.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Hospital extends StatefulWidget {
  const Hospital({Key key}) : super(key: key);

  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {

  ScrollController _scrollController;
  final _hospitalState = RM.get<HospitalState>();

  @override
  void didChangeDependencies() {
    _getAllHospitalList();
    _scrollController = ScrollController();
    _scrollController.addListener(() { 
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_hospitalState.state.loading) {
        _getAllHospitalList();
      }
    });
    super.didChangeDependencies();
  }

  void _getAllHospitalList(){
    _hospitalState.setState((s) => s.getAllHospitalList());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('হাস্পাতাল/ক্লিনিক এর তালিকা',style: TextStyle(fontSize: 16),)),
      drawer: DrawerWidget(),
      body: Container(
        child: StateBuilder<HospitalState>(
          observe: () => _hospitalState,
          builder: (context,model) {
            return (model.state.hospitalList.length > 0) ? Padding(
              padding: EdgeInsets.all(4),
              child: ListView(
                controller: _scrollController,
                children: <Widget>[
                  ...model.state.hospitalList.map((e) => 
                    ListTile(
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HospitalDetails(hospital: e)))
                      },
                      leading: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            image : DecorationImage(image: NetworkImage(e.picture ?? 'https://sgp1.digitaloceanspaces.com/cosmosgroup/news/3369687_New%20Project%20(1).jpg'),fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(8)
                          ),
                        ),
                      title: Text(e.name),
                      subtitle: Text(e.place),
                      trailing:  IconButton(
                        icon: Icon(Icons.arrow_right),
                        onPressed: () {},
                      ),
                    )
                  )
                ],
              ),
            ) :  Center(child: CircularProgressIndicator(backgroundColor: Colors.pink,),);
          },
        )
      )
    );
  }
}