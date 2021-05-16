import 'package:UdemyClone/Screens/HomeScreen.dart';
import 'package:UdemyClone/Screens/landingPage.dart';
import 'package:UdemyClone/Services/Authentication.dart';
import 'package:UdemyClone/Services/PrefStorage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:page_transition/page_transition.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Authentication authentication = Authentication();
  final PrefStorage prefStorage = PrefStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Account"),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Icon(EvaIcons.shoppingCartOutline),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: HomeScreen(),
                        type: PageTransitionType.leftToRightWithFade),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      prefStorage.getUserInfo('name'),
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.google,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        prefStorage.getUserInfo('email'),
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Become an Instructor",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Video Preferences",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Download Options",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text(
                "Video Playback Options",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Account Settings",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Account Security",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text(
                "Email Notification Preferences",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 20.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Learning Reminders",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 110.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.greenAccent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "New",
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, top: 20.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Support",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "About Udemy",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text(
                "About Udemy for Business",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text(
                "FAQs",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text(
                "Share Udemy App",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Diagonostics",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Status",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: MaterialButton(
                  onPressed: () async {
                    await EasyLoading.show(
                      status: "Signing out",
                      maskType: EasyLoadingMaskType.black,
                    );
                    await authentication
                        .signOut()
                        .whenComplete(
                          () async => {
                            await prefStorage.deleteUserInfo('email', 'name'),
                          },
                        )
                        .whenComplete(() => {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  child: LandingPage(),
                                  type: PageTransitionType.leftToRightWithFade,
                                ),
                              )
                            });
                    await EasyLoading.dismiss();
                  },
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  "Udemy v1.4",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
