class Item {
  final int id;
  final String item;
  final bool done;
  final int checkListId;
  final DateTime createdAt;
  final String createdBy;
  final DateTime updatedAt;
  final String updatedBy;

  Item({
    required this.id,
    required this.item,
    required this.done,
    required this.checkListId,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      item: json['item'],
      done: json['done'],
      checkListId: json['checkListId'],
      createdAt: DateTime.parse(json['created_at']),
      createdBy: json['created_by'],
      updatedAt: DateTime.parse(json['updated_at']),
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item': item,
      'done': done,
      'checkListId': checkListId,
      'created_at': createdAt.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt.toIso8601String(),
      'updated_by': updatedBy,
    };
  }

  Item copyWith({
    int? id,
    String? item,
    bool? done,
    int? checkListId,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
    String? updatedBy,
  }) {
    return Item(
      id: id ?? this.id,
      item: item ?? this.item,
      done: done ?? this.done,
      checkListId: checkListId ?? this.checkListId,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}

class ItemResponse {
  final bool error;
  final String? message;
  final ItemData data;

  ItemResponse({
    required this.error,
    this.message,
    required this.data,
  });

  factory ItemResponse.fromJson(Map<String, dynamic> json) {
    return ItemResponse(
      error: json['error'],
      message: json['message'],
      data: ItemData.fromJson(json['data']),
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

class ItemData {
  final int count;
  final List<Item> checklist;

  ItemData({
    required this.count,
    required this.checklist,
  });

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      count: json['count'],
      checklist: (json['itemlist'] as List).map((item) => Item.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'itemlist': checklist.map((item) => item.toJson()).toList(),
    };
  }
}
