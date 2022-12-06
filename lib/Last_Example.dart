import 'dart:convert';
import 'package:api_handling/Models/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LastExample extends StatefulWidget {
  const LastExample({Key? key}) : super(key: key);

  @override
  State<LastExample> createState() => _LastExampleState();
}

class _LastExampleState extends State<LastExample> {

  Future<ProductModel> getProduct() async
  {
    final response = await http.get(Uri.parse("https://webhook.site/34f58c7c-445e-4922-afb6-408a7c079da0"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200)
      {
        return ProductModel.fromJson(data);
      }
    else
      {
        return ProductModel.fromJson(data);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Handling"),),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(
              future: getProduct(),
              builder: (context, snapshot)
              {
                if(!snapshot.hasData)
                  {
                    return Text("Loading..........");
                  }
                else
                  {
                    return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index)
                      {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*1,
                              height: MediaQuery.of(context).size.height*0.3,
                              child: ListView.builder(
                                itemCount: snapshot.data!.data![index].products![index].images!.length,
                                itemBuilder: (context, position)
                                {
                                  return Container(
                                    height: MediaQuery.of(context).size.height*0.25,
                                    width: MediaQuery.of(context).size.width*0.5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot.data!.data![index].products![index].images![position].url.toString()))
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
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
