//holds variables temporarily , this is a Singleton
class DataRepository {

  static String _pageOneString = ""; //
  static int _age = 0;

  // pageOneString getters and setters
  static String get pageOneString => _pageOneString;
  static set pageOneString(String s) => _pageOneString = s;

  static void setPageOneString(String s){
    //add saving logic here, with ENcryptedSharedPreferences
    _pageOneString = s; }

  static String getPageOneString(){
    //load from EncryptedSharedPreferences
    return _pageOneString;}

  // Age getters and setters
  static int get age => _age;
  static set age(int value) => _age = value;

  static int getAge() {
    return _age;
  }

  static void setAge(int age) {
    _age = age;
  }

  //more variables for sending from one page to another:

}
