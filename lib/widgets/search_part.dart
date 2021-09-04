import 'package:flutter/material.dart';
import 'package:yasaline/color.dart';

import 'package:yasaline/widgets/matter_item.dart';
import 'package:yasaline/widgets/part_item.dart';

@override
String get searchFieldLabel => 'custom label';

class SearchPartByTitle extends SearchDelegate {
  final List? data;

  SearchPartByTitle(this.data)
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
    final List suggestionsPartList = data!.where((data) {
      return data['title'].toString().contains(query);
    }).toList();

    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: backroundColor,
      child: ListView.builder(
          itemCount: suggestionsPartList.length,
          itemBuilder: (context, index) {
            return PartItem(
              id: suggestionsPartList[index]['id'],
              title: suggestionsPartList[index]['title'],
              description: suggestionsPartList[index]['description'],
            );
          }),
    );
  }

////////////////////////////////////////////////
  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionsPartList = data!.where((data) {
      return data['title'].toString().contains(query);
    }).toList();

    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: backroundColor,
      child: ListView.builder(
          itemCount: suggestionsPartList.length,
          itemBuilder: (context, index) {
            return PartItem(
              id: suggestionsPartList[index]['id'],
              title: suggestionsPartList[index]['title'],
              description: suggestionsPartList[index]['description'],
            );
          }),
    );
  }
}
