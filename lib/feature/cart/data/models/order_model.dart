class OrderModel {
  final String shippingAddress;
  final String? name;
  final String? mobile;
  final String? email;
  final List<OrderItem> items;
  final String? note;
  final String? couponCode;

  OrderModel(
    this.note, {
    required this.shippingAddress,
    this.name,
    this.mobile,
    this.email,
    required this.items,
    this.couponCode,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      "shipping_address": shippingAddress,
      "name": name,
      "mobile": mobile,
      "email": email,
      "items": items.map((item) => item.toJson()).toList(),
      "note": note ?? ""
    };
    if (couponCode != null && couponCode!.isNotEmpty) {
      map["coupon_code"] = couponCode;
    }
    return map;
  }
}

class OrderItem {
  final int productId;
  final int quantity;
  final int? variantId;

  const OrderItem({
    required this.productId,
    required this.quantity,
    this.variantId,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "product_id": productId,
      "quantity": quantity,
    };
    if (variantId != null) {
      data["variant_id"] = variantId;
    }
    return data;
  }
}
