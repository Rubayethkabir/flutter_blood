import 'dart:convert';

import 'package:TenTwelveBlood/src/applications/base_url.dart';
import 'package:TenTwelveBlood/src/applications/state/configuration/configuration_state.dart';
import 'package:TenTwelveBlood/src/elements/DrawerWidget.dart';
import 'package:TenTwelveBlood/src/models/user.dart';
import 'package:TenTwelveBlood/src/pages/blood_group.dart';
import 'package:TenTwelveBlood/src/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../controllers/user_controller.dart';
import '../repository/user_repository.dart' as userRepo;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends StateMVC<Dashboard> {
  // Start for suggestion data ///
  TextEditingController suggestion = new TextEditingController();
  final _suggestionFormKey = GlobalKey<FormState>();
  _submitSuggestion(String suggestionText) {
    storeSuggestionData(suggestionText);
  }

  Future<void> storeSuggestionData(String suggestionText) async {
    User user = await userRepo.getCurrentUser();
    Map data = {'details': suggestionText, 'userId': user.id};
    _suggestionFormKey.currentState.reset();
    Navigator.of(context).pop();
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.green));

    final String apiUrl = BASE_URL + '/api/user-suggestion-text';
    final String _apiToken = userRepo.currentUser.value.apiToken;

    try {
      var response = await http.post(apiUrl,
          headers: {"Content-type" : "application/json", "Authorization": "Bearer " + _apiToken},
          body: json.encode(data));

      if (response.statusCode == 200) {
        Loader.hide();

        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "Thank you for your feedback",
          ),
        );
      } else {
        Loader.hide();
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: 'Something went wrong, Please contact with system admin',
          ),
        );
      }
    } catch (e) {
      Loader.hide();
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: 'Something went wrong, Please contact with system admin',
        ),
      );
      //there is error during converting file image to base64 encoding.
    }
  }
  // End for suggestion data ///

  UserController _con;
  final _configureState = RM.get<ConfigurationState>();

  _DashboardState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    print(userRepo.currentUser.value.apiToken);
    if (userRepo.currentUser.value.apiToken == null ||
        userRepo.currentUser.value.apiToken == '') {
      Future(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      });
    }
  }

  @override
  void didChangeDependencies() {
    _getConfigureData();
    super.didChangeDependencies();
  }

  void _getConfigureData() {
    _configureState.setState((s) => s.getConfiguration('BLOOD_CONTENT'));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit this App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          resizeToAvoidBottomInset: false,
          key: _con.scaffoldKey,
          drawer: DrawerWidget(),
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.sort, color: Theme.of(context).primaryColor),
              onPressed: () => _con.scaffoldKey?.currentState?.openDrawer(),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).accentColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Shifa Blood Bank',
              style: Theme.of(context).textTheme.headline6.merge(TextStyle(
                  letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
            ),
            actions: <Widget>[
              // new ShoppingCartButtonWidget(iconColor: Theme.of(context).primaryColor, labelColor: Theme.of(context).hintColor),
            ],
          ),
          body: Column(
            children: <Widget>[
              Flexible(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: BloodGroup(),
                  )),
              Flexible(
                  flex: 12,
                  child: StateBuilder<ConfigurationState>(
                    observe: () => _configureState,
                    builder: (context, model) {
                      String bloodContent = model.state.getBloodContent;
                      return (bloodContent != null)
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: ListView(children: <Widget>[
                                Text(
                                  bloodContent,
                                  textAlign: TextAlign.justify,
                                ),
                              ]),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.pink,
                              ),
                            );
                    },
                  )),
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
                            key: _suggestionFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: suggestion,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    maxLength: 1000,
                                    decoration: InputDecoration(
                                        labelText: "অভিযোগ/পরামর্শ"),
                                    validator: (value) {
                                      if (value.length == 0) {
                                        return 'দয়া করে মতামত দিন ';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) {},
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RaisedButton(
                                    child: Text("Submit"),
                                    onPressed: () {
                                      if (_suggestionFormKey.currentState
                                          .validate()) {
                                        _suggestionFormKey.currentState.save();
                                        _submitSuggestion(suggestion.text);
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
            label: Text('অভিযোগ/পরামর্শ', style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
            icon: Icon(Icons.comment),
            backgroundColor: Colors.pink,
          ),
        ));
  }
}
