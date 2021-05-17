import 'package:UdemyClone/Controller/DataController.dart';
import 'package:UdemyClone/Screens/DetailsScreens/detailsScreen.dart';
import 'package:UdemyClone/Screens/HomeScreens/MyList.dart';
import 'package:UdemyClone/Services/Authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:page_transition/page_transition.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Wishlist"),
        backgroundColor: Colors.black,
        actions: [
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
      body: GetBuilder<DataController>(
        init: DataController(),
        builder: (value) {
          return FutureBuilder(
            future: value.getWishlistData(authentication.user.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                );
              } else {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text(
                      "No Data in Wishlist",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        direction: DismissDirection.startToEnd,
                        resizeDuration: Duration(milliseconds: 200),
                        key: ObjectKey(snapshot.data[index]),
                        onDismissed: (direction) {
                          FirebaseFirestore.instance
                              .collection('wishlist')
                              .doc(snapshot.data[index].id)
                              .delete()
                              .whenComplete(() => {
                                    Get.snackbar(
                                      'Success',
                                      "${snapshot.data[index].data()['title']} removed from wishlist",
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.TOP,
                                    ),
                                    setState(() {})
                                  });
                        },
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => DetailsScreen(),
                              arguments: snapshot.data[index],
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 110.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: FadeInImage(
                                        height: 90.0,
                                        width: 150.0,
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          snapshot.data[index].data()['image'],
                                        ),
                                        placeholder: AssetImage(
                                            "assets/images/udemy_logo_2.jpg"),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 220.0,
                                            child: Text(
                                              snapshot.data[index]
                                                  .data()['title'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.grey.shade300,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index]
                                                .data()['author'],
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18.0,
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                                size: 18.0,
                                              ),
                                              Text(
                                                snapshot.data[index]
                                                    .data()['ratings'],
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              Text(
                                                " (" +
                                                    snapshot.data[index]
                                                        .data()['enrolled'] +
                                                    ")",
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data[index].data()[
                                                            'discount'] !=
                                                        ""
                                                    ? snapshot.data[index]
                                                        .data()['discount']
                                                    : snapshot.data[index]
                                                        .data()['price'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7.0,
                                              ),
                                              Text(
                                                snapshot.data[index].data()[
                                                            'discount'] !=
                                                        ""
                                                    ? snapshot.data[index]
                                                        .data()['price']
                                                    : "",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15.0,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            },
          );
        },
      ),
      //   SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         SizedBox(
      //           height: 300.0,
      //           width: 400.0,
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Container(
      //                 height: 100.0,
      //                 width: 100.0,
      //                 decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                     image: AssetImage("assets/images/wishlist.png"),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 15.0),
      //                 child: Text(
      //                   "Want to save something for future?",
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 23.0,
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(top: 15.0),
      //                 child: Text(
      //                   "Your wishlist will go here.",
      //                   style: TextStyle(
      //                     color: Colors.grey,
      //                     fontSize: 17.0,
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 15.0),
      //           child: Text(
      //             "Browse Categories",
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 20.0,
      //             ),
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(
      //             FontAwesomeIcons.wallet,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             "Finance & Accounting",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(
      //             FontAwesomeIcons.chartBar,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             "Development",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(
      //             FontAwesomeIcons.chartLine,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             "Business",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(
      //             FontAwesomeIcons.code,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             "IT & Software",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(
      //             FontAwesomeIcons.bookReader,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             "Office Productivity",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(
      //             FontAwesomeIcons.thinkPeaks,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             "Personal Development",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(
      //             FontAwesomeIcons.brain,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             "Motivational & Inspirational",
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
    );
  }
}
