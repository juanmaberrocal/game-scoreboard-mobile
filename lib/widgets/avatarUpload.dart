// flutter
import 'package:flutter/material.dart';
// dependencies
import 'package:image_picker/image_picker.dart';
// app
import 'package:game_scoreboard/helpers/gsSnackBar.dart';


class AvatarUpload extends StatelessWidget {
  AvatarUpload({
    Key key,
    @required this.uploadFunction,
    this.screenContext,
    this.screenScaffold,
  }) : super(key: key);

  final Function uploadFunction;
  final BuildContext screenContext;
  final GlobalKey<ScaffoldState> screenScaffold;

  void _uploadAvatar(image) {
    // ensure user didn't cancel out
    if (image != null) {
      Navigator.pop(screenContext);
      uploadFunction(
//        param: 'avatar',
        file: image,
      ).then((_) {
        GSSnackBar(screenScaffold: screenScaffold.currentState)
          ..success('Avatar updated!',);
      }).catchError((error) {
        GSSnackBar(screenScaffold: screenScaffold.currentState)
          ..error('There was an error updating your avatar!',);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Upload Avatar'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            GestureDetector(
              child: Text('Take a Picture'),
              onTap: () async {
                var image = await ImagePicker.pickImage(source: ImageSource.camera);
                _uploadAvatar(image);
              },
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            GestureDetector(
              child: Text('Select from Gallery'),
              onTap: () async {
                var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                _uploadAvatar(image);
              },
            ),
          ],
        ),
      ),
    );
  }
}