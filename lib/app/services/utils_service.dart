import 'package:bio/app/data/models/grade_item_model.dart';
import 'package:bio/app/data/models/group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UtilsService {
  Future<List<Group>> getGroupsFromAPI() async {
    var groupList = <Group>[];
    QuerySnapshot categories = await FirebaseFirestore.instance.collection('groups').get();
    groupList.clear();
    for (var category in categories.docs) {
      groupList.add(Group.fromJson(category.data() as Map<String, dynamic>));
    }

    return groupList;
  }

  Future<void> deleteGroup(String groupId) async {
    await FirebaseFirestore.instance.collection('groups').doc(groupId).delete();
  }

  Future<void> createGrade(GradeItem grade) async {
    CollectionReference groupCollection = FirebaseFirestore.instance.collection('grades');
    await groupCollection.add(grade.toJson());
  }

  Future<void> updateGrade(GradeItem grade) async {
    DocumentReference gradeRef = FirebaseFirestore.instance.collection('grades').doc(grade.id);
    await gradeRef.update({'name': grade.name});
  }

  Future<void> deleteGrade(String grageId) async {
    DocumentReference gradeRef = FirebaseFirestore.instance.collection('grades').doc(grageId);
    await gradeRef.delete();
  }

  Future<List<GradeItem>> getGradesFromApi() async {
    var gradeList = <GradeItem>[];

    QuerySnapshot grades = await FirebaseFirestore.instance.collection('grades').get();
    gradeList.clear();
    for (var category in grades.docs) {
      gradeList.add(GradeItem(
        name: category['name'],
        id: category.id,
      ));
    }
    return gradeList;
  }

  void icCurrentSessionsApi({required Group group}) {
    FirebaseFirestore.instance.collection('groups').doc(group.id).collection('group previous months').add({
      'sessions': int.parse(group.sessions!),
      'date': DateTime.now(),
      'students': group.students!.map((s) => s.toJson()).toList(),
    });

    // Update group current session to 0 and students absence to 0
  }
}
