import 'package:flutter/material.dart';
import 'package:yasaline/color.dart';

import 'dart:ui' as ui;

import 'package:yasaline/model/main_rule_model.dart';
import 'package:yasaline/widgets/rule_item.dart';

@override
String get searchFieldLabel => 'custom label';

class SearchRuleByTitle extends SearchDelegate {
  final List<RuleModel>? data;

  SearchRuleByTitle(this.data)
      : super(
          searchFieldLabel: 'Search law',
          searchFieldStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        );
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, 'result');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<RuleModel> suggestionsNameList = data!.where((data) {
      return data.title.contains(query);
    }).toList();

    return Container(
      padding: EdgeInsets.only(top: 10),
      color: backroundColor,
      child: ListView.builder(
          itemCount: suggestionsNameList.length,
          itemBuilder: (context, index) {
            return RuleItem(
                id: suggestionsNameList[index].id,
                title: suggestionsNameList[index].title,
                description: suggestionsNameList[index].description,
                matter: suggestionsNameList[index].matter);
          }),
    );
  }

////////////////////////////////////////////////
  @override
  Widget buildSuggestions(BuildContext context) {
    final List<RuleModel> suggestionsNameList = data!.where((data) {
      return data.title.contains(query);
    }).toList();

    return Container(
      padding: EdgeInsets.only(top: 10),
      color: backroundColor,
      child: ListView.builder(
          itemCount: suggestionsNameList.length,
          itemBuilder: (context, index) {
            return RuleItem(
                id: suggestionsNameList[index].id,
                title: suggestionsNameList[index].title,
                description: suggestionsNameList[index].description,
                matter: suggestionsNameList[index].matter);
          }),
    );
  }
}
