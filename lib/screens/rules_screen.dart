import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yasaline/color.dart';
import 'package:yasaline/model/main_rule_model.dart';
import 'package:yasaline/provider/get_rule.dart';
import 'package:yasaline/widgets/rule_item.dart';
import 'package:yasaline/widgets/seacrh_rules.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({Key? key}) : super(key: key);

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  bool loadData = true;
  @override
  void initState() {
    super.initState();
    if (Provider.of<GetRullProvider>(context, listen: false)
        .rulesList
        .isEmpty) {
      Provider.of<GetRullProvider>(context, listen: false)
          .addedRuleToList()
          .then((value) {
        setState(() {
          loadData = false;
        });
      });
    } else {
      setState(() {
        loadData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //list of rule
    final List<RuleModel>? _listOfrule =
        Provider.of<GetRullProvider>(context).getRuleList;
//scaffold
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: backroundColor,
          //   elevation: 0,
          //   title: Text(
          //     'Laws',
          //     style: TextStyle(
          //       color: pink,
          //     ),
          //   ),
          //   actions: [
          //     IconButton(
          //       onPressed: () {
          //         showSearch(
          //             context: context,
          //             delegate: SearchRuleByTitle(_listOfrule));
          //       },
          //       icon: Icon(
          //         Icons.search,
          //         color: pink,
          //         size: 30,
          //       ),
          //     )
          //   ],
          // ),
          backgroundColor: backroundColor,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //custom appbar
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Icons.clear_all
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.drag_handle,
                                  color: pink, size: 30),
                            ),
                            IconButton(
                              onPressed: () {
                                showSearch(
                                    context: context,
                                    delegate: SearchRuleByTitle(_listOfrule));
                              },
                              icon: Icon(Icons.search, color: pink, size: 30),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'YASAKAN',
                          style: TextStyle(
                              color: pink,
                              fontSize: 30,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'nwekrawatawa la 3/9/2021',
                          style: TextStyle(
                            color: pink,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  !loadData
                      ? _listOfrule!.isEmpty
                          ? const Center(
                              child: Text('Empty'),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _listOfrule.length,
                              itemBuilder: (context, index) {
                                return RuleItem(
                                    id: _listOfrule[index].id,
                                    title: _listOfrule[index].title,
                                    description: _listOfrule[index].description,
                                    matter: _listOfrule[index].matter);
                              },
                            )
                      : Center(
                          child: CircularProgressIndicator(
                            color: pink,
                            strokeWidth: .3,
                          ),
                        )
                ],
              ),
            ),
          )),
    );
  }
}
