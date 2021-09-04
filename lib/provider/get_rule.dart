import 'package:flutter/cupertino.dart';
import 'package:yasaline/model/main_rule_model.dart';
import 'package:yasaline/services/get_rule_firestore.dart';

class GetRullProvider extends ChangeNotifier {
  List<RuleModel> rulesList = [];
  Future<void> addedRuleToList() async {
    var dataJson =
        await GetRuleFireStore().getMainRule()!.catchError((err) => print(err));
    ;
    var realData = dataJson.docs.map((e) {
      return RuleModel.fromJson(e.data() as Map<String, dynamic>);
    }).toList();
    print(realData.length);

    rulesList = realData;
  }

  List<RuleModel>? get getRuleList {
    return rulesList;
  }
}
