import 'package:UdemyClone/Controller/DataController.dart';
import 'package:UdemyClone/Screens/DetailsScreens/detailsScreen.dart';
import 'package:UdemyClone/Services/Authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("My List"),
        backgroundColor: Colors.black,
      ),
      body: GetBuilder<DataController>(
        init: DataController(),
        builder: (value) {
          return FutureBuilder(
            future: value.getCartData(authentication.user.uid),
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
                      "No Data in Cart",
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
                              .collection('cart')
                              .doc(snapshot.data[index].id)
                              .delete()
                              .whenComplete(() => {
                                    Get.snackbar(
                                      'Success',
                                      "${snapshot.data[index].data()['title']} removed from cart",
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
                              transition: Transition.rightToLeftWithFade,
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
    );
  }
}
