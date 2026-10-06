import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      child:
      MaterialApp(
        debugShowCheckedModeBanner: false,
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
  int _counter = 0;

  late TextEditingController controller ;

  var isChecked = false; //for the checkbox
  String message = "Hi";

  //this is the Snackbar object:
  var snackBar = SnackBar( content: Text('Yay! A SnackBar!'),
    action: SnackBarAction(label: 'Ok', onPressed:  () {  },));

//beginning function:
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();//initialize late variable

    loadData(); //set the controller from any saved data

    //this launches it:
    Future.delayed(  Duration.zero  ,
      (){ScaffoldMessenger.of(context).showSnackBar(snackBar); }
    );


  }

  //leaving:
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose(); //clear memory
  }

  // Load and obtain the shared preferences for this app.
  Future<void> loadData()  async {

    //await waits for this to finish before continuing.
    final prefs = EncryptedSharedPreferences();

    //asynchronous
    prefs.getString("KeyInput").then( (input){
      controller.text = input ?? ""; //?? means in case of null
    });

   }

  // Load and obtain the shared preferences for this app.
  Future<void> deleteData()  async {

    //does not wait:
    final prefs =  EncryptedSharedPreferences();

    //asynchronous, but don't need returned
     prefs.remove("KeyInput") ;
  }

  // Load and obtain the shared preferences for this app.
  void saveData()  {
    var prefs = EncryptedSharedPreferences();
    
    //asynchronous, but don't need returned
    prefs.setString("KeyInput", controller.value.text);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {


    return
      Scaffold(
          appBar: AppBar(  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
          FilledButton(child:Text("Button 2") , onPressed:() { }),
          FilledButton(child:Text("Button 3") , onPressed:() { }),
        ],
      ),
      drawer: Drawer(child:Text("Hi there") ),
      body: Align(alignment: Alignment.center,
        child:
        Padding(child:
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: .center,
          children: [
OutlinedButton(child:
          Text("Click for alert dialog", style:TextStyle(fontSize: 50, color: Colors.orangeAccent)),
              onPressed: () {
                //show a dialog window:
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Save data'),
                    content: const Text('Do you want to save the string'),
                    actions: <Widget>[
                      OutlinedButton(child:Text("Ok"), onPressed: () {
                        saveData();
                        Navigator.pop(context);
                      }),
                      OutlinedButton(child:Text("Cancel"), onPressed: () {
                        deleteData();
                        Navigator.pop(context);

                      })
                    ],
                  ),
                );

              }
              ,),

            TextField(controller: controller, decoration: InputDecoration(label:Text("Input")))
          ]
          ),
          padding: EdgeInsetsGeometry.all(50.0)),
        )


    );
  }

  void buttonClicked(){

  }
}
