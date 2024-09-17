import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pets_app/models/pet_details_model.dart';

class PetCubit extends Cubit<void> {
  PetCubit() : super(null);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addPetDetails(String userId, PetDetails petDetails) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('pets')
          .add(petDetails.toMap());
    } catch (e) {
      print('Error adding pet details: $e');
    }
  }

  Future<List<PetDetails>> getPetDetails(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('pets')
          .get();
      return querySnapshot.docs
          .map((doc) => PetDetails.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching pet details: $e');
      return [];
    }
  }

  Future<List<PetDetails>> getAllPetDetails() async {
    List<PetDetails> allPets = [];

    try {
      QuerySnapshot usersSnapshot = await _firestore.collection('users').get();

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot petsSnapshot = await _firestore
            .collection('users')
            .doc(userDoc.id)
            .collection('pets')
            .get();

        for (var petDoc in petsSnapshot.docs) {
          allPets
              .add(PetDetails.fromMap(petDoc.data() as Map<String, dynamic>));
        }
      }

      return allPets;
    } catch (e) {
      print('Error fetching all pet details: $e');
      return [];
    }
  }
}
