import 'package:UdemyClone/Screens/HomeScreen.dart';
import 'package:UdemyClone/Screens/SignInOptions/signInPage.dart';
import 'package:UdemyClone/Screens/SignInOptions/signUpPage.dart';
import 'package:UdemyClone/Services/PrefStorage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PrefStorage prefStorage = PrefStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Landing Page"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: SizedBox(
            height: 400.0,
            width: 400.0,
            child: Image.asset(
              "assets/images/udemy_logo_2.jpg",
              fit: BoxFit.fitHeight,
              colorBlendMode: BlendMode.darken,
              color: Colors.black54,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              child: Text(
                "Browse",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: await prefStorage.isLoggedIn()
                          ? HomeScreen()
                          : SignInPage(),
                      type: PageTransitionType.leftToRightWithFade),
                );
              },
            ),
            MaterialButton(
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () => Navigator.pushReplacement(
                context,
                PageTransition(
                    child: SignInPage(),
                    type: PageTransitionType.leftToRightWithFade),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
