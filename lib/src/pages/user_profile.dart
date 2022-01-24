import 'package:TenTwelveBlood/src/controllers/short_note_controller.dart';
import 'package:TenTwelveBlood/src/elements/DrawerWidget.dart';
import 'package:TenTwelveBlood/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends StateMVC<UserProfile> {
  GlobalKey<FormState> _shortNoteFormKey = new GlobalKey<FormState>();

  ShortNoteController _con;

  _UserProfileState() : super(ShortNoteController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _con.shortNoteScaffoldKey,
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          Flexible(
            flex: 6,
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.deepOrange, Colors.pinkAccent])),
                child: Container(
                  width: double.infinity,
                  // height: 350.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage((currentUser
                                      .value.picture.length >
                                  0)
                              ? currentUser.value.picture
                              : 'https://jim.pakundia.me/images/common/user.png'),
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        
                        Text(
                          (currentUser.value.name.length > 0)
                              ? currentUser.value.name
                              : 'N/A',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton.icon(
                          onPressed: (){
                            Navigator.of(context).pushNamed('/Settings');
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).focusColor,
                          ),
                          label: Text('Edit Profile',style: TextStyle(color: Colors.pink),),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Blood",
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        (currentUser.value.blood.length > 0)
                                            ? currentUser.value.blood
                                            : 'N/A',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.pinkAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Last Date",
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        (currentUser.value.lastBloodGivenDate
                                                    .length >
                                                0)
                                            ? currentUser
                                                .value.lastBloodGivenDate
                                            : "N/A",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.pinkAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Difference",
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        (currentUser.value.diffDays.length > 0)
                                            ? currentUser.value.diffDays
                                            : "N/A",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.pinkAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          Flexible(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView(children: <Widget>[
                Text('Short Note :',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent)),
                Text(
                    (currentUser.value.shortNote.length > 0)
                        ? currentUser.value.shortNote
                        : 'Please add you comment by clickig plus button',
                    textAlign: TextAlign.justify),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        key: _shortNoteFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                // controller: suggestion,
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                maxLength: 1000,
                                decoration: InputDecoration(
                                    labelText: "Add short note"),
                                validator: (value) {
                                  if (value.length == 0) {
                                    return 'Please add some short note';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  currentUser.value.shortNote = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Submit"),
                                onPressed: () {
                                
                                  if(_shortNoteFormKey.currentState.validate()) {
                                    _shortNoteFormKey.currentState.save();
                                    _con.storeNote(currentUser.value.shortNote);
                                  }
                                
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        // child: Icon(Icons.add),
        label: Text('Short Note', style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
        icon: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
