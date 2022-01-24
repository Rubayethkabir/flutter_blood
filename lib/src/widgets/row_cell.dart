import 'package:flutter/material.dart';

Widget firstRowCell(BuildContext context, String imageUrl, String routeName) {
  return Container(
    width: MediaQuery.of(context).size.width / 2 - 4,
    height: MediaQuery.of(context).size.height / 6,
    child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.fill,
                )),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
  );
}

Widget fullRow(BuildContext context, String imageUrl, String routeName) {
  return Container(
    width: MediaQuery.of(context).size.width - 12,
    height: MediaQuery.of(context).size.height / 4,
    child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.fill,
                )),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
  );
}

Widget secondRowCell(BuildContext context, String imageUrl, String routeName) {
  return Container(
    width: MediaQuery.of(context).size.width / 3 - 4,
    height: MediaQuery.of(context).size.height / 8,
    child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 3),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.fill,
                )),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
  );
}

Widget firstRowCellName(
    BuildContext context, String name, String routeName, MaterialColor colors) {
  return Container(
    width: MediaQuery.of(context).size.width / 2 - 4,
    height: MediaQuery.of(context).size.height / 6,
    child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colors ?? Colors.pink),
                  )),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
  );
}

Widget firstRowCellNameImage(BuildContext context, String imageUrl, String name,
    String routeName, MaterialColor colors) {
  return Container(
    width: MediaQuery.of(context).size.width / 2 - 4,
    height: MediaQuery.of(context).size.height / 6,
    child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      child: Image.network(
                        imageUrl,
                        height: 80,
                        width: 120,
                        fit: BoxFit.fill,
                      )),
                ),
                Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: colors ?? Colors.pink),
                      )),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
  );
}

Widget singleProfileElement(BuildContext context,String label,String userData) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
    child: Container(
      height: 40.00,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.00),
        color: Colors.blueAccent,
      ),
      child: Center(
        child: Text(label +
          userData ?? 'N/A',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}
