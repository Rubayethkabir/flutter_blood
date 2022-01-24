import 'package:flutter/material.dart';

class Dedicated extends StatelessWidget {
  const Dedicated({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("উৎসর্গ",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),backgroundColor: Colors.deepOrange,),
      body: Center(
        child: Padding(padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("বন্ধু রুবায়েত কবির সাগর সহ আমার সকল বন্ধু বান্ধব দের জন্য উৎসর্গ করলাম ...",style: TextStyle(fontSize: 26,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
              Text("[ আবদুল্লাহ আল হাসান জিম ]",style: TextStyle(fontSize: 16,color: Colors.deepOrange,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}