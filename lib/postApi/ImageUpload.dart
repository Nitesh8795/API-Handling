import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({Key? key}) : super(key: key);

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async
  {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if(pickedImage != null)
      {
        image = File(pickedImage.path);
        setState(() {

        });
      }
    else
      {
        print("no image selected");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Uploader"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null
                    ? const Text("Pick A Image", style: TextStyle(fontSize: 25),)
                    : Padding(
                  padding: EdgeInsets.all(4.0),
                      child: Container(
                          child: Center(
                            child: Image.file(
                              File(image!.path),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
