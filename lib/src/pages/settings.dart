import 'package:TenTwelveBlood/src/elements/ChangePasswordDialog.dart';
import 'package:TenTwelveBlood/src/elements/ProfileSettingsDialog.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/settings_controller.dart';
import '../repository/user_repository.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends StateMVC<SettingsPage> {
  SettingsController _con;

  _SettingsPageState() : super(SettingsController()) {
    _con = controller;
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2018, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });
      _con.updateDate(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Settings',
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // child: SearchBarWidget(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            currentUser.value.name,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            currentUser.value.email,
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                        // width: 55,
                        height: 55,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(300),
                          onTap: () {
                            Navigator.of(context).pushNamed('/ChangePicture');
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage((currentUser
                                        .value.picture.length >
                                    0)
                                ? currentUser.value.picture
                                : 'https://jim.pakundia.me/images/common/user.png'),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Icon(Icons.edit),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        'Profile Settings',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      // trailing: Icon(
                      //   Icons.edit
                      // ),
                      trailing: ButtonTheme(
                        padding: EdgeInsets.all(0),
                        child: ProfileSettingsDialog(
                          user: currentUser.value,
                          onChanged: () {
                            _con.update(currentUser.value);
//                                  setState(() {});
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Full Name',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text(
                        currentUser.value.name,
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Mobile',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text(
                        '0'+currentUser.value.mobile,
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    ListTile(
                        onTap: () {},
                        dense: true,
                        title: Text(
                          'Blood Contacat ',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        trailing: Text(
                            (currentUser.value.bloodContactNumber.length > 0)
                                ? '0'+currentUser.value.bloodContactNumber
                                : 'N/A')),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Blood Group',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text((currentUser.value.blood.length > 0)
                          ? currentUser.value.blood
                          : 'N/A'),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Blood Zone',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text((currentUser.value.zone.length > 0)
                          ? currentUser.value.zone
                          : 'N/A'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        'Blood given date',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: ButtonTheme(
                        padding: EdgeInsets.all(0),
                        child: Container(
                            child: InkWell(
                          onTap: () => _selectDate(context),
                          child: Icon(Icons.edit),
                        )),
                        // child: PasswordChangeDialog(),
                      ),
                    ),
                    ListTile(
                      // onTap: () {
                      //   Navigator.of(context).pushNamed('/ChangePassword');
                      // },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            // size: 22,
                            color: Theme.of(context).focusColor,
                          ),
                          SizedBox(
                            height: 20,
                            width: 10,
                          ),
                          Text(
                            (currentUser.value.lastBloodGivenDate.length > 0)
                                ? currentUser.value.lastBloodGivenDate
                                : 'Not given',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      trailing: Text((currentUser.value.diffDays.length > 0)
                          ? currentUser.value.diffDays
                          : '0 days'),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        'Password Settings',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      // onTap: () {
                      //   Navigator.of(context).pushNamed('/ChangePassword');
                      // },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.security,
                            // size: 22,
                            color: Theme.of(context).focusColor,
                          ),
                          SizedBox(height: 10),
                          Text(
                            ' Change Password',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      trailing: ButtonTheme(
                        padding: EdgeInsets.all(0),
                        child: PasswordChangeDialog(
                          user: currentUser.value,
                          onChanged: () {
                            _con.changePassword(currentUser.value);
                          },
                        ),
                        // child: PasswordChangeDialog(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        'App Settings',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        // Navigator.of(context).pushNamed('/Languages');
                      },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.translate,
                            color: Theme.of(context).focusColor,
                          ),
                          SizedBox(height: 10),
                          Text(
                            ' Languages',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      trailing: Text(
                        'English',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
