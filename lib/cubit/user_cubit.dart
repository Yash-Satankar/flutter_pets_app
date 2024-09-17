import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pets_app/models/user_details_model.dart';

class UserCubit extends Cubit<void> {
  UserCubit() : super(null);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeUserDetails(String userId, UserDetails userDetails) async {
    try {
      await _firestore.collection('users').doc(userId).set(
            userDetails.toMap(),
          );
    } catch (e) {
      print('Error storing user details: $e');
    }
  }

  Future<UserDetails?> getUserDetails(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        return UserDetails.fromMap(userDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
    return null;
  }
}
