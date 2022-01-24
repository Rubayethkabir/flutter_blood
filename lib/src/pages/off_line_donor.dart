import 'dart:convert';

import 'package:flutter/material.dart';

class Offlinedonor extends StatefulWidget {
  
  @override
  _OfflinedonorState createState() => _OfflinedonorState();
}

class _OfflinedonorState extends State<Offlinedonor> {
  List data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Offline Donor List', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Navigator.of(context).pushNamed('/SignIn')
            },
          ), 
        ),

        body: Center(
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/loadjson/donor.json'),
            builder: (context, snapshot) {
              // Decode the JSON
              var newData = json.decode(snapshot.data.toString());

              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14, bottom: 14, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                },
                                child: Text(
                                  newData[index]['name'],
                                  //'Note Title',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Text(
                                newData[index]['currentZone']+', '+newData[index]['contact'],
                                //'Note Text',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                          Container(
                            child: Text(
                              newData[index]['bloodGroup'],
                              //'Note Text',
                              style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold,fontSize: 14),
                            ),
                          ),
                          //SizedBox(width: 20),
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              'https://jim.pakundia.me/images/common/user.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: newData == null ? 0 : newData.length,
              );
            },
          ),
        ));
  }
}