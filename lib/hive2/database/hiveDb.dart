import 'package:hive/hive.dart';
import 'package:hive_example/hive2/model/user_model.dart';

class HiveDb {
  //singleton class
  HiveDb._internal(); //private name constructor
  static HiveDb instance = HiveDb._internal(); //single instance creation
  //factory constructor to access the instance
  factory HiveDb() {
    return instance;
  }
//// opening box like create a new table in sql
// // it’s very important step
// var box = await Hive.openBox(‘hive’);
  Future<List<User>> getUser() async {
    final db = await Hive.openBox<User>('userData');
    return db.values.toList();
//getUser is to get all the login details from db so we can verify whether that user details is already there in db or not
// as we are returning to list so we are converting  into .to.list()
// <user> is the one we created in the model as type adapter
    //hive is to store key values in db so to get as list we have to give .toList
  }

  addUser(User newUser) async{
    final db = await Hive.openBox<User>('userData');
    db.put(newUser.id, newUser);
  }
}
//it a db class
//to restrict to create more instance(object) we use Singleton Class
// factory constructor is to access the instance
//where ever  we calling this db class we can use only this object
//classname object name =constructor() usual way of create object
//but here we need to create private named constructor
//and with that only we can create object is we want to create singleton class(i.e.)single creation instance
//syntax:static Classname object name=Classname with private named constructor
//usually constructor will not return anything as we using factory constructor here we need to   return instance(any name its a object)
