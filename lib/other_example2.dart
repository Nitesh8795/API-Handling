import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class photos_req extends StatefulWidget {
  const photos_req({Key? key}) : super(key: key);

  @override
  State<photos_req> createState() => _photos_reqState();
}

class _photos_reqState extends State<photos_req> {

  List<Photos> photoList = [];

  Future<List<Photos>> getPhotos() async
  {
    final response = await http.get(Uri.parse("uri"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200)
      {
        photoList.clear();

        for(Map i in data)
          {
            Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
            photoList.add(photos);
          }

        return photoList;
      }
    else
      {
        return photoList;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Photos
{
  String ? title, url;
  int ? id;

  Photos({required this.title, required this.url, required this.id});
}
