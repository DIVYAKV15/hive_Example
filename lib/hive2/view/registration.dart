import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_example/hive2/model/user_model.dart';
import 'package:hive_example/hive2/view/login_Page.dart';
import 'package:hive_flutter/adapters.dart';

//import 'package:path_provider/path_provider.dart' as path_provider;

import '../database/hiveDb.dart';

// void main()async{
//   WidgetsFlutterBinding.ensureInitialized();
//   final dbDir=await path_provider.getApplicationCacheDirectory();
//   await Hive.initFlutter(dbDir.path);
//   Hive.registerAdapter(UserAdapter());
//   await Hive.openBox<User>('userData');
//   runApp(GetMaterialApp(home: Registration(),));
//
// }

class Registration extends StatelessWidget {
  //Registration({super.key});
  final email_cntrl = TextEditingController();
  final pwd_cntrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: email_cntrl,
                decoration: const InputDecoration(hintText: "UserName")),
            TextField(
                controller: pwd_cntrl,
                decoration: const InputDecoration(hintText: "Password")),
            ElevatedButton(
                onPressed: () async {
//to check whether already the users are there or not in db
                  //for checking that we are using get to take all the users from hive db
                  //only one object means its instance
                  //if we can create more objects then its objects
                  //for db we create only one object to become secured
                  final regUserlist = await HiveDb.instance.getUser();
                  validate_signup(regUserlist);
                },
                child: const Text("Register here"))
          ],
        ),
      ),
    );
  }
  void validate_signup(List<User> regUserlist)async{
    final eemail=email_cntrl.text.trim();
    final epwd=pwd_cntrl.text.trim();
    bool userFound=false;
    final validateEmail=EmailValidator.validate(eemail);

    if(eemail!=''&&epwd!=''){//to check empty
      if(validateEmail==true){
        await Future.forEach(regUserlist, (user) {//to get each user from regUserList
          if(user.email==eemail){  // to check email already existing
            userFound=true;
          }
          else{
            userFound=false;
          }
        });
        if(userFound==true){
          Get.snackbar("error", "User already exist",colorText: Colors.red);
        }
        else{
          //to check password
          final validatePassword=check_pwd(epwd);
          if(validatePassword==true){
            final newuser=User(email: eemail, password: epwd);
            await HiveDb.instance.addUser(newuser);
            Get.snackbar("Success", "Registration success",colorText: Colors.green);
            Get.to(HiveLoginPage());
          }
        }
      }
      else{
        Get.snackbar("Error", "enter a valid email",);
      }
    }
    else{
      Get.snackbar("Error", "email & password should not be empty",colorText: Colors.red);
    }
  }

  bool check_pwd(String epwd) {
    if(epwd.length<6){Get.snackbar("Error","password length should>=6");
    return false;}
    else return true;
  }


//   void validateRegistration(List<User> registeredUsersList) async {
//     final enteredEmail = email_cntrl.text.trim();
//     final enteredPwd = pwd_cntrl.text.trim();
//     // bool userFound = false;
//     final validateEmail = EmailValidator.validate(enteredEmail);
//     if (enteredEmail != '' && enteredPwd != '') //to check empty
//     {
//       if (validateEmail == true)
// //to validate email
//       {
//         await Future.forEach(registeredUsersList, (user) async {
//           //to get each user from registeredUsersList
//           if (user.email == enteredEmail) //to check already existing user
//           {
//             Get.snackbar("Error", "User Already Existing",
//                 colorText: Colors.red);
//           } else
// //to validate password
//           {
//             final validatePwd = check_password(enteredPwd);
//             if (validatePwd == true) {
//               final newUser = User(email: enteredEmail, password: enteredPwd);
//               await HiveDb.instance.addUser(newUser);
//               Get.to(HiveLoginPage());
//               Get.snackbar("Registered", "successful registration",
//                   colorText: Colors.green);
//             }
//           }
//           // userFound = true;
//           // } else {
//           //   userFound = false;
//           // }
//         });
//         // if (userFound = true) {
//         //   Get.snackbar("Error", "User Already Existing", colorText: Colors.red);
// //          } else
// // //to validate password
// //         {
// //           final validatePwd = check_password(enteredPwd);
// //
// //           if (validatePwd == true) {
// //             final newUser = User(email: enteredEmail, password: enteredPwd);
// //             await HiveDb.instance.addUser(newUser);
// //             Get.to(HiveLoginPage());
// //             Get.snackbar("Registered", "successful registration",
// //                 colorText: Colors.green);
// //           }
// //         }
//       } else {
//         Get.snackbar("Error", "Enter a valid email", colorText: Colors.red);
//       }
//     } else {
//       Get.snackbar("Error", "fields must not be empty", colorText: Colors.red);
//       //to get a simple snack bar we can get external plugins in pubspec yaml
//       //and use Get.snack bar
//     }
//   }
//
//   bool check_password(String epwd) {
//     if (epwd.length < 6) {
//       Get.snackbar('Error', 'password should not be less than 6');
//       return false;
//     } else {
//       return true;
//     }
//   }
}
