import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:registrations/models/user.dart';

class FirestoreUserService {
  static const String projectId = 'sygoat-3687c';
  static const String baseUrl =
      'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents';
  // Helper method to build URL
  String _buildUrl(String collection, [String? documentId]) {
    if (documentId != null) {
      return '$baseUrl/$collection/$documentId';
    }
    return '$baseUrl/$collection';
  }

  Future<String?> createDocument(
    String collection,
    Map<String, dynamic> data,
  ) async {
    try {
      final url = _buildUrl(collection);
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Extract document ID from the name field
        final name = responseData['name'] as String;
        return name.split('/').last;
      } else {
        print('Error response: ${response.body}');
        throw Exception('Failed to create document: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating document: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> readAllDocuments(
    String collection,
  ) async {
    try {
      final url = _buildUrl(collection);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final documents = responseData['documents'] as List<dynamic>? ?? [];

        return documents.map((doc) {
          final docMap = doc as Map<String, dynamic>;
          final name = docMap['name'] as String;
          final documentId = name.split('/').last;
          docMap['id'] = documentId;
          return docMap;
        }).toList();
      } else {
        throw Exception('Failed to read documents: ${response.statusCode}');
      }
    } catch (e) {
      print('Error reading documents: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> readDocumentById(
    String collection,
    String documentId,
  ) async {
    try {
      final url = _buildUrl(collection, documentId);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        responseData['id'] = documentId;
        return responseData;
      } else if (response.statusCode == 404) {
        return null; // Document doesn't exist
      } else {
        throw Exception('Failed to read document: ${response.statusCode}');
      }
    } catch (e) {
      print('Error reading document by ID: $e');
      return null;
    }
  }

  Future<bool> updateDocument(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    try {
      final url = _buildUrl(collection, documentId);
      final response = await http.patch(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error response: ${response.body}');
        throw Exception('Failed to update document: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating document: $e');
      return false;
    }
  }

  Future<bool> deleteDocument(String collection, String documentId) async {
    try {
      final url = _buildUrl(collection, documentId);
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete document: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting document: $e');
      return false;
    }
  }

  Future<String?> createUser(User user) async {
    user.createdAt = DateTime.now();
    user.updatedAt = DateTime.now();
    return await createDocument('users', user.toFirestoreJson());
  }

  Future<List<User>> getAllUsers() async {
    final documents = await readAllDocuments('users');
    if (documents == null) return [];

    return documents
        .map((doc) => User.fromFirestoreJson(doc, documentId: doc['id']))
        .toList();
  }

  Future<User?> getUserById(String userId) async {
    final doc = await readDocumentById('users', userId);
    if (doc == null) return null;
    return User.fromFirestoreJson(doc, documentId: userId);
  }

  Future<bool> updateUser(String userId, User user) async {
    user.updatedAt = DateTime.now();
    return await updateDocument('users', userId, user.toFirestoreJson());
  }

  // Delete user
  Future<bool> deleteUser(String userId) async {
    return await deleteDocument('users', userId);
  }
}
