import 'package:UdemyClone/Controller/DataController.dart';
import 'package:UdemyClone/Screens/DetailsScreens/detailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();

  late QuerySnapshot<dynamic> snapshot;
  bool isExecuted = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget searchedResult() {
      return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Get.to(DetailsScreen(), arguments: snapshot.docs[index]);
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
                            snapshot.docs[index].data()?['image'],
                          ),
                          placeholder:
                              AssetImage("assets/images/udemy_logo_2.jpg"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 220.0,
                              child: Text(
                                snapshot.docs[index].data()['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.docs[index].data()['author'],
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
                                  snapshot.docs[index].data()['ratings'],
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  " (" +
                                      snapshot.docs[index].data()['enrolled'] +
                                      ")",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14.0,
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
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          searchController.text = "";
          setState(() {
            isExecuted = false;
            isLoading = false;
          });
          FocusScope.of(context).unfocus();
        },
        child: Icon(Icons.search_off_outlined),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
          decoration: InputDecoration(
            hintText: "Search Courses",
            hintStyle: TextStyle(
              color: Colors.grey[700],
              fontSize: 20.0,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Icon(EvaIcons.search),
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });
                      val.searchData(searchController.text).then((value) {
                        snapshot = value;
                        setState(() {
                          isExecuted = true;
                          isLoading = false;
                        });
                      });
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(backgroundColor: Colors.black),
            )
          : isExecuted
              ? snapshot.docs.length == 0
                  ? Container(
                      child: Center(
                        child: Text(
                          "No Courses Found",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    )
                  : searchedResult()
              : Container(
                  child: Center(
                    child: Text(
                      "Search any Courses",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
    );
  }
}
