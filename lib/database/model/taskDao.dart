import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/model/task.dart';
import 'package:todo/database/model/user_dao.dart';

class TasksDao {
  static CollectionReference<Task> getTasksCollection(String uid) {
    var userCollection = UserDao.getUserCollection();
    var userDoc = userCollection.doc(uid);
    return userDoc.collection('tasks').withConverter(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()),
          toFirestore: (task, options) => task.toFireStore(),
        );
  }

  static Future<void> addTask(Task task, String uid) {
    var tasksCollection = getTasksCollection(uid);
    var taskDoc = tasksCollection.doc();
    return taskDoc.set(task);
  }

  static Future<List<Task>> readAllTasks(String uid) async {
    var tasksCollection = getTasksCollection(uid);
    var taskSnapShot = await tasksCollection.get();
    var tasksList = taskSnapShot.docs
        .map(
          (docSnapShot) => docSnapShot.data(),
        )
        .toList();

    return tasksList;
  }

  static Stream<QuerySnapshot<Task>> getAllTasksRealTime(
      String uid, DateTime selectedDate) async* {
    var tasksCollection =
        getTasksCollection(uid).where('taskDate', isEqualTo: selectedDate);
    var stream = await tasksCollection.snapshots();
    yield* stream;
  }

  static Future<void> deleteTask(String uid, String taskId) async {
    var taskCollection = getTasksCollection(uid);
    var docRef = taskCollection.doc(taskId);
    return docRef.delete();
  }
}
