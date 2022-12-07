import 'package:flutter/material.dart';
import 'package:api_handling/Register/SignIn.dart';
import 'package:http/http.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  TextEditingController ControllerfullName = TextEditingController();
  TextEditingController ControllerUserId = TextEditingController();
  TextEditingController Controllerpassword = TextEditingController();

  void login(String email, password) async
  {
    try
        {
          Response response = await post(
              Uri.parse("https://reqres.in/api/register"),
              body: {
                "email" : email,
                "password" : password
              }
          );

          if(response.statusCode == 200)
            {
              print("Sign up successfull");
            }
          else
            {
              print("Cannot Sign Up");
            }
        }
        catch(e)
    {
      print(e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Registration Page"),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 4.0),
                  child: Text(
                    "Create Account,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 4.0),
                  child: Text(
                    "Sign up to get started!",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 70.0, bottom: 4.0),
                  child: TextField(
                    onChanged: (value) {
                      debugPrint("Something changed in textfield");
                    },
                    controller: ControllerfullName,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 4.0),
                  child: TextField(
                    onChanged: (value) {
                      debugPrint("Something changed in textfield");
                    },
                    controller: ControllerUserId,
                    decoration: InputDecoration(
                      labelText: "User Id",
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
                    controller: Controllerpassword,
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
                      login(ControllerUserId.text.toString(), Controllerpassword.text.toString());
                    },
                    child: const Text('Sign Up'),
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
                    onPressed: () {

                    },
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
                        navigateTologinpage();
                      },
                      child: const Text(
                        'Already Have Account, Sign in',
                      ),

                    )
                )
              ],
            ),
          )),
    );
  }

  void navigateTologinpage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return loginpage();
    }));
  }

}
