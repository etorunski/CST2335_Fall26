
import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'OtherPage.dart';
import 'DataRepository.dart';

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
        routes: {
          '/home' : (context)=> const MyHomePage(), //return MyHomePage() widget
          '/otherPage' : (context)=> OtherPage(), //need to import

        },
        initialRoute: '/home',
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
     //   home: const MyHomePage(), //replace with initialRoute:
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


  late TextEditingController controller ;

//beginning function:
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(); //initialize late variable
    controller.addListener(() {
      //set the repository
    });
  }

  //leaving:
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose(); //clear memory
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
        Padding(padding: EdgeInsetsGeometry.all(50.0), child:
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: .center,
          children: [

            Row(children: [
              Flexible(child: //or Expanded(child:
              TextField(controller: controller,
                  decoration: InputDecoration(
                label:Text("Type in here")))),
              IconButton(onPressed: () { }, icon: Icon(Icons.phone),),
          ])

            ,
            OutlinedButton(child:
              Text("Click for Next Page", style:TextStyle(fontSize: 50, color: Colors.orangeAccent)),
                onPressed: () {
                  DataRepository.pageOneString = controller.value.text; //store the string
                  Navigator.pushNamed(context, '/otherPage');//look up what is'/otherPage' in the routes:
                }),


            OutlinedButton(child: Icon(Icons.phone),
                onPressed: ( ) async {
                var canCall = await canLaunchUrl(Uri.parse("tel:613-727-4723")); //asynchronous

                if(canCall)
                  launchUrl(Uri.parse("tel:613-727-4723"));
            })
          ]

          )),
        )
    );
  }

}
