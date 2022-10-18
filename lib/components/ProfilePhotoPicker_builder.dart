import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../viewmodels/user_view_model.dart';

class ProfilePhotoPicker extends StatefulWidget {
  @override
  State createState() => new ProfilePhotoPickerState();
}

class ProfilePhotoPickerState extends State<ProfilePhotoPicker> {
  @override
  void initState() {
    super.initState();
  }

  Image? _image;
  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();
    _image = userViewModel.userModel.getCurrentImage();
    print("PROFILEPHOTOPICKER SETTINGS");
    print(_image);
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _pickImage(ImageSource.gallery, userViewModel);
        },
        child: Container(
            width: 145,
            height: 145,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/UserAvatarIcon.png"),
                    fit: BoxFit.fill)),
            child: _image == null
                ? Text("")
                : CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.greenAccent,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: _image!.image,
                      radius: 70,
                    ))));
  }

  Future _pickImage(ImageSource source, UserViewModel userViewModel) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      userViewModel.updateProfilePhoto(img);
      convertFileToImage(img);
    });
  }

  void convertFileToImage(File? picture) async {
    List<int> imageBase64 = picture!.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    print(Image.memory(uint8list));
    _image = Image.memory(uint8list);
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}
