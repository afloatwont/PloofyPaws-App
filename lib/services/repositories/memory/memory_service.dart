import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/memory/memory_model.dart';

class MemoryService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final GetIt _getIt = GetIt.instance;
  late AuthServices _authService;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  late CollectionReference<MemoryList> _memoryCollection;

  MemoryService() {
    setupCollectionReferences();
  }

  void setupCollectionReferences() {
    _memoryCollection =
        _firebaseFirestore.collection('memories').withConverter<MemoryList>(
              fromFirestore: (snapshot, _) =>
                  MemoryList.fromJson(snapshot.data()!),
              toFirestore: (memoryList, _) => memoryList.toJson(),
            );
  }

  Future<void> createMemory(MemoryModel memory, File photo) async {
    try {
      final docRef = _memoryCollection.doc(memory.userId); // Use userId as document ID
      String url = await uploadPhoto(memory.userId!, photo);
      memory.photoUrls = [url];
      
      DocumentSnapshot documentSnapshot = await docRef.get();
      MemoryList memoryList;
      if (documentSnapshot.exists) {
        memoryList = documentSnapshot.data() as MemoryList;
        memoryList.memories?.add(memory);
        await docRef.update(memoryList.toJson());
      } else {
        memoryList = MemoryList(memories: [memory]);
        await docRef.set(memoryList);
      }
      print("Memory Created");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String> uploadPhoto(String userId, File photo) async {
    try {
      Reference storageReference = _firebaseStorage
          .ref()
          .child('memories/$userId/${photo.uri.pathSegments.last}');

      UploadTask uploadTask = storageReference.putFile(photo);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print(e);
      return Future.error('Error uploading photo');
    }
  }

  Future<void> deleteMemory(String userId, MemoryModel memory) async {
    try {
      final docRef = _memoryCollection.doc(userId);
      DocumentSnapshot documentSnapshot = await docRef.get();
      if (documentSnapshot.exists) {
        MemoryList memoryList = documentSnapshot.data() as MemoryList;

        // Delete photos from storage
        for (String photoUrl in memory.photoUrls!) {
          Reference photoRef = _firebaseStorage.refFromURL(photoUrl);
          await photoRef.delete();
        }

        // Remove the memory from the list
        memoryList.memories?.removeWhere((m) => m.title == memory.title && m.date == memory.date);

        // Update the document or delete it if no memories are left
        if (memoryList.memories?.isEmpty ?? true) {
          await docRef.delete();
        } else {
          await docRef.set(memoryList);
        }
      }

      print("Memory Deleted");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<List<MemoryModel>> getMemories(String userId) async {
    try {
      DocumentSnapshot docSnapshot = await _memoryCollection.doc(userId).get();
      if (docSnapshot.exists) {
        MemoryList memoryList = docSnapshot.data() as MemoryList;
        return memoryList.memories ?? [];
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        return [];
      }
      return Future.error('Error retrieving memories');
    }
  }
}
