import 'package:TenTwelveBlood/src/pages/blood_list.dart';
import 'package:flutter/material.dart';

class BloodGroup extends StatelessWidget {
  final List<dynamic> bloodGroupList = [
    {'name': "A+"},
    {'name': "B+"},
    {'name': "O+"},
    {'name': "AB+"},
    {'name': "A-"},
    {'name': "B-"},
    {'name': "O-"},
    {'name': "AB-"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 4,
        children: List.generate(bloodGroupList.length, (index) {
          return Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BloodList(
                        groupIndex: index + 1,
                        groupName: bloodGroupList[index]['name'])));
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                  color: Colors.red,
                  elevation: 10,
                  child: Center(
                    child: Text(
                      bloodGroupList[index]['name'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
