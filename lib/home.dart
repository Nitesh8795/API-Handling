import 'dart:convert';

import 'package:api_handling/Models/PostsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<PostsModel> postApi = [];
  
  Future<List<PostsModel>> getPostApi() async
  {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    
    if(response.statusCode == 200)
      {
        postApi.clear();
        
        for(Map i in data)
          {
            postApi.add(PostsModel.fromJson(i));
          }
        
        return postApi;
      }
    else
      {
        return postApi;
      }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Handlling"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot)
              {
                if(!snapshot.hasData)
                  {
                    return Text("Loading............");
                  }
                else
                  {
                    return ListView.builder(
                      itemCount: postApi.length,
                      itemBuilder: (context, index)
                      {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                Text(postApi[index].title.toString()),
                                SizedBox(height: 5,),
                                Text("Body",style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                Text(postApi[index].body.toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
              },
            ),
          )
        ],
      ),
    );
  }
}
