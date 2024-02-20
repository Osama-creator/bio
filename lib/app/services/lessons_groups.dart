import 'package:bio/app/data/models/months_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonsAndGroups {
  Future<List<GroupPreviousMonths>> getPrevMonthGroups(String gradeId) async {
    var groupList = <GroupPreviousMonths>[];
    QuerySnapshot categories =
        await FirebaseFirestore.instance.collection('groups').doc(gradeId).collection('group previous months').get();

    groupList.clear();

    for (var category in categories.docs) {
      groupList.add(GroupPreviousMonths.fromJson(category.data() as Map<String, dynamic>));
    }
    return groupList;
  }

  Future<List<GroupPreviousMonths>> deleteGroupMonthService(String monthId, String gradeId) async {
    var groupList = <GroupPreviousMonths>[];

    await FirebaseFirestore.instance
        .collection('groups')
        .doc(gradeId)
        .collection('group previous months')
        .doc(monthId)
        .delete();
    groupList.removeWhere((month) => month.groupId == monthId);
    return groupList;
  }
}
