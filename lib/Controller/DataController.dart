import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    return querySnapshot.docs;
  }

  Future getCartData(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('user_id', isEqualTo: userId)
        .get();
    return querySnapshot.docs;
  }

  Future getWishlistData(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('wishlist')
        .where('user_id', isEqualTo: userId)
        .get();
    return querySnapshot.docs;
  }

  Future searchData(String keyword) async {
    return FirebaseFirestore.instance
        .collection('top')
        .where('title', isGreaterThanOrEqualTo: keyword)
        .get();
  }
}
