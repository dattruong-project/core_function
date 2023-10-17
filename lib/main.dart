import 'dart:developer';
import 'dart:async';
import 'dart:io';
import 'package:core_function/crypto/PBKDF2.dart';
import 'package:core_function/crypto/aes_crypto.dart';
import 'package:core_function/crypto/rsa.dart';
import 'package:core_function/notification/local_notification.dart';
import 'package:core_function/payment/payment_by_zalo.dart';
import 'package:core_function/second_screen.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'crypto/salt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Increment demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async{
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    final location = tz.getLocation(currentTimeZone);
    //Notification
    // LocalNotification(
    //   context: context,
    //   payload: 'test',
    //   pageRoute: MaterialPageRoute(
    //     builder: (context) {
    //       return MyHomePage(title: 'aaa');
    //     },
    //   ),
    //   appIcon: 'mipmap/ic_launcher',
    // ).show(title: "aaaa", message: "aaa");
    // LocalNotification(
    //   context: context,
    //   payload: 'test',
    //   pageRoute: MaterialPageRoute(
    //     builder: (context) {
    //       return MyHomePage(title: 'aaa');
    //     },
    //   ),
    //   appIcon: 'mipmap/ic_launcher',
    // ).scheduleNotification(title: "aaa", message: "bbb",
    //     scheduleDate: TZDateTime.from(DateTime(2023,10,13,16,35,0), location));
    //Payment
    // await PaymentByZalo.instance.init("2554", "sandbox", "sdngKKJmqEMzvh5QQcdD2A9XBSKUNaYn");
    // await PaymentByZalo.instance.pay("20000");
    // Security
    // String password = '12345678x@X';
    // var salt = Salt.generateAsBase64String(12);
    // var hash = PBKDF2.instance.generateBase64Key(password, salt, 1000, 16);
    // final encrypt = AESCrypto.encrypt(hash, 'abc');
    // final data = AESCrypto.decrypt(hash, encrypt);
    // log("show Data By AES Method $data");
    // final folder = await getApplicationDocumentsDirectory();
    // final publicKey = await parseKeyFromFile<RSAPublicKey>('${folder.path}/public.pem');
    // final privateKey = await parseKeyFromFile<RSAPrivateKey>('${folder.path}/private.pem');
    // RSACrypto.instance.init(publicKey: publicKey, privateKey: privateKey);
    // final en = RSACrypto.instance.encrypt("Hello");
    // final result = RSACrypto.instance.decrypt(en);
    // log("show Data By RSA Method $result");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
