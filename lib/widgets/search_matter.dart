import 'package:flutter/material.dart';
import 'package:yasaline/color.dart';

import 'dart:ui' as ui;

import 'package:yasaline/model/main_rule_model.dart';
import 'package:yasaline/widgets/matter_item.dart';
import 'package:yasaline/widgets/rule_item.dart';

@override
String get searchFieldLabel => 'custom label';

class SearchMatterByNumber extends SearchDelegate {
  final List? data;
  final String lawId;
  SearchMatterByNumber(this.data, this.lawId)
      : super(
            searchFieldLabel: 'Search law',
            searchFieldStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            keyboardType: TextInputType.number);
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
    final List suggestionsMatterList = data!.where((data) {
      return data['matter'].toString().contains(query);
    }).toList();

    return Container(
      padding: EdgeInsets.only(top: 10),
      color: backroundColor,
      child: ListView.builder(
          itemCount: suggestionsMatterList.length,
          itemBuilder: (context, index) {
            return MatterItem(
                matter: suggestionsMatterList[index]['matter'],
                lawId: lawId,
                id: suggestionsMatterList[index]['id'],
                title: suggestionsMatterList[index]['title'],
                description: suggestionsMatterList[index]['description'],
                part: suggestionsMatterList[index]['matter']);
          }),
    );
  }

////////////////////////////////////////////////
  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionsMatterList = data!.where((data) {
      return data['matter'].toString().contains(query);
    }).toList();

    return Container(
      padding: EdgeInsets.only(top: 10),
      color: backroundColor,
      child: ListView.builder(
          itemCount: suggestionsMatterList.length,
          itemBuilder: (context, index) {
            return MatterItem(
                matter: suggestionsMatterList[index]['matter'],
                lawId: lawId,
                id: suggestionsMatterList[index]['id'],
                title: suggestionsMatterList[index]['title'],
                description: suggestionsMatterList[index]['description'],
                part: suggestionsMatterList[index]['part']);
          }),
    );
  }
}
