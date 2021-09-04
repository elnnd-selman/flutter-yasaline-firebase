import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';
import 'package:yasaline/color.dart';
import 'package:yasaline/model/main_rule_model.dart';
import 'package:yasaline/provider/get_rule.dart';
import 'package:yasaline/widgets/matter_item.dart';
import 'package:yasaline/widgets/part_item.dart';
import 'package:yasaline/widgets/rule_item.dart';
import 'package:yasaline/widgets/search_part.dart';

class PartScreen extends StatefulWidget {
  const PartScreen({Key? key}) : super(key: key);

  @override
  State<PartScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<PartScreen> {
  bool loadData = true;
  @override
  void initState() {
    super.initState();
    if (Provider.of<GetRullProvider>(context, listen: false)
        .rulesList
        .isEmpty) {
      Provider.of<GetRullProvider>(context, listen: false)
          .addedRuleToList()
          .then((value) => setState(() {
                loadData = false;
              }));
    } else {
      setState(() {
        loadData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String id = context.vRouter.pathParameters['id'] as String;
    String lawId = context.vRouter.pathParameters['lawId'] as String;

//find part list
    final List<RuleModel>? _listOfMatter =
        Provider.of<GetRullProvider>(context).getRuleList;
    List<RuleModel> _filterRule = _listOfMatter!.where((rules) {
      return rules.matter.any((matter) => matter['id'] == id);
    }).toList();
    // var _matterDesc=_filterRule[0].matter.
    var _partList = _filterRule[0].matter.map((e) {
      return e;
    }).toList();

//scaffold
    return SafeArea(
      child: Scaffold(
          //Appbar
          appBar: AppBar(
            elevation: .5,
            backgroundColor: backroundColor,
            title: Text(
              'Parts',
              style: TextStyle(color: pink),
            ),
            leading: IconButton(
              onPressed: () {
                context.vRouter.pop(pathParameters: {'lawId': lawId});
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: pink,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: pink,
                  size: 30,
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchPartByTitle(_partList),
                  );
                },
              ),
            ],
          ),
          backgroundColor: backroundColor,

          //body
          body:
              //  Text('data')
              SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //matters list views
                  !loadData
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _partList.length,
                          itemBuilder: (context, index) {
                            return PartItem(
                              id: _partList[index]['id'],
                              title: _partList[index]['title'],
                              description: _partList[index]['description'],
                            );
                          },
                        )
                      : const CircularProgressIndicator()
                ],
              ),
            ),
          )),
    );
  }
}
