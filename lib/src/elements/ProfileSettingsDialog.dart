import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

import '../models/user.dart';

class ProfileSettingsDialog extends StatefulWidget {
  final User user;
  final VoidCallback onChanged;

  ProfileSettingsDialog({Key key, this.user, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  final List<Map<String, dynamic>> _items = [
  {
    'value': 'A+',
    'label': 'A positive (A+)',
  },
  {
    'value': 'A-',
    'label': 'A negetive (A-)',
  },
  {
    'value': 'B+',
    'label': 'B positive (B+)',
  },
  {
    'value': 'B-',
    'label': 'B positive (B-)',
  },
  {
    'value': 'O+',
    'label': 'O positive (O+)',
  },
  {
    'value': 'O-',
    'label': 'O positive (O-)',
  },
  {
    'value': 'AB+',
    'label': 'AB positive (AB+)',
  },
  {
    'value': 'AB-',
    'label': 'AB positive (AB-)',
  },
];

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text(
                      'Profile settings',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'Mr Jim', labelText: 'Full Name'),
                          initialValue: widget.user.name,
                          validator: (input) => input.trim().length < 3 ? 'Not a valid full name' : null,
                          onSaved: (input) => widget.user.name = input,
                        ),
                      
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.number,
                          decoration: getInputDecoration(hintText: '01*********', labelText: 'Blood Contact Number'),
                          initialValue: widget.user.bloodContactNumber,
                          validator: (input) => input.trim().length != 11 ? 'Not a valid mobile' : null,
                          onSaved: (input) => widget.user.bloodContactNumber = input,
                        ),

                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'Kishoregonj', labelText: 'Zone'),
                          initialValue: widget.user.zone,
                          validator: (input) => input.trim().length < 3 ? 'Not a valid zone' : null,
                          onSaved: (input) => widget.user.zone = input,
                        ),
                        SelectFormField(
                          // type: SelectFormField., // or can be dialog
                          initialValue: widget.user.blood ?? 'A+',
                          icon: Icon(Icons.format_shapes),
                          labelText: 'Blod Group',
                          items: _items,
                          onChanged: (val) => print(val),
                          onSaved: (input) => widget.user.blood = input,
                        ),
                        
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel'),
                      ),
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          'save',
                          style: TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Icon(Icons.edit),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      widget.onChanged();
      Navigator.pop(context);
    }
  }
}
