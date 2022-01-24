import 'dart:io';
import 'package:TenTwelveBlood/src/applications/base_url.dart';
import 'package:TenTwelveBlood/src/models/user.dart';
import 'package:TenTwelveBlood/src/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/user_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../repository/user_repository.dart' as userRepo;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ChangePicture extends StatefulWidget {
  ChangePicture() : super();

  final String title = "Upload Image Demo";
  @override
  _ChangePictureState createState() => _ChangePictureState();
}

class _ChangePictureState extends StateMVC<ChangePicture> {
  GlobalKey<ScaffoldState> scaffoldKey;

  _ChangePictureState() : super(UserController()) {}

  File _image;

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            key: scaffoldKey,
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  Future<void> uploadImage() async {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        themeData: Theme.of(context).copyWith(accentColor: Colors.green));
    dynamic userInfo;

    final String uploadurl = BASE_URL + '/api/image-upload';
    final String _apiToken = userRepo.currentUser.value.apiToken;

    User user = await userRepo.getCurrentUser();

    try {
      List<int> imageBytes = _image.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      // convert file image to Base64 encoding
      var response = await http.post(uploadurl,
          headers: {"Authorization": "Bearer " + _apiToken},
          body: {'picture': baseimage, 'user_id': user.id});

      if (response.statusCode == 200) {
        Loader.hide();
        setCurrentUser(response.body);
        currentUser.value = User.fromJSON(json.decode(response.body)['data']);

        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "Image upload successfully",
          ),
        );
      } else {
        Loader.hide();
        var errorMessage =
            'Something went wrong, Please contact with system admin';
        if (json.decode(response.body)['errors'] != '') {
          errorMessage = json.decode(response.body)['errors'];
        }
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: errorMessage,
          ),
        );

        //there is error during connecting to server,
        //status code might be 404 = url not found
      }
    } catch (e) {
      print(e);
      Loader.hide();
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: 'Error during converting to Base64',
        ),
      );
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image Edit',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.deepOrange,
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: RaisedButton.icon(
              onPressed: () {
                _showPicker(context);
                // chooseImage(); // call choose image function
              },
              icon: Icon(Icons.folder_open),
              label: Text("CHOOSE IMAGE"),
              color: Colors.deepOrangeAccent,
              colorBrightness: Brightness.dark,
            ),
          ),
          Container(
              //show upload button after choosing image
              child:
                  //if uploadimage is null then show empty container
                  Container(
                      //elese show uplaod button
                      child: RaisedButton.icon(
            onPressed: () {
              uploadImage();
              //start uploading image
            },
            icon: Icon(Icons.file_upload),
            label: Text("UPLOAD IMAGE"),
            color: Colors.deepOrangeAccent,
            colorBrightness: Brightness.dark,
            //set brghtness to dark, because deepOrangeAccent is darker coler
            //so that its text color is light
          ))),
        ],
      ),
    );
  }
}
