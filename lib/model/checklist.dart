import 'package:primajasa/model/item.dart';

class ChecklistResponse {
  final bool error;
  final String? message;
  final ChecklistData data;

  ChecklistResponse({
    required this.error,
    this.message,
    required this.data,
  });

  factory ChecklistResponse.fromJson(Map<String, dynamic> json) {
    return ChecklistResponse(
      error: json['error'],
      message: json['message'],
      data: ChecklistData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ChecklistData {
  final int count;
  final List<Checklist> checklist;

  ChecklistData({
    required this.count,
    required this.checklist,
  });

  factory ChecklistData.fromJson(Map<String, dynamic> json) {
    return ChecklistData(
      count: json['count'],
      checklist: (json['checklist'] as List).map((item) => Checklist.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'checklist': checklist.map((item) => item.toJson()).toList(),
    };
  }
}


class Checklist {
  final int id;
  final String title;
  final bool done;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Item> items;

  Checklist({
    required this.id,
    required this.title,
    required this.done,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  Checklist copyWith({
    int? id,
    String? title,
    bool? done,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Item>? items,
  }) {
    return Checklist(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }


  factory Checklist.fromJson(Map<String, dynamic> json) {
    return Checklist(
      id: json['id'],
      title: json['title'],
      done: json['done'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: List<Item>.from(json['items']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'items': items,
    };
  }
}
