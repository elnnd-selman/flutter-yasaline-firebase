import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yasaline/model/main_rule_model.dart';

class GetRuleFireStore {
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('rules');
  //getMainRule
  Future<QuerySnapshot>? getMainRule() async {
    return await _firestore.get().catchError((err)=>print(err));
  }
}
