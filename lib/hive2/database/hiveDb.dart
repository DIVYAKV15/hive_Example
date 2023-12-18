class HiveDb {
  //singleton class
  HiveDb._internal(); //private name constructor
  static HiveDb instance = HiveDb._internal(); //single instance creation
  //factory constructor to access the instance
  factory HiveDb() {
    return instance;
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
