import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';
import 'package:yasaline/color.dart';
import 'package:yasaline/model/main_rule_model.dart';
import 'package:yasaline/provider/get_rule.dart';
import 'package:yasaline/widgets/matter_item.dart';
import 'package:yasaline/widgets/rule_item.dart';
import 'package:yasaline/widgets/search_matter.dart';

class MatterScreen extends StatefulWidget {
  const MatterScreen({Key? key}) : super(key: key);

  @override
  State<MatterScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<MatterScreen> {
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
    final List<RuleModel>? _listOfMatter =
        Provider.of<GetRullProvider>(context).getRuleList;
    List<RuleModel> _filterRule = [];
    if (_listOfMatter!.isNotEmpty) {
      _filterRule = _listOfMatter.where((rules) {
        return rules.id == id;
      }).toList();
    }
    String _lawDisc = '';
    List _matters = [];
    if (_filterRule.isNotEmpty) {
      _lawDisc = _filterRule[0].description;
      _matters = _filterRule[0].matter;
    }

//scaffold
    return SafeArea(
      child: Scaffold(
          //Appbar
          appBar: AppBar(
            elevation: .5,
            backgroundColor: backroundColor,
            title: Text(
              'Matters',
              style: TextStyle(color: pink),
            ),
            leading: IconButton(
              onPressed: () {
                context.vRouter.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: pink,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: SearchMatterByNumber(_matters, id));
                  },
                  icon: Icon(
                    Icons.search,
                    color: pink,
                    size: 30,
                  ))
            ],
          ),
          backgroundColor: backroundColor,

          //body
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //desc
                  _lawDisc.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.topic,
                                  color: purp,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Note - ' + _lawDisc,
                                  style: TextStyle(color: black, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),

                  //matters list views
                  _listOfMatter.isEmpty || _filterRule.isEmpty
                      ? const Center(child: Text('Empty'))
                      : !loadData
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _matters.length,
                              itemBuilder: (context, index) {
                                return MatterItem(matter:_matters[index]['matter'] ,
                                    lawId: id,
                                    id: _matters[index]['id'],
                                    title: _matters[index]['title'],
                                    description: _matters[index]['description'],
                                    part: _matters[index]['part']);
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
