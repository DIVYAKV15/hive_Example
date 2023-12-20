import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';//have to give this dart file name and g is to generated to create the TypeAdapter
//part is very important to define to let the build runner do his work
//// HiveType annotation for generate the type adapter

@HiveType(typeId: 0)//Annoted with TypeId and it should be different for each type
class User
{
  // Annotate all fields which should be stored with HiveField
  @HiveField(0)//this is for field
  final String email;
  @HiveField(1)// The field numbers help identify the fields when the class has been converted to binary to save in Hive

  final String password;
  @HiveField(2)
  String? id;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? age;

  User({required this.email, required this.password,this.name,this.age}){
    id=DateTime.now().microsecondsSinceEpoch.toString();//to generate unique id
    //to get current time is using DataTime.now
    //microsecondSinceEpoch is to independent of time Zone to get time depend on time Zone
    //other wise if other person from other time zone create this project will get the same id to avoid this we using time zone
  }

}
//The typeId and fieldValues could be any number between 0–255
//flutter packages pub run build_runner build have to give this in Terminal
// This will generate a file named with user_model.g.dart file that will contain your UserAdapter.