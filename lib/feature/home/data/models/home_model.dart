class HomeApiResponse {
  final String? status;
  final String? message;
  final Data? data;
  final dynamic errors;
  const HomeApiResponse({this.status, this.message, this.data, this.errors});
  HomeApiResponse copyWith(
      {String? status, String? message, Data? data, dynamic errors}) {
    return HomeApiResponse(
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

  static HomeApiResponse fromJson(Map<String, Object?> json) {
    return HomeApiResponse(
        status: json['status'] == null ? null : json['status'] as String,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, Object?>),
        errors: json['errors'] as dynamic);
  }

  @override
  String toString() {
    return '''HomeApiResponse(
                status:$status,
message:$message,
data:${data.toString()},
errors:$errors
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is HomeApiResponse &&
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
  final List<HomeBanner>? banners;
  final List<Category>? categories;
  final List<Product>? newestProducts;
  final List<Product>? featuredProducts;
  final List<Product>? bestSellerProducts;

  const Data({
    this.banners,
    this.categories,
    this.newestProducts,
    this.featuredProducts,
    this.bestSellerProducts,
  });

  Data copyWith({
    List<HomeBanner>? banners,
    List<Category>? categories,
    List<Product>? newestProducts,
    List<Product>? featuredProducts,
    List<Product>? bestSellerProducts,
  }) {
    return Data(
      banners: banners ?? this.banners,
      categories: categories ?? this.categories,
      newestProducts: newestProducts ?? this.newestProducts,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      bestSellerProducts: bestSellerProducts ?? this.bestSellerProducts,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'banners': banners?.map((data) => data.toJson()).toList(),
      'categories': categories?.map((data) => data.toJson()).toList(),
      'newestProducts': newestProducts?.map((data) => data.toJson()).toList(),
      'featuredProducts':
          featuredProducts?.map((data) => data.toJson()).toList(),
      'bestSellerProducts':
          bestSellerProducts?.map((data) => data.toJson()).toList(),
    };
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
      banners: json['banners'] == null
          ? null
          : (json['banners'] as List)
              .map<HomeBanner>(
                  (data) => HomeBanner.fromJson(data as Map<String, Object?>))
              .toList(),
      categories: json['categories'] == null
          ? null
          : (json['categories'] as List)
              .map<Category>(
                  (data) => Category.fromJson(data as Map<String, Object?>))
              .toList(),
      newestProducts: json['newestProducts'] == null
          ? null
          : (json['newestProducts'] as List)
              .map<Product>(
                  (data) => Product.fromJson(data as Map<String, Object?>))
              .toList(),
      featuredProducts: json['featuredProducts'] == null
          ? null
          : (json['featuredProducts'] as List)
              .map<Product>(
                  (data) => Product.fromJson(data as Map<String, Object?>))
              .toList(),
      bestSellerProducts: json['bestSellerProducts'] == null
          ? null
          : (json['bestSellerProducts'] as List)
              .map<Product>(
                  (data) => Product.fromJson(data as Map<String, Object?>))
              .toList(),
    );
  }

  @override
  String toString() {
    return '''Data(
                banners:${banners.toString()},
categories:${categories.toString()},
newestProducts:${newestProducts.toString()},
featuredProducts:${featuredProducts.toString()},
bestSellerProducts:${bestSellerProducts.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.runtimeType == runtimeType &&
        other.banners == banners &&
        other.categories == categories &&
        other.newestProducts == newestProducts &&
        other.featuredProducts == featuredProducts &&
        other.bestSellerProducts == bestSellerProducts;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, banners, categories, newestProducts,
        featuredProducts, bestSellerProducts);
  }
}

class Product {
  final int? id;
  final num? price;
  final dynamic discountPrice;
  final String? name;
  final String? image;
  final String? description;
  final List<String>? images;
  bool? isFavorite;

  static const String _defaultImage = 'https://demo1.weisro.com/newLogo.png';

  Product(
      {this.id,
      this.price,
      this.discountPrice,
      this.name,
      this.description,
      this.images,
      this.isFavorite,
      this.image});

  Product copyWith({
    int? id,
    num? price,
    dynamic discountPrice,
    String? name,
    String? description,
    List<String>? images,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'price': price,
      'discount_price': discountPrice,
      'name': name,
      'description': description,
      'images': images,
      'is_favorite': isFavorite,
    };
  }

  static Product fromJson(Map<String, Object?> json) {
    List<dynamic>? rawImages = json['images'] as List<dynamic>?;
    List<String> parsedImages = [];

    if (rawImages != null && rawImages.isNotEmpty) {
      parsedImages = rawImages
          .map((img) => (img as Map<String, dynamic>)['image'] as String?)
          .whereType<String>()
          .toList();
    }

    if (parsedImages.isEmpty) {
      parsedImages = [_defaultImage];
    }

    return Product(
      id: json['id'] == null ? null : json['id'] as int,
      price: json['price'] == null ? null : json['price'] as num,
      discountPrice: json['discount_price'],
      name: json['name'] == null ? null : json['name'] as String,
      image: json['image'] == null ? null : json['image'] as String,
      description:
          json['description'] == null ? null : json['description'] as String,
      images: parsedImages,
      isFavorite:
          json['is_favorite'] == null ? null : json['is_favorite'] as bool,
    );
  }

  @override
  String toString() {
    return '''Product(
                id:$id,
price:$price,
discountPrice:$discountPrice,
name:$name,
description:$description,
images:$images,
isFavorite:$isFavorite
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Product &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.price == price &&
        other.discountPrice == discountPrice &&
        other.name == name &&
        other.description == description &&
        other.images == images &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, price, discountPrice, name, description,
        images, isFavorite);
  }
}

class Category {
  final int? id;
  final String? image;
  final String? name;
  bool isSelected = false;

  Category({this.id, this.image, this.name});

  Category copyWith({int? id, String? image, String? name}) {
    return Category(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
    };
  }

  static Category fromJson(Map<String, Object?> json) {
    return Category(
      id: json['id'] == null ? null : json['id'] as int,
      image: json['image'] == null ? null : json['image'] as String,
      name: json['name'] == null ? null : json['name'] as String,
    );
  }

  @override
  String toString() {
    return '''Category(
                id:$id,
image:$image,
name:$name
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Category &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.image == image &&
        other.name == name;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, image, name);
  }
}

class HomeBanner {
  final int? id;
  final int? type;
  final int? itemId;
  final dynamic externalLink;
  final String? status;
  final String? image;
  final bool? isSpecial;
  final String? color;
  final String? createdAt;
  final String? title;
  final String? details;

  const HomeBanner({
    this.id,
    this.type,
    this.itemId,
    this.externalLink,
    this.status,
    this.image,
    this.isSpecial,
    this.color,
    this.createdAt,
    this.title,
    this.details,
  });

  HomeBanner copyWith({
    int? id,
    int? type,
    int? itemId,
    dynamic externalLink,
    String? status,
    String? image,
    bool? isSpecial,
    String? color,
    String? createdAt,
    String? title,
    String? details,
  }) {
    return HomeBanner(
      id: id ?? this.id,
      type: type ?? this.type,
      itemId: itemId ?? this.itemId,
      externalLink: externalLink ?? this.externalLink,
      status: status ?? this.status,
      image: image ?? this.image,
      isSpecial: isSpecial ?? this.isSpecial,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      details: details ?? this.details,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'type': type,
      'item_id': itemId,
      'external_link': externalLink,
      'status': status,
      'image': image,
      'is_special': isSpecial,
      'color': color,
      'created_at': createdAt,
      'title': title,
      'details': details,
    };
  }

  static HomeBanner fromJson(Map<String, Object?> json) {
    return HomeBanner(
      id: json['id'] == null ? null : json['id'] as int,
      type: json['type'] == null ? null : json['type'] as int,
      itemId: json['item_id'] == null ? null : json['item_id'] as int,
      externalLink: json['external_link'] as dynamic,
      status: json['status'] == null ? null : json['status'] as String,
      image: json['image'] == null ? null : json['image'] as String,
      isSpecial: json['is_special'] == null ? null : json['is_special'] as bool,
      color: json['color'] == null ? null : json['color'] as String,
      createdAt:
          json['created_at'] == null ? null : json['created_at'] as String,
      title: json['title'] == null ? null : json['title'] as String,
      details: json['details'] == null ? null : json['details'] as String,
    );
  }

  @override
  String toString() {
    return '''HomeBanner(
                id:$id,
type:$type,
itemId:$itemId,
externalLink:$externalLink,
status:$status,
image:$image,
isSpecial:$isSpecial,
color:$color,
createdAt:$createdAt,
title:$title,
details:$details
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is HomeBanner &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.type == type &&
        other.itemId == itemId &&
        other.externalLink == externalLink &&
        other.status == status &&
        other.image == image &&
        other.isSpecial == isSpecial &&
        other.color == color &&
        other.createdAt == createdAt &&
        other.title == title &&
        other.details == details;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, type, itemId, externalLink, status,
        image, isSpecial, color, createdAt, title, details);
  }
}
