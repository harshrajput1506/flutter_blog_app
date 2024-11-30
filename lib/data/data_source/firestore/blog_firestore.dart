import 'package:blogography/core/dummy_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final dummyList = blogsData;

  void addBlogs() {
    for (var data in dummyList) {
      _db.collection('blogs').add(data);
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchBlogs() async {
    try {
      final ref = _db.collection('blogs');
      final querySnap = await ref.get();
      if (querySnap.docs.isEmpty) throw Exception("Data Not Found");
      return querySnap.docs;
    } catch (e) {
      throw Exception("Failed to load products, error : ${e.toString()}");
    }
  }

  
}
