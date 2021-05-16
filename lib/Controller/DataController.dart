import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    return querySnapshot.docs;
  }

  Future getCartData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('cart').get();
    return querySnapshot.docs;
  }

  Future getWishlistData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('wishlist').get();
    return querySnapshot.docs;
  }

  Future searchData(String keyword) async {
    return FirebaseFirestore.instance
        .collection('top')
        .where('title', isGreaterThanOrEqualTo: keyword)
        .get();
  }
}
