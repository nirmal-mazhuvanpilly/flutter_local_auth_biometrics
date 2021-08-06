import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

/*

Add Flutter local_auth package to use Biometrics

<---iOS Integration--->
<key>NSFaceIDUsageDescription</key>
<string>Why is my app authenticating using face id?</string>

<---Android Integration--->
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          package="com.example.app">
  <uses-permission android:name="android.permission.USE_FINGERPRINT"/>
<manifest>

Replace MainActivity.kt (For Kotlin) with following lines of code
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Local/Biometric Authentication'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocalAuthentication auth = LocalAuthentication();

  bool checkBiometrics = false;
  bool authenticate;

  String bmAvail = "Biometrics availability not checked";
  String authState = "Not Authorized";

  List<BiometricType> availableBiometrics = [];

  checkBioMetricsFunction() async {
    checkBiometrics = await auth.canCheckBiometrics;
    if (checkBiometrics) {
      setState(() {
        print(checkBiometrics);
        bmAvail = "Biometrics available";
      });
    } else {
      setState(() {
        print(checkBiometrics);
        bmAvail = "Biometrics not available";
      });
    }
  }

  availableBioMetricsFunction() async {
    availableBiometrics = await auth.getAvailableBiometrics();
    setState(() {
      //Prints available Biometrics
      print(availableBiometrics);
    });
  }

  authenticateBioMetricsFunction() async {
    authenticate = await auth.authenticateWithBiometrics(
        localizedReason: "Keep finger on sensor");
    if (authenticate) {
      setState(() {
        authState = "Authorized succesfully";
      });
    } else {
      setState(() {
        authState = "Authorization failed";
      });
    }
  }

  final fontStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo,
                    Colors.indigo[900],
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  Text(bmAvail, style: fontStyle),
                  FlatButton(
                    child: Text("Check Biometrics"),
                    onPressed: checkBioMetricsFunction,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo,
                    Colors.indigo[900],
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    children: availableBiometrics
                        .map((val) => Text(
                              val.toString(),
                              style: fontStyle,
                            ))
                        .toList(),
                  ),
                  FlatButton(
                    child: Text("Available Biometrics"),
                    onPressed: availableBioMetricsFunction,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo,
                    Colors.indigo[900],
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    authState,
                    style: fontStyle,
                  ),
                  FlatButton(
                    child: Text("Available Biometrics"),
                    onPressed: authenticateBioMetricsFunction,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
