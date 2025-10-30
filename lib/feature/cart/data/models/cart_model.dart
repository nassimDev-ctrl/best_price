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

// Cart variant for myCart
class CartVariant {
  final int? id;
  final num? discountPrice;
  final String? size;
  final String? color;
  final String? colorHash;
  final List<dynamic>? images; // adjust if needed, e.g. List<String>
  const CartVariant(
      {this.id,
      this.discountPrice,
      this.size,
      this.color,
      this.colorHash,
      this.images});
  CartVariant copyWith(
      {int? id,
      num? discountPrice,
      String? size,
      String? color,
      String? colorHash,
      List<dynamic>? images}) {
    return CartVariant(
      id: id ?? this.id,
      discountPrice: discountPrice ?? this.discountPrice,
      size: size ?? this.size,
      color: color ?? this.color,
      colorHash: colorHash ?? this.colorHash,
      images: images ?? this.images,
    );
  }

  factory CartVariant.fromJson(Map<String, dynamic> json) => CartVariant(
        id: json['id'] as int?,
        discountPrice: json['discountPrice'] as num?,
        size: json['size'] as String?,
        color: json['color'] as String?,
        colorHash: json['colorHash'] as String?,
        images: json['images'] as List<dynamic>?,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'discountPrice': discountPrice,
        'size': size,
        'color': color,
        'colorHash': colorHash,
        'images': images,
      };
  @override
  bool operator ==(Object other) {
    return other is CartVariant &&
        other.id == id &&
        other.discountPrice == discountPrice &&
        other.size == size &&
        other.color == color &&
        other.colorHash == colorHash &&
        other.images == images;
  }

  @override
  int get hashCode =>
      Object.hash(id, discountPrice, size, color, colorHash, images);
}

// Product variant for Product.variants
class ProductVariant {
  final int? id;
  final num? discountPrice;
  final String? size;
  final String? color;
  final String? colorHash;
  const ProductVariant(
      {this.id, this.discountPrice, this.size, this.color, this.colorHash});
  ProductVariant copyWith(
      {int? id,
      num? discountPrice,
      String? size,
      String? color,
      String? colorHash}) {
    return ProductVariant(
      id: id ?? this.id,
      discountPrice: discountPrice ?? this.discountPrice,
      size: size ?? this.size,
      color: color ?? this.color,
      colorHash: colorHash ?? this.colorHash,
    );
  }

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
        id: json['id'] as int?,
        discountPrice: json['discountPrice'] as num?,
        size: json['size'] as String?,
        color: json['color'] as String?,
        colorHash: json['colorHash'] as String?,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'discountPrice': discountPrice,
        'size': size,
        'color': color,
        'colorHash': colorHash,
      };
  @override
  bool operator ==(Object other) {
    return other is ProductVariant &&
        other.id == id &&
        other.discountPrice == discountPrice &&
        other.size == size &&
        other.color == color &&
        other.colorHash == colorHash;
  }

  @override
  int get hashCode => Object.hash(id, discountPrice, size, color, colorHash);
}

class MyCart {
  final int? id;
  final int? quantity;
  final num? price;
  final num? discountedPrice;
  final num? totalPrice;
  final Product? product;
  final CartVariant? variant;
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
          Product? product,
          CartVariant? variant}) =>
      MyCart(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        totalPrice: totalPrice ?? this.totalPrice,
        product: product ?? this.product,
        variant: variant ?? this.variant,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'quantity': quantity,
        'price': price,
        'discountedPrice': discountedPrice,
        'totalPrice': totalPrice,
        'product': product?.toJson(),
        'variant': variant?.toJson(),
      };
  static MyCart fromJson(Map<String, Object?> json) {
    return MyCart(
      id: json['id'] == null ? null : json['id'] as int,
      quantity: json['quantity'] == null ? null : json['quantity'] as int,
      price: json['price'] == null ? null : json['price'] as num?,
      discountedPrice: json['discountedPrice'] == null
          ? null
          : json['discountedPrice'] as num?,
      totalPrice:
          json['totalPrice'] == null ? null : json['totalPrice'] as num?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, Object?>),
      variant: json['variant'] == null
          ? null
          : CartVariant.fromJson(json['variant'] as Map<String, dynamic>),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MyCart &&
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
    return Object.hash(
        id, quantity, price, discountedPrice, totalPrice, product, variant);
  }
}

class Product {
  final int? id;
  final String? image;
  final String? name;
  final num? price;
  final num? discountPrice;
  final bool? isHasVariant;
  final List<ProductVariant>? variants;
  final num? minSellerQuantity;
  const Product(
      {this.id,
      this.image,
      this.price,
      this.discountPrice,
      this.name,
      this.isHasVariant,
      this.variants,
      this.minSellerQuantity});
  Product copyWith(
      {int? id,
      String? image,
      num? price,
      num? discountPrice,
      String? name,
      bool? isHasVariant,
      List<ProductVariant>? variants,
      num? minSellerQuantity}) {
    return Product(
      id: id ?? this.id,
      image: image ?? this.image,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      name: name ?? this.name,
      isHasVariant: isHasVariant ?? this.isHasVariant,
      variants: variants ?? this.variants,
      minSellerQuantity: minSellerQuantity ?? this.minSellerQuantity,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'price': price,
        'discountPrice': discountPrice,
        'isHasVariant': isHasVariant,
        'variants': variants?.map((e) => e.toJson()).toList(),
        'min_seller_quantity': minSellerQuantity,
      };
  static Product fromJson(Map<String, Object?> json) {
    return Product(
      id: json['id'] == null ? null : json['id'] as int?,
      image: json['image'] == null ? null : json['image'] as String?,
      name: json['name'] == null ? null : json['name'] as String?,
      price: json['price'] == null ? null : json['price'] as num?,
      discountPrice:
          json['discountPrice'] == null ? null : json['discountPrice'] as num?,
      isHasVariant:
          json['isHasVariant'] == null ? null : json['isHasVariant'] as bool?,
      variants: json['variants'] == null
          ? null
          : (json['variants'] as List?)
              ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
              .toList(),
      minSellerQuantity: json['min_seller_quantity'] == null
          ? null
          : json['min_seller_quantity'] as num?,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Product &&
        other.id == id &&
        other.image == image &&
        other.name == name &&
        other.price == price &&
        other.discountPrice == discountPrice &&
        other.isHasVariant == isHasVariant &&
        other.variants == variants &&
        other.minSellerQuantity == minSellerQuantity;
  }

  @override
  int get hashCode => Object.hash(id, image, name, price, discountPrice,
      isHasVariant, variants, minSellerQuantity);
}
