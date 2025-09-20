class CartModel {
  final String? status;
  final String? message;
  final Data? data;
  final dynamic errors;
  const CartModel({this.status, this.message, this.data, this.errors});
  CartModel copyWith(
      {String? status, String? message, Data? data, dynamic? errors}) {
    return CartModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        errors: errors ?? this.errors);
  }

  Map<String, Object?> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
      'errors': errors
    };
  }

  static CartModel fromJson(Map<String, Object?> json) {
    return CartModel(
        status: json['status'] == null ? null : json['status'] as String,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, Object?>),
        errors: json['errors'] as dynamic);
  }

  @override
  String toString() {
    return '''CartModel(
                  status:$status,
  message:$message,
  data:${data.toString()},
  errors:$errors
      ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is CartModel &&
        other.runtimeType == runtimeType &&
        other.status == status &&
        other.message == message &&
        other.data == data &&
        other.errors == errors;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, status, message, data, errors);
  }
}

class Data {
  final Result? result;
  const Data({this.result});
  Data copyWith({Result? result}) {
    return Data(result: result ?? this.result);
  }

  Map<String, Object?> toJson() {
    return {'result': result?.toJson()};
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
        result: json['result'] == null
            ? null
            : Result.fromJson(json['result'] as Map<String, Object?>));
  }

  @override
  String toString() {
    return '''Data(
                  result:${result.toString()}
      ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.runtimeType == runtimeType &&
        other.result == result;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, result);
  }
}

class Result {
  final num? totalFinally;
  final int? subTotal;
  final List<MyCart>? myCart;
  const Result({this.totalFinally, this.subTotal, this.myCart});
  Result copyWith({int? totalFinally, int? subTotal, List<MyCart>? myCart}) {
    return Result(
        totalFinally: totalFinally ?? this.totalFinally,
        subTotal: subTotal ?? this.subTotal,
        myCart: myCart ?? this.myCart);
  }

  Map<String, Object?> toJson() {
    return {
      'totalFinally': totalFinally,
      'sub_total': subTotal,
      'myCart':
          myCart?.map<Map<String, dynamic>>((data) => data.toJson()).toList()
    };
  }

  static Result fromJson(Map<String, Object?> json) {
    return Result(
        totalFinally:
            json['totalFinally'] == null ? null : json['totalFinally'] as num,
        subTotal: json['sub_total'] == null ? null : json['sub_total'] as int,
        myCart: json['myCart'] == null
            ? null
            : (json['myCart'] as List)
                .map<MyCart>(
                    (data) => MyCart.fromJson(data as Map<String, Object?>))
                .toList());
  }

  @override
  String toString() {
    return '''Result(
                  totalFinally:$totalFinally,
  subTotal:$subTotal,
  myCart:${myCart.toString()}
      ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Result &&
        other.runtimeType == runtimeType &&
        other.totalFinally == totalFinally &&
        other.subTotal == subTotal &&
        other.myCart == myCart;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, totalFinally, subTotal, myCart);
  }
}

class MyCart {
  final int? id;
  final int? quantity;
  final num? price;
  final num? discountedPrice;
  final num? totalPrice;
  final Product? product;
  final dynamic variant;
  const MyCart(
      {this.id,
      this.quantity,
      this.price,
      this.discountedPrice,
      this.totalPrice,
      this.product,
      this.variant});
  MyCart copyWith(
      {int? id,
      int? quantity,
      num? price,
      num? discountedPrice,
      num? totalPrice,
      num? minSellerQuantity,
      Product? product,
      dynamic? variant}) {
    return MyCart(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        totalPrice: totalPrice ?? this.totalPrice,
        product: product ?? this.product,
        variant: variant ?? this.variant);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'price': price,
      'discountedPrice': discountedPrice,
      'totalPrice': totalPrice,
      'product': product?.toJson(),
      'variant': variant
    };
  }

  static MyCart fromJson(Map<String, Object?> json) {
    return MyCart(
      id: json['id'] == null ? null : json['id'] as int,
      quantity: json['quantity'] == null ? null : json['quantity'] as int,
      price: json['price'] == null ? null : json['price'] as num,
      discountedPrice: json['discountedPrice'] == null
          ? null
          : json['discountedPrice'] as num,
      totalPrice: json['totalPrice'] == null ? null : json['totalPrice'] as num,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, Object?>),
      variant: json['variant'] as dynamic,
    );
  }

  @override
  String toString() {
    return '''MyCart(
                  id:$id,
  quantity:$quantity,
  price:$price,
  discountedPrice:$discountedPrice,
  totalPrice:$totalPrice,
  product:${product.toString()},
  variant:$variant
      ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is MyCart &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.quantity == quantity &&
        other.price == price &&
        other.discountedPrice == discountedPrice &&
        other.totalPrice == totalPrice &&
        other.product == product &&
        other.variant == variant;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, quantity, price, discountedPrice,
        totalPrice, product, variant);
  }
}

class Product {
  final int? id;
  final String? image;
  final String? name;
  final num? price;
  final dynamic discountPrice;
  final bool? isHasVariant;
  final dynamic variants;
  final num? minSellerQuantity;

  const Product(
      {this.id,
      this.image,
      this.price,
      this.discountPrice,
      this.name,
      this.isHasVariant,
      this.minSellerQuantity,
      this.variants});
  Product copyWith(
      {int? id,
      String? image,
      int? price,
      dynamic? discountPrice,
      bool? isHasVariant,
      num? minSellerQuantity,
      dynamic? variants}) {
    return Product(
        id: id ?? this.id,
        image: image ?? this.image,
        price: price ?? this.price,
        discountPrice: discountPrice ?? this.discountPrice,
        isHasVariant: isHasVariant ?? this.isHasVariant,
        minSellerQuantity: minSellerQuantity ?? this.minSellerQuantity,
        variants: variants ?? this.variants);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'image': image,
      'price': price,
      'discountPrice': discountPrice,
      'isHasVariant': isHasVariant,
      'variants': variants
    };
  }

  static Product fromJson(Map<String, Object?> json) {
    return Product(
        id: json['id'] == null ? null : json['id'] as int,
        image: json['image'] == null ? null : json['image'] as String,
        name: json['name'] == null ? null : json['name'] as String,
        price: json['price'] == null ? null : json['price'] as num,
        discountPrice: json['discountPrice'] as dynamic,
        isHasVariant:
            json['isHasVariant'] == null ? null : json['isHasVariant'] as bool,
        minSellerQuantity: json['min_seller_quantity'] as num?,
        variants: json['variants'] as dynamic);
  }

  @override
  String toString() {
    return '''Product(
                  id:$id,
  image:$image,
  price:$price,
  discountPrice:$discountPrice,
  isHasVariant:$isHasVariant,
  variants:$variants
      ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Product &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.image == image &&
        other.price == price &&
        other.discountPrice == discountPrice &&
        other.isHasVariant == isHasVariant &&
        other.variants == variants;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType, id, image, price, discountPrice, isHasVariant, variants);
  }
}
