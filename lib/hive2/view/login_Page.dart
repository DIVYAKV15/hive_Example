import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_example/hive2/model/user_model.dart';
import 'package:hive_example/hive2/view/registration.dart';
import 'package:hive_example/hive2/view/sign_Up_Page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../database/hiveDb.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //as wr are used many plugins so using this to bind

  final dbDir = await path_provider.getApplicationCacheDirectory();
  await Hive.initFlutter(dbDir.path);
  //await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<User>('userData');
  runApp(GetMaterialApp(home: HiveLoginPage())); //as we are using this with Get
  //so we have to do GetMaterialApp
}

class HiveLoginPage extends StatelessWidget {
  HiveLoginPage({super.key});
  final login_email = TextEditingController();
  final login_pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "LOGIN PAGE",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, height: 2),
              controller: login_email,
              decoration: const InputDecoration(
                hintText: "EmailId",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, height: 2),
              controller: login_pwd,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  final toCheckValidation = await HiveDb.instance.getUser();
                  validateEmail(toCheckValidation);
                },
                child: const Text("LOGIN")),
            TextButton(
                onPressed: () {
                  Get.to(Registration());
                },
                child: Text(
                  "Don't have an acconunt ,Register here",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> validateEmail(List<User> toCheckValidation) async {
    final log_email = login_email.text.trim();
    final log_password = login_pwd.text.trim();
    bool userFound = false;
    final validateEmail = EmailValidator.validate(log_email);
    if (log_email != '' && log_password != '') {
      //to check empty
       if (validateEmail == true) {
      await Future.forEach(toCheckValidation, (user) {
        if (user.email == log_email && user.password == log_password) {
          // to check email already existing
          userFound = true;
        } else {
          userFound = false;
        }
      });
      if (userFound == true) {
        Get.snackbar("success", "Done",
            colorText: Colors.green, backgroundColor: Colors.black);
        Get.to(HiveSignUpPage());
      } else {
        Get.snackbar("error", "email/password incorrect",
            colorText: Colors.red);
      }
    }
      } else {
        Get.snackbar(
          "Error",
          "enter a valid email",colorText: Colors.red
        );
      }

      Get.snackbar(
        "Error",
        "email & password should not be empty",
        colorText: Colors.red,backgroundColor: Colors.black
      );
    }
  }


//   {
//     Get.snackbar('Error', 'EMail/password should not be empty',
//         colorText: Colors.red);
//   }
//   if (validateEmail == true) {
//     await Future.forEach(toCheckValidation, (user) {
//       if (user.email == log_email && user.password == log_password) {
//         Get.snackbar('WElcome', "login Successfully",
//             colorText: Colors.green);
//         Get.to(Registration());
//       } else {
//         Get.snackbar('Error', "userName/password is incorrect",
//             colorText: Colors.green);
//       }
//     });
//   }
// }
//to check password
//final validatePassword=check_pwd(epwd);
// if(validatePassword==true){
// final newuser=User(email: eemail, password: epwd);
// await HiveDb.instance.addUser(newuser);
