import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class CartModel {
  final List<CartItemModel> items;
  final double deliveryFee;

  CartModel({required this.items, this.deliveryFee = 0});

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get total => subtotal + deliveryFee;
}
