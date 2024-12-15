import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addQuizCategory(
      Map<String, dynamic> userQuizCategory, categories) async {
    return await FirebaseFirestore.instance
        .collection(categories)
        .add(userQuizCategory);
  }

  Future<Stream<QuerySnapshot>> getCategoryQuiz(String category) async {
    return FirebaseFirestore.instance.collection(category).snapshots();
  }
}
