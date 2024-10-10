import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/user.dart';

class UserDao {
  static CollectionReference<UserApp> getUserCollection() {
    return FirebaseFirestore.instance.collection('users').withConverter(
          fromFirestore: (snapshot, options) =>
              UserApp.fromFireStore(snapshot.data()),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFirebase(UserApp user) {
    var userCollection = getUserCollection();
    var doc = userCollection.doc(user.id);
    return doc.set(user);
  }

  static Future<UserApp?> getUserFromFirebase(String uid) async {
    var usersCollection = getUserCollection();
    var docRef = usersCollection.doc(uid);
    var docSnapShot = await docRef.get();
    return docSnapShot.data();
  }
}
