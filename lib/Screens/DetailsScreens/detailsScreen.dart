import 'package:UdemyClone/Screens/HomeScreens/MyList.dart';
import 'package:UdemyClone/Services/Authentication.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  VideoPlayerController videoPlayerController =
      VideoPlayerController.network(Get.arguments['video_url']);
  ChewieController chewieController;
  Authentication authentication = Authentication();
  QueryDocumentSnapshot queryDocSnap;

  String appName;
  String packageName;
  String version;
  String buildNumber;

  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      looping: true,
      autoPlay: true,
      autoInitialize: true,
      aspectRatio: 16 / 9,
    );
    queryDocSnap = Get.arguments;
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> share() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      print(appName);
      await FlutterShare.share(
        title: 'Share To',
        text: 'Udemy App Download Link',
        linkUrl: 'https://flutter.dev/',
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Icon(EvaIcons.share),
                onTap: () {
                  share();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Icon(EvaIcons.shoppingCartOutline),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: MyList(),
                        type: PageTransitionType.leftToRightWithFade),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                queryDocSnap['title'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  queryDocSnap['description'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            Text(
                              queryDocSnap['ratings'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            Text(
                              "${queryDocSnap['enrolled']} Enrolled",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            Text(
                              "${queryDocSnap['total_hours']} Total Hours",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            Text(
                              "Created By ${queryDocSnap['author']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            Text(
                              queryDocSnap['language'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 18.0,
                            ),
                            Text(
                              "Updated ${queryDocSnap['updated_at']}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!videoPlayerController.value.isPlaying) {
                    videoPlayerController.play();
                  }
                  Get.dialog(
                    WillPopScope(
                      // ignore: missing_return
                      onWillPop: () {
                        if (videoPlayerController.value.isPlaying) {
                          videoPlayerController.pause();
                        } else {
                          videoPlayerController.dispose();
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chewie(
                            controller: chewieController,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300.0,
                    width: 400.0,
                    child: Center(
                      child: Stack(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.black54, BlendMode.darken),
                            child: FadeInImage(
                              height: 200.0,
                              width: 400.0,
                              placeholder:
                                  AssetImage("assets/images/udemy_logo_2.png"),
                              image: NetworkImage(queryDocSnap['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 50.0,
                            left: 150.0,
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 90.0,
                            ),
                          ),
                          Positioned(
                            top: 140.0,
                            left: 150.0,
                            child: Text(
                              "Tap to Play",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  height: 50.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final QuerySnapshot result = await FirebaseFirestore
                            .instance
                            .collection('cart')
                            .where('user_id',
                                isEqualTo: authentication.user.uid)
                            .where('title', isEqualTo: queryDocSnap['title'])
                            .get();

                        final List<DocumentSnapshot> documents = result.docs;
                        await EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        if (documents.length > 0) {
                          Get.snackbar(
                            'Oh no',
                            "${queryDocSnap['title']} already added to cart",
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                          await EasyLoading.dismiss();
                        } else {
                          FirebaseFirestore.instance.collection('cart').add({
                            'user_id': authentication.user.uid,
                            'title': queryDocSnap['title'],
                            'image': queryDocSnap['image'],
                            'author': queryDocSnap['author'],
                            'price': queryDocSnap['price'],
                            'discount': queryDocSnap['discount'],
                            'description': queryDocSnap['description'],
                            'ratings': queryDocSnap['ratings'],
                            'language': queryDocSnap['language'],
                            'updated_at': queryDocSnap['updated_at'],
                            'video_url': queryDocSnap['video_url'],
                            'total_hours': queryDocSnap['total_hours'],
                            'enrolled': queryDocSnap['enrolled'],
                          }).whenComplete(() async => {
                                Get.snackbar(
                                  'Success',
                                  "${queryDocSnap['title']} added to cart",
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                ),
                                await EasyLoading.dismiss(),
                              });
                        }
                      },
                      child: Container(
                        height: 40.0,
                        width: 170.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final QuerySnapshot result = await FirebaseFirestore
                            .instance
                            .collection('wishlist')
                            .where('user_id',
                                isEqualTo: authentication.user.uid)
                            .where('title', isEqualTo: queryDocSnap['title'])
                            .get();

                        final List<DocumentSnapshot> documents = result.docs;
                        await EasyLoading.show(
                          status: 'loading...',
                          maskType: EasyLoadingMaskType.black,
                        );
                        if (documents.length > 0) {
                          Get.snackbar(
                            'Oh no',
                            "${queryDocSnap['title']} already added to wishlist",
                            colorText: Colors.white,
                            snackPosition: SnackPosition.TOP,
                          );
                          await EasyLoading.dismiss();
                        } else {
                          FirebaseFirestore.instance
                              .collection('wishlist')
                              .add({
                            'user_id': authentication.user.uid,
                            'title': queryDocSnap['title'],
                            'image': queryDocSnap['image'],
                            'author': queryDocSnap['author'],
                            'price': queryDocSnap['price'],
                            'discount': queryDocSnap['discount'],
                            'description': queryDocSnap['description'],
                            'ratings': queryDocSnap['ratings'],
                            'language': queryDocSnap['language'],
                            'updated_at': queryDocSnap['updated_at'],
                            'video_url': queryDocSnap['video_url'],
                            'total_hours': queryDocSnap['total_hours'],
                            'enrolled': queryDocSnap['enrolled'],
                          }).whenComplete(() async => {
                                    Get.snackbar(
                                      'Success',
                                      "${queryDocSnap['title']} added to wishlist",
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.TOP,
                                    ),
                                    await EasyLoading.dismiss(),
                                  });
                        }
                      },
                      child: Container(
                        height: 40.0,
                        width: 170.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            "Add to Wishlist",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
