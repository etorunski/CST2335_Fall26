import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'AppDatabase.dart';



class CourseInfo(
  final String courseCode , //class variable declarations
  final String courseTitle
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: ['en', 'fr', 'ar', 'it'],
  );

  runApp(LocalizedApp(delegate, const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: translate('app_title'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          localizationDelegate,
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    List<UserTable> users = [ ]; //Array initialization

    late AppDatabase db;

    var words2 =  <String> []; //Array initialization

  late TextEditingController controller ;
    late TextEditingController controller2 ;

  var isChecked = false; //for the checkbox
String message = "Hi";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();//initialize late variable
    controller2 = TextEditingController();//initialize late variable

    db = AppDatabase();// This creates the local database connection

    //get the data back from database:
    db.getAllUsers().get().then((list) {
      setState(() {
        users = list;
      });


    }) ;//has your data asynchnously
  }

  //leaving:
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose(); //clear memory
    controller2.dispose(); //clear memory
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(translate('home_title')),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            tooltip: translate('language'),
            onSelected: (String localeCode) {
              changeLocale(context, localeCode);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'en',
                child: Text(translate('english')),
              ),
              PopupMenuItem<String>(
                value: 'fr',
                child: Text(translate('french')),
              ),
              PopupMenuItem<String>(
                value: 'ar',
                child: Text(translate('arabic')),
              ),
              PopupMenuItem<String>(
                value: 'it',
                child: Text(translate('italian')),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: ListPage()
      ),

    );
  }

  Widget ListPage()
  {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            TextField(controller:controller,
            decoration: InputDecoration(
                hintText:"Type here",
                border: OutlineInputBorder(),
                labelText: "Course Code"
              )
            ),
          TextField(controller:controller2,
              decoration: InputDecoration(
                  hintText:"Type here",
                  border: OutlineInputBorder(),
                  labelText: "Course Title"
              )
          ),
        OutlinedButton(child: Text("Insert"), onPressed: (){

          setState(() {
            var newCourse = CourseInfo(controller.value.text, controller2.value.text);


            //add to database, returns the ID asynchronously:
           db.saveUser(controller.value.text, controller2.value.text, 23)
               .then((id){
                 var newItem = UserTable(id:id,
                                    username:controller.value.text,
                                    musicStyle: controller2.value.text,
                                    favoriteSong: 12 );
                users.add(newItem);
           });
          });
          controller.text = "";//erase what user typed in
        },),

      Expanded(child:
      ( users.length == 0)?
      Text("No items")
        :
        ListView.builder(itemCount: users.length,
          itemBuilder: (context,index){
            return  ListTile(
                  title: Text("Course Info:"),
                  subtitle: Text("Course Code: ${users[index].username} Course Title: ${users[index].musicStyle}"),
                  onLongPress: (){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('AlertDialog Title'),
                        content: const Text('AlertDialog description'),
                        actions: <Widget>[
                          OutlinedButton(child:Text("Yes"), onPressed: (){
                            setState(() {
                              users.removeAt(index); //remove item at index
                              Navigator.pop(context);
                            });

                          }),
                          OutlinedButton(child:Text("No"), onPressed: (){
                                Navigator.pop(context);
                          }),

                        ],
                      ),
                    );
                  }


            );
        })
      )
      ]);
    /*

         /Text example:
          Text(message, style:TextStyle(fontSize: 30,color:Colors.green),),



          //example of a TextField with a TextController. The controller must be initialized in initState() and removed in dispose()

//end of Widgets

        ],
      ),*/
  }
}

