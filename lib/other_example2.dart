import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
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
    return Scaffold(
      appBar: AppBar(title: Text("API Handling"),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot <List<Photos>> snapshot)
              {
                return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context, index)
                  {
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].url.toString())),
                      title: Text(snapshot.data![index].title.toString()),
                      subtitle: Text(snapshot.data![index].id.toString()),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Photos
{
  String ? title, url;
  int ? id;

  Photos({required this.title, required this.url, required this.id});
}
