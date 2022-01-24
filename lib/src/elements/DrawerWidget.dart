import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  _DrawerWidgetState() : super() {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              currentUser.value.apiToken != null
                  ? Navigator.of(context).pushNamed('/Profile')
                  : Navigator.of(context).pushNamed('/Login');
            },
            child: currentUser.value.apiToken != null
                ? UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    accountName: Text(
                      currentUser.value.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    accountEmail: Text(
                      currentUser.value.email,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      backgroundImage: NetworkImage((currentUser
                                  .value.picture.length >
                              0)
                          ? currentUser.value.picture
                          : 'https://jim.pakundia.me/images/common/user.png'),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 32,
                          color: Theme.of(context).accentColor.withOpacity(1),
                        ),
                        SizedBox(width: 30),
                        Text(
                          'guest',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Dashboard');
            },
            leading: Icon(
              Icons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/UserProfile');
            },
            leading: Icon(
              Icons.supervised_user_circle,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),

          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Health');
          //     // Navigator.pushNamed(context, routeName);
          //   },
          //   leading: Icon(
          //     Icons.medical_services,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Health',
          //     style: Theme.of(context).textTheme.subtitle1,
          //   ),
          // ),

          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed('/Favorites');
            },
            leading: Icon(
              Icons.favorite,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Favorite',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              // Navigator.of(context).pushNamed('/Objective');
            },
            leading: Icon(
              Icons.games_outlined,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Objective',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/AboutUs');
            },
            leading: Icon(
              Icons.ad_units_rounded,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'About Us',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Dedicated');
            },
            leading: Icon(
              Icons.face,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Dedicated',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              'Application preferences',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),

          ListTile(
            onTap: () {
              if (currentUser.value.apiToken != null) {
                Navigator.of(context).pushNamed('/Settings');
              }
            },
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),

          ListTile(
            onTap: () {
              if (Theme.of(context).brightness == Brightness.dark) {
                setBrightness(Brightness.light);
                setting.value.brightness.value = Brightness.light;
              } else {
                setting.value.brightness.value = Brightness.dark;
                setBrightness(Brightness.dark);
              }
              setting.notifyListeners();
            },
            leading: Icon(
              Icons.brightness_6,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              Theme.of(context).brightness == Brightness.dark
                  ? 'Light Mode'
                  : 'Dark Mode',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            onTap: () {
              if (currentUser.value.apiToken != null) {
                logout().then((value) {
                  Navigator.of(context).pushNamed('/SignIn');
                });
              } else {
                Navigator.of(context).pushNamed('/SignIn');
              }
            },
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'SignOut',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
