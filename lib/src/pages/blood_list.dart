import 'package:TenTwelveBlood/src/applications/state/blood/blood_state.dart';
import 'package:TenTwelveBlood/src/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodList extends StatefulWidget {
  final int groupIndex;
  final String groupName;
  BloodList({Key key, this.groupIndex, this.groupName}) : super(key: key);

  @override
  _BloodListState createState() => _BloodListState();
}

class _BloodListState extends State<BloodList> {
  bool isSearching = false;
  String searchValue = '';
  void _getDataBySearchValue() {
    _getBloodList(widget.groupName, this.searchValue);
  }

  void initState(){
    super.initState();
  }


  ScrollController _scrollController;
  final _bloodStateRM = RM.get<BloodState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getBloodList(widget.groupName, this.searchValue);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !_bloodStateRM.state.loading) {
        _getBloodList(widget.groupName, this.searchValue);
      }
    });
  }

  void _getBloodList(String groupName, String searchValue) {
    _bloodStateRM.setState(
        (bloodState) => bloodState.getAllBloodList(groupName, searchValue));
  }

  @override
  void dispose() {  
    this.searchValue = "";
    _bloodStateRM.setState((s) => s.setStateClear());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text("Blood Donar List", style: TextStyle(color: Colors.white))
            : Container(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      this.searchValue = value;
                    });
                    if(value.length > 2){
                      _getDataBySearchValue();
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Search By Zone",
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      focusColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ),
        backgroundColor: Colors.pink,
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Theme.of(context).focusColor,
                  ),
                  color: Colors.yellowAccent,
                  tooltip: 'Cancel',
                  onPressed: () {
                    
                    setState(() {
                      this.isSearching = false;
                      this.searchValue = "";
                    });

                    _getDataBySearchValue();

                    // if (this.searchValue.length > 0) {
                    //   Loader.show(context,
                    //       progressIndicator: CircularProgressIndicator(
                    //         backgroundColor: Colors.red,
                    //       ),
                    //       themeData: Theme.of(context)
                    //           .copyWith(accentColor: Colors.green));
                    //   _getDataBySearchValue();
                     
                    // } else {
                    //   setState(() {
                    //     this.isSearching = false;
                    //   });
                    // }
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  color: Theme.of(context).focusColor,
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: Container(
        child: StateBuilder<BloodState>(
          observe: () => _bloodStateRM,
          builder: (context, model) {
            return (model.state.bloodList.length > 0)
                ? ListView(
                    controller: _scrollController,
                    children: <Widget>[
                      ...model.state.bloodList.map((blood) => Column(
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage((blood
                                                .picture.length >
                                            0)
                                        ? blood.picture
                                        : 'https://jim.pakundia.me/images/common/user.png')),
                                title: Text((blood.name.length > 0)
                                    ? capitalize(blood.name)
                                    : 'N/A'),
                                subtitle: Text(((blood.zone.length > 0)
                                        ? capitalize(blood.zone)
                                        : 'N/A') +
                                    ", " +
                                    blood.bloodGroup),
                                trailing: _ListPopupMenu(context, blood),
                              )
                            ],
                          ))
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                    ),
                  );
          },
        ),
      ),
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

dynamic _ListPopupMenu(context, blood) {
  var mobile = blood.mobile;
  return PopupMenuButton(
      offset: Offset(0, 35),
      onSelected: (value) async {
        switch (value) {
          case 'call':
            if (await canLaunch("tel:0$mobile")) {
              await launch("tel:0$mobile");
            }
            break;
          case 'sms':
            if (await canLaunch("sms:0$mobile")) {
              await launch("sms:0$mobile");
            }
            break;
          case 'view':
            // const url = 'https://www.bbc.com/bengali/news-44485273';
            // if (await canLaunch(url)) {
            //   await launch(url);
            // } else {
            //   throw 'Could not launch $url';
            // }
            // Navigator.pushNamed(context, profileViewRoute);
            //  Navigator.of(context).pushReplacementNamed('/ProfilePage', {'profiledata' : blood });

            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                settings: const RouteSettings(name: '/ProfilePage'),
                builder: (context) => new ProfilePage(profileData: blood)));

            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
              value: 'call',
              child: Row(children: <Widget>[
                Icon(Icons.phone),
                SizedBox(width: 10),
                Text("Call")
              ])),
          PopupMenuItem(
              value: 'sms',
              child: Row(children: <Widget>[
                Icon(Icons.sms),
                SizedBox(width: 10),
                Text("SMS")
              ])),
          PopupMenuItem(
              value: 'view',
              child: Row(children: <Widget>[
                Icon(Icons.remove_red_eye),
                SizedBox(width: 10),
                Text("View")
              ]))
        ];
      });
}
