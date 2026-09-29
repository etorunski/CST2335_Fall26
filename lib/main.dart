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

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();//initialize late variable
  }

  //leaving:
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose(); //clear memory
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
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            ElevatedButton(child:Text("Button 1") , onPressed:() { }),
            ElevatedButton(child:Text("Button 2") , onPressed:() { }),
            ElevatedButton(child:Text("Button 3") , onPressed:() { }),
            ElevatedButton(child:Text("Button 4") , onPressed:() { })
          ],
        ),
      ),
        bottomNavigationBar:
        BottomNavigationBar(
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.camera ),
                label: translate('nav1')),

            BottomNavigationBarItem(icon:Icon(Icons.phone ) , label: translate('nav2')),

          ],
          onTap: (index){
            switch(index){
              case 0:
                //camera
                break;
              case 1:
                //phone
                break;
            }

          },
        )
    );
  }

  void buttonClicked(){

  }
}
