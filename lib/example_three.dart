import 'dart:convert';

import 'package:api_handling/Models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  
  List<UserModel> userList = [];
  
  Future<List<UserModel>> getUserList() async
  {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    
    if(response.statusCode == 200)
      {
        for(Map i in data)
          {
            userList.add(UserModel.fromJson(i));
          }
        return userList;
      }
    else
      {
        return userList;
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
              future: getUserList(),
              builder: (context, AsyncSnapshot <List<UserModel>> snapshot)
              {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index)
                  {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ReusableRow(title: "name", value: snapshot.data![index].name.toString()),
                            ReusableRow(title: "username", value: snapshot.data![index].username.toString()),
                            ReusableRow(title: "email", value: snapshot.data![index].email.toString()),
                            ReusableRow(title: "address", value: snapshot.data![index].address!.city.toString()),
                          ],
                        ),
                      ),
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

class ReusableRow extends StatelessWidget {

  String title, value;

  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}

