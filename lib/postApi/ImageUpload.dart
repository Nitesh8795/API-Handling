import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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

  Future<void> uploadImage() async
  {
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    var uri = Uri.parse("https://fakestoreapi.com/products");
    var request = new http.MultipartRequest("POST", uri);

    request.fields["title"] = "static title";

    var multiport = new http.MultipartFile("image", stream, length);

    request.files.add(multiport);

    var response = await request.send();

    if(response.statusCode == 200)
      {
        setState(() {
          showSpinner = false;
        });
        print("Image uploaded succesfully");
      }
    else
      {
        setState(() {
          showSpinner = false;
        });
        print("Image not uploaded ");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Uploader"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
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
            const SizedBox(
              height: 60,
            ),

            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(17)),
                child: Center(child: const Text("Upload", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
