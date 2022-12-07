import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  TextEditingController ControllerUserId = TextEditingController();
  TextEditingController ControllerPassword = TextEditingController();

  void login(String email, password) async
  {
    try
        {
          Response response = await post(
              Uri.parse("https://reqres.in/api/login"),
              body: {
                "email": email,
                "password": password
              }
          );

          if(response.statusCode == 200)
            {
              print("Login successfull");
            }
          else
            {
              print("Login Unsuccessfull");
            }
        }
        catch(e)
    {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Login Page"),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 4.0),
                  child: Text(
                    "Welcome,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 4.0),
                  child: Text(
                    "Sign in to continue",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100.0, bottom: 4.0),
                  child: TextField(
                    onChanged: (value) {
                      debugPrint("Something changed in textfield");
                    },
                    controller: ControllerUserId,
                    decoration: InputDecoration(
                      labelText: "Login Id",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 4.0),
                  child: TextField(
                    obscureText: true,
                    controller: ControllerPassword,
                    onChanged: (value) {
                      debugPrint("Something changed in textfield");
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      fixedSize: Size(1000, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      login(ControllerUserId.text.toString(), ControllerPassword.text.toString());
                    },
                    child: const Text('Login'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      fixedSize: Size(1000, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Continue With Google',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child:TextButton(
                      onPressed: (){
                        moveToLastScreen(context);
                      },
                      child: const Text(
                        'Don\'t Have Account, Sign Up',
                      ),

                    )
                )
              ],
            ),
          )),
    );
  }
  void moveToLastScreen(BuildContext context)
  {
    Navigator.pop(context);
  }
}


