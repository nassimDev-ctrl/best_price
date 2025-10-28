class OrderModel {
  final String shippingAddress;
  final String? name;
  final String? mobile;
  final String? email;
  final List<OrderItem> items;
  final String? note;

  OrderModel(
    this.note, {
    required this.shippingAddress,
    this.name,
    this.mobile,
    this.email,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      "shipping_address": shippingAddress,
      "name": name,
      "mobile": mobile,
      "email": email,
      "items": items.map((item) => item.toJson()).toList(),
      "note": note ?? ""
    };
  }
}

class OrderItem {
  final int productId;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": quantity,
    };
  }
}
