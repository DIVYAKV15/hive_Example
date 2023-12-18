import 'package:flutter/material.dart';

import '../database/hiveDb.dart';
// void main()
// {
//   runApp(const MaterialApp(home:Registration()));
// }

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    final email_cntrl=TextEditingController();
    final pwd_cntrl=TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Hive Registration"),),
      body: Column(
         children: [
           TextField(controller: email_cntrl,
               decoration: const InputDecoration(hintText: "UserName")),
           TextField(controller: pwd_cntrl,
               decoration: const InputDecoration(hintText: "Password")),
           ElevatedButton(onPressed: ()async{

           final registered_users_list=await HiveDb.instance.getUser();

             },//to check whether already the users are there or not in db
               //for checking that we are using get to take all the users from hive db
               //only one object means its instance
               //if we can create more objects then its objects
               //for db we create only one object to become secured
               child: const Text("Register here"))
         ],
      ),
    );
  }
}
