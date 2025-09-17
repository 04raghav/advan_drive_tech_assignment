import 'package:quick_order_app/app/core/constants/enums.dart';
import 'package:quick_order_app/app/data/models/item_model.dart';

class RequestModel {
  final String id;
  final String fromUser;
  final List<ItemModel> items;
  final RequestStatus status;
  final DateTime createdAt;

  RequestModel({
    required this.id,
    required this.fromUser,
    required this.items,
    required this.status,
    required this.createdAt,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['_id'],
      fromUser: json['fromUser'],
      items: (json['items'] as List)
          .map((itemJson) => ItemModel.fromJson(itemJson))
          .toList(),
      status: RequestStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RequestStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fromUser': fromUser,
      'items': items.map((item) => item.toJson()).toList(),
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}