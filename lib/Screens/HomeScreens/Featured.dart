import 'package:UdemyClone/Controller/DataController.dart';
import 'package:UdemyClone/Screens/DetailsScreens/DetailsScreen.dart';
import 'package:UdemyClone/Screens/HomeScreen.dart';
import 'package:UdemyClone/Screens/HomeScreens/MyList.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  Future<Null> _pullData() {
    Navigator.pushReplacement(
      context,
      PageTransition(child: HomeScreen(), type: PageTransitionType.fade),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Featured"),
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
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        onRefresh: () => _pullData(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 220.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/udemy_3.jpg'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  height: 70.0,
                  width: 400.0,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          HexColor('#20477a'),
                          HexColor('#2377cc'),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Courses now on sale",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "1 Day Left",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Featured",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                width: 400,
                child: GetBuilder<DataController>(
                  init: DataController(),
                  builder: (value) {
                    return FutureBuilder(
                      future: value.getData('top'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            ),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => DetailsScreen(),
                                    transition: Transition.rightToLeftWithFade,
                                    arguments: snapshot.data[index],
                                  );
                                },
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: FadeInImage(
                                            height: 120.0,
                                            width: 200.0,
                                            placeholder: AssetImage(
                                                "assets/images/udemy_logo_2.jpg"),
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              snapshot.data[index]
                                                  .data()['image'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: SizedBox(
                                          width: 200.0,
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        child: Text(
                                          snapshot.data[index].data()['author'],
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        child: Row(
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              snapshot.data[index]
                                                          .data()['discount'] !=
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
                                              snapshot.data[index]
                                                          .data()['discount'] !=
                                                      ""
                                                  ? snapshot.data[index]
                                                      .data()['price']
                                                  : "",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: SizedBox(
                                          height: 30.0,
                                          width: 80.0,
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "Best Seller",
                                                style: TextStyle(
                                                  color: HexColor('#3d0000'),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.yellow[300],
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Courses in Web Development",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 300,
                width: 400,
                child: GetBuilder<DataController>(
                  init: DataController(),
                  builder: (value) {
                    return FutureBuilder(
                      future: value.getData('top'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            ),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    DetailsScreen(),
                                    transition: Transition.rightToLeftWithFade,
                                    arguments: snapshot.data[index],
                                  );
                                },
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: FadeInImage(
                                            height: 120.0,
                                            width: 200.0,
                                            fit: BoxFit.fill,
                                            placeholder: AssetImage(
                                                "assets/images/udemy_logo_2.jpg"),
                                            image: NetworkImage(
                                              snapshot.data[index]
                                                  .data()['image'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: SizedBox(
                                          width: 200.0,
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        child: Text(
                                          snapshot.data[index].data()['author'],
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        child: Row(
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
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              snapshot.data[index]
                                                          .data()['discount'] !=
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
                                              snapshot.data[index]
                                                          .data()['discount'] !=
                                                      ""
                                                  ? snapshot.data[index]
                                                      .data()['price']
                                                  : "",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: SizedBox(
                                          height: 30.0,
                                          width: 80.0,
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                "Best Seller",
                                                style: TextStyle(
                                                  color: HexColor('#3d0000'),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.yellow[300],
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
