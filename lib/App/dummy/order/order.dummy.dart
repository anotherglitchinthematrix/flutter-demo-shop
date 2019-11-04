import 'package:course_008/App/dummy/products/products.dummy.dart';
import 'package:course_008/App/providers/index.dart';

final List<OrderItem> dummyOrder = [
  OrderItem(
    id: 'o1',
    total: 382.99,
    date: DateTime.now().add(Duration(days: -5)),
    cart: [
      CartItem(
        id: 'c1',
        product: dummyProducts[0],
        quantity: 3,
      ),
      CartItem(
        id: 'c2',
        product: dummyProducts[1],
        quantity: 2,
      ),
      CartItem(
        id: 'c3',
        product: dummyProducts[2],
        quantity: 1,
      ),
    ],
  ),
];
