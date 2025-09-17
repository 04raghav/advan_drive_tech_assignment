import 'package:quick_order_app/app/core/constants/enums.dart';
import 'package:quick_order_app/app/data/models/item_model.dart';
import 'package:quick_order_app/app/data/models/request_model.dart';

class MockRequestRepository {
  List<RequestModel> getEndUserRequests() {
    return [
      RequestModel(
        id: 'req_101',
        fromUser: 'User A',
        items: [
          ItemModel(id: 'item_1', name: 'Milk'),
          ItemModel(id: 'item_2', name: 'Bread'),
          ItemModel(id: 'item_3', name: 'Eggs'),
        ],
        status: RequestStatus.confirmed,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      RequestModel(
        id: 'req_102',
        fromUser: 'User A',
        items: [
          ItemModel(id: 'item_4', name: 'Coffee'),
          ItemModel(id: 'item_5', name: 'Tea'),
        ],
        status: RequestStatus.partiallyFulfilled,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
       RequestModel(
        id: 'req_103',
        fromUser: 'User A',
        items: [
          ItemModel(id: 'item_6', name: 'Apples'),
          ItemModel(id: 'item_7', name: 'Bananas'),
        ],
        status: RequestStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  List<RequestModel> getReceiverRequests() {
    return [
      RequestModel(
        id: 'req_201',
        fromUser: 'User A',
        items: [
          ItemModel(id: 'item_1', name: 'Milk'),
          ItemModel(id: 'item_2', name: 'Bread'),
          ItemModel(id: 'item_3', name: 'Eggs'),
        ],
        status: RequestStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      RequestModel(
        id: 'req_202',
        fromUser: 'User B',
        items: [
          ItemModel(id: 'item_4', name: 'Apples'),
          ItemModel(id: 'item_5', name: 'Bananas'),
        ],
        status: RequestStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
    ];
  }
}