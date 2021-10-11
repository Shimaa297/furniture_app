import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/help/constants/styles.dart';
import 'constants/constant.dart';
import 'constants/help.dart';

class ImageWidget extends StatelessWidget {
  final File image;
  final ValueChanged<ImageSource> onClicked;
  const ImageWidget({
    Key key,
    @required this.image,
    @required this.onClicked,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          buildImage(context),
          helpIconButton(
            ColorsApp.primaryColor,
            BoxShape.circle,
            () async {
              final source = await showImageSource(context);
              if (source == null) return;
              onClicked(source);
              showImageSource(context);
            },
            Icons.add_a_photo_outlined,
            ColorsApp.defTextColor,
          )
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final imagePath = this.image.path;
    final image = imagePath.contains('http://')
        ? helpImage('${user.photoURL}', 200)
        : FileImage(File(imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 150,
          height: 150,
          child: InkWell(
            onTap: () async {
              final source = await showImageSource(context);
              if (source == null) return;

              onClicked(source);
            },
          ),
        ),
      ),
    );
  }

  static Future<ImageSource> showImageSource(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                  leading: Icon(Icons.camera_alt),
                  title: Text(
                    'Camera',
                    style: BodyTextStyle,
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  leading: Icon(Icons.photo),
                  title: Text(
                    'Gallery',
                    style: BodyTextStyle,
                  ),
                )
              ],
            ));
  }
}

class ImagePickerApp extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();

  pickImage({ImageSource source}) {}
}

class _ImagePickerState extends State<ImagePickerApp> {
  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final _pickImage = await picker.pickImage(source: ImageSource.camera);
    Navigator.pop(context);
    setState(() {
      if (_pickImage != null) {
        _image = File(_pickImage.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  Future getImageFromGallery() async {
    final _pickImage = await picker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context);
    setState(() {
      if (_pickImage != null) {
        _image = File(_pickImage.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 60,
        backgroundColor: Colors.white,
        child: _image == null
            ? CircleAvatar(
                backgroundColor: ColorsApp.col,
                radius: 40,
                child: InkWell(
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: getImageFromCamera,
                                leading: Icon(Icons.camera_alt),
                                title: Text(
                                  'Camera',
                                  style: BodyTextStyle,
                                ),
                              ),
                              ListTile(
                                onTap: getImageFromGallery,
                                leading: Icon(Icons.photo),
                                title: Text(
                                  'Gallery',
                                  style: BodyTextStyle,
                                ),
                              )
                            ],
                          )),
                  child: Icon(Icons.add_a_photo_outlined),
                ),
              )
            : CircleAvatar(
                radius: 70,
                child: Image.file(
                  _image,
                  fit: BoxFit.contain,
                ),
              ));
  }
}
