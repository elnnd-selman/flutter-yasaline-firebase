import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RuleModel {
  final String id;
  final String title;
  final String description;
  final List matter;

  RuleModel({
    required this.description,
    required this.title,
    required this.id,
    required this.matter,
  });
  factory RuleModel.fromJson(Map<String, dynamic> json) {
    return RuleModel(
      id: json['id'],
      matter: json['matter'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'matter': matter,
      'title': title,
      'description': description,
    };
  }
}

////////
class MatterModel {
  final String id;
  final String title;
  final String description;
  final String matter;
  final List<String> part;

  MatterModel({
    required this.matter,
    required this.part,
    required this.id,
    required this.description,
    required this.title,
  });
}
