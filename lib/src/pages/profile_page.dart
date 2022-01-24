import 'package:TenTwelveBlood/src/applications/classes/blood/blood.dart';
import 'package:TenTwelveBlood/src/pages/blood_list.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Blood profileData;
  ProfilePage({Key key, this.profileData}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,),
      body: Column(
        children: [
          Flexible(
            flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.deepOrange, Colors.pinkAccent]
                    )
                ),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            profileData.picture ?? "https://img.dtnext.in/Articles/2021/Apr/202104061917157803_Katrina-Kaif-tests-positive-for-Covid19_SECVPF.gif",
                          ),
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                           profileData.name ?? 'N/A',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                           profileData.zone ?? 'N/A',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
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
                                        profileData.bloodGroup ?? 'N/A',
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
                                        profileData.lastDate ?? "N/A",
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
                                        profileData.diffDays ?? 
                                        "N/A",
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
                )
            ),
          ),
          Flexible(
            flex: 5,
              child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Short Note:",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 200,
                        child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                          child:
                            Text(profileData.shortNote ?? 'N/A',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 200.00,
            child: RaisedButton(
                onPressed: (){},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)
                ),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.pink,Colors.pinkAccent]
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BloodList(
                        groupIndex: 11,
                        groupName: profileData.bloodGroup)));
                    },
                      child: Container(
                      constraints: BoxConstraints(maxWidth: 200.0, minHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text("Go back",
                        style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight:FontWeight.bold),
                      ),
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
