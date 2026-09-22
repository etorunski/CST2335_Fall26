import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  int _counter = 0;

  var isChecked = false; //for the checkbox

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(translate("hello"), style:TextStyle(fontSize: 30,color:Colors.green),),

            Semantics(child:Image.asset("assets/algonquin.jpg", height:300, width:300),
                label:"Image of algonquin college"),

           Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: ( ) {  } , //lambda function (no name)
                  child: Text(translate('pushed_message'))),
            ),
           Padding(child: ElevatedButton(
                onPressed: buttonClicked,
                child: Image.asset("assets/algonquin.jpg", width: 200, height:200)
            ),
             padding: EdgeInsets.all(20)),

            Checkbox(value:isChecked, onChanged: (bool? newvalue){
              setState(() {
                if(newvalue != null)
                  isChecked = newvalue;
              });  //update the GUI
            } ),

            Switch(value:isChecked, onChanged: (bool? newvalue){
              setState(() {
                if(newvalue != null)
                  isChecked = newvalue;
              });  //update the GUI
            } )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: translate('increment'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void buttonClicked(){

  }
}
