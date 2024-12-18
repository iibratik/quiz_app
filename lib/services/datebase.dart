import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class DatabaseMethods {
  // LOGIN EXISTING USER
  Future<Map<String, String>> getExistingUser(
      String username, String password, BuildContext context) async {
    // Удаляем пробелы в начале и конце строк
    username = username.trim();
    password = password.trim();

    // Проверяем, заполнены ли поля
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please fill in both fields',
          style: TextStyle(fontSize: 18),
        ),
      ));
      return {"status": "error", "message": "Fields are empty"};
    }

    try {
      // Получаем данные из коллекции Firestore
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("users_tb").get();

      for (var result in snapshot.docs) {
        final Map<String, dynamic> userData =
            result.data() as Map<String, dynamic>;

        // Проверяем соответствие имени пользователя и пароля
        if (userData['username'] == username &&
            userData['password'] == password) {
          return {
            "status": "success",
            "username": userData['username'],
            "userImage": userData['profilePicture'],
            "userId": result.id
          };
        }
      }

      // Если пользователя с указанными данными не найдено
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Invalid username or password',
          style: TextStyle(fontSize: 18),
        ),
      ));
      return {"status": "error", "message": "Invalid credentials"};
    } catch (e) {
      // Обработка исключений
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
          style: const TextStyle(fontSize: 18),
        ),
      ));
      return {"status": "error", "message": e.toString()};
    }
  }

  // REGISTER NEW USER
  Future<Map<String, String>> setNewUser(File userImage, String userName,
      String password, String confirmPass, BuildContext context) async {
    try {
      // Firestore and Storage references
      final firestore = FirebaseFirestore.instance;
      final storage = FirebaseStorage.instance;

      // Input validation
      if (password != confirmPass) {
        throw Exception("Passwords do not match.");
      }
      if (userName.isEmpty) {
        throw Exception("Username cannot be empty.");
      }
      if (password.isEmpty) {
        throw Exception("Password cannot be empty.");
      }

      // Upload user profile image to Firebase Storage
      String fileName =
          'userProfileImages/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = storage.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(userImage);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Add user details to Firestore
      await firestore.collection('users_tb').add({
        'username': userName,
        'password': password, // Note: Password should ideally be hashed
        'profilePicture': imageUrl,
      });
      Map<String, String> user = {
        'username': userName.toString(),
        'userImage': imageUrl.toString()
      };
      return user;
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error: ${e.toString()}',
          style: const TextStyle(fontSize: 18),
        ),
      ));
      return {"status": "error", "message": e.toString()};
    }
  }

  // ADD QUIZ
  Future addQuizCategory(
      Map<String, dynamic> userQuizCategory, categories) async {
    return await FirebaseFirestore.instance
        .collection(categories)
        .add(userQuizCategory);
  }

// GET QUIZ CATEGORY
  Future<Stream<QuerySnapshot>> getCategoryQuiz(String category) async {
    return FirebaseFirestore.instance.collection(category).snapshots();
  }
}
