class ProductDetailsModel {
  final String? status;
  final String? message;
  final Data? data;
  final dynamic errors;
  const ProductDetailsModel(
      {this.status, this.message, this.data, this.errors});
  ProductDetailsModel copyWith(
      {String? status, String? message, Data? data, dynamic? errors}) {
    return ProductDetailsModel(
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

  static ProductDetailsModel fromJson(Map<String, Object?> json) {
    return ProductDetailsModel(
        status: json['status'] == null ? null : json['status'] as String,
        message: json['message'] == null ? null : json['message'] as String,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, Object?>),
        errors: json['errors'] as dynamic);
  }

  @override
  String toString() {
    return '''ProductDetailsModel(
                status:$status,
message:$message,
data:${data.toString()},
errors:$errors
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailsModel &&
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
  final int? id;
  final String? image;
  final String? video;
  final num? price;
  final num? discountPrice;
  final bool? featured;
  final String? offerEndDate;
  final int? quantity;
  final bool? isHasVariant;
  final String? status;
  final int? markLabel;
  final int? isBestSeller;
  final String? createdAt;
  final String? name;
  final String? description;
  final List<Images>? images;
  final List<Variant>? variants;
  final int? minSellerQuantity;
  final bool? isSeller;
  final bool? isFavorite;
  final dynamic rate;
  const Data({
    this.id,
    this.image,
    this.price,
    this.discountPrice,
    this.featured,
    this.offerEndDate,
    this.quantity,
    this.isHasVariant,
    this.status,
    this.markLabel,
    this.isBestSeller,
    this.createdAt,
    this.name,
    this.description,
    this.images,
    this.variants,
    this.video,
    this.rate,
    this.minSellerQuantity,
    this.isSeller,
    this.isFavorite,
  });
  Data copyWith(
      {int? id,
      String? image,
      int? price,
      int? discountPrice,
      bool? featured,
      String? offerEndDate,
      int? quantity,
      bool? isHasVariant,
      String? status,
      int? markLabel,
      int? isBestSeller,
      String? createdAt,
      String? name,
      String? description,
      List<Images>? images,
      List<Variant>? variants,
      dynamic? rate,
      bool? isFavorite}) {
    return Data(
        id: id ?? this.id,
        image: image ?? this.image,
        price: price ?? this.price,
        discountPrice: discountPrice ?? this.discountPrice,
        featured: featured ?? this.featured,
        offerEndDate: offerEndDate ?? this.offerEndDate,
        quantity: quantity ?? this.quantity,
        isHasVariant: isHasVariant ?? this.isHasVariant,
        status: status ?? this.status,
        markLabel: markLabel ?? this.markLabel,
        isBestSeller: isBestSeller ?? this.isBestSeller,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        description: description ?? this.description,
        images: images ?? this.images,
        variants: variants ?? this.variants,
        rate: rate ?? this.rate,
        isFavorite: isFavorite ?? this.isFavorite);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'image': image,
      'price': price,
      'discount_price': discountPrice,
      'featured': featured,
      'offer_end_date': offerEndDate,
      'quantity': quantity,
      'is_has_variant': isHasVariant,
      'status': status,
      'mark_label': markLabel,
      'is_best_seller': isBestSeller,
      'created_at': createdAt,
      'name': name,
      'description': description,
      'images':
          images?.map<Map<String, dynamic>>((data) => data.toJson()).toList(),
      'variants':
          variants?.map<Map<String, dynamic>>((v) => v.toJson()).toList(),
      'rate': rate,
      'is_favorite': isFavorite,
    };
  }

  static Data fromJson(Map<String, Object?> json) {
    return Data(
      id: json['id'] == null ? null : json['id'] as int,
      image: json['image'] == null ? null : json['image'] as String,
      video: json['video'] == null ? null : json['video'] as String,
      price: json['price'] == null ? null : json['price'] as num,
      discountPrice:
          json['discount_price'] == null ? null : json['discount_price'] as num,
      featured: json['featured'] == null ? null : json['featured'] as bool,
      offerEndDate: json['offer_end_date'] == null
          ? null
          : json['offer_end_date'] as String,
      quantity: json['quantity'] == null ? null : json['quantity'] as int,
      isHasVariant: json['is_has_variant'] == null
          ? null
          : json['is_has_variant'] as bool,
      status: json['status'] == null ? null : json['status'] as String,
      markLabel: json['mark_label'] == null ? null : json['mark_label'] as int,
      isBestSeller:
          json['is_best_seller'] == null ? null : json['is_best_seller'] as int,
      createdAt:
          json['created_at'] == null ? null : json['created_at'] as String,
      name: json['name'] == null ? null : json['name'] as String,
      description:
          json['description'] == null ? null : json['description'] as String,
      images: json['images'] == null
          ? null
          : (json['images'] as List)
              .map<Images>(
                  (data) => Images.fromJson(data as Map<String, Object?>))
              .toList(),
      variants: json['variants'] == null
          ? null
          : (json['variants'] as List)
              .map<Variant>(
                  (data) => Variant.fromJson(data as Map<String, Object?>))
              .toList(),
      rate: json['rate'] as dynamic,
      minSellerQuantity: json["min_seller_quantity"] == null
          ? null
          : json["min_seller_quantity"] as int,
      isSeller: json['isSeller'] == null ? null : json['isSeller'] as bool,
      isFavorite:
          json['is_favorite'] == null ? null : json['is_favorite'] as bool,
    );
  }

  @override
  String toString() {
    return '''Data(
                id:$id,
image:$image,
price:$price,
discountPrice:$discountPrice,
featured:$featured,
offerEndDate:$offerEndDate,
quantity:$quantity,
isHasVariant:$isHasVariant,
status:$status,
markLabel:$markLabel,
isBestSeller:$isBestSeller,
createdAt:$createdAt,
name:$name,
description:$description,
images:${images.toString()},
variants:$variants,
rate:$rate
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.image == image &&
        other.price == price &&
        other.discountPrice == discountPrice &&
        other.featured == featured &&
        other.offerEndDate == offerEndDate &&
        other.quantity == quantity &&
        other.isHasVariant == isHasVariant &&
        other.status == status &&
        other.markLabel == markLabel &&
        other.isBestSeller == isBestSeller &&
        other.createdAt == createdAt &&
        other.name == name &&
        other.description == description &&
        other.images == images &&
        other.variants == variants &&
        other.rate == rate &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        image,
        price,
        discountPrice,
        featured,
        offerEndDate,
        quantity,
        isHasVariant,
        status,
        markLabel,
        isBestSeller,
        createdAt,
        name,
        description,
        images,
        variants,
        rate,
        isFavorite);
  }
}

class Images {
  final String? image;
  final int? type;
  const Images({this.image, this.type});
  Images copyWith({String? image, int? type}) {
    return Images(image: image ?? this.image, type: type ?? this.type);
  }

  Map<String, Object?> toJson() {
    return {'image': image, 'type': type};
  }

  static Images fromJson(Map<String, Object?> json) {
    return Images(
        image: json['image'] == null ? null : json['image'] as String,
        type: json['type'] == null ? null : json['type'] as int);
  }

  @override
  String toString() {
    return '''Images(
                image:$image,
type:$type
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Images &&
        other.runtimeType == runtimeType &&
        other.image == image &&
        other.type == type;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, image, type);
  }
}

class Variant {
  final int? id;
  final num? price;
  final int? quantity;
  final num? discountPrice;
  final String? offerEndDate;
  final String? status;
  final VariantSize? size;
  final VariantColor? color;
  final List<Images>? images;
  const Variant({
    this.id,
    this.price,
    this.quantity,
    this.discountPrice,
    this.offerEndDate,
    this.status,
    this.size,
    this.color,
    this.images,
  });

  static num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }

  Variant copyWith({
    int? id,
    num? price,
    int? quantity,
    num? discountPrice,
    String? offerEndDate,
    String? status,
    VariantSize? size,
    VariantColor? color,
    List<Images>? images,
  }) {
    return Variant(
      id: id ?? this.id,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      discountPrice: discountPrice ?? this.discountPrice,
      offerEndDate: offerEndDate ?? this.offerEndDate,
      status: status ?? this.status,
      size: size ?? this.size,
      color: color ?? this.color,
      images: images ?? this.images,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'price': price,
      'quantity': quantity,
      'discount_price': discountPrice,
      'offer_end_date': offerEndDate,
      'status': status,
      'size': size?.toJson(),
      'color': color?.toJson(),
      'images': images?.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
    };
  }

  static Variant fromJson(Map<String, Object?> json) {
    return Variant(
      id: json['id'] == null ? null : json['id'] as int,
      price: _parseNum(json['price']),
      quantity: json['quantity'] == null ? null : json['quantity'] as int,
      discountPrice: _parseNum(json['discount_price']),
      offerEndDate: json['offer_end_date'] == null
          ? null
          : json['offer_end_date'] as String,
      status: json['status'] == null ? null : json['status'] as String,
      size: json['size'] == null
          ? null
          : VariantSize.fromJson(json['size'] as Map<String, Object?>),
      color: json['color'] == null
          ? null
          : VariantColor.fromJson(json['color'] as Map<String, Object?>),
      images: json['images'] == null
          ? null
          : (json['images'] as List)
              .map<Images>((e) => Images.fromJson(e as Map<String, Object?>))
              .toList(),
    );
  }

  @override
  String toString() {
    return '''Variant(
                id:$id,
price:$price,
quantity:$quantity,
discountPrice:$discountPrice,
offerEndDate:$offerEndDate,
status:$status,
size:${size.toString()},
color:${color.toString()},
images:${images.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Variant &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.price == price &&
        other.quantity == quantity &&
        other.discountPrice == discountPrice &&
        other.offerEndDate == offerEndDate &&
        other.status == status &&
        other.size == size &&
        other.color == color &&
        other.images == images;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, price, quantity, discountPrice,
        offerEndDate, status, size, color, images);
  }
}

class VariantSize {
  final int? id;
  final String? name;
  final String? unit;
  final VariantCollection? collection;
  const VariantSize({this.id, this.name, this.unit, this.collection});

  VariantSize copyWith(
      {int? id, String? name, String? unit, VariantCollection? collection}) {
    return VariantSize(
        id: id ?? this.id,
        name: name ?? this.name,
        unit: unit ?? this.unit,
        collection: collection ?? this.collection);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'collection': collection?.toJson(),
    };
  }

  static VariantSize fromJson(Map<String, Object?> json) {
    return VariantSize(
      id: json['id'] == null ? null : json['id'] as int,
      name: json['name'] == null ? null : json['name'] as String,
      unit: json['unit'] == null ? null : json['unit'] as String,
      collection: json['collection'] == null
          ? null
          : VariantCollection.fromJson(
              json['collection'] as Map<String, Object?>),
    );
  }

  @override
  String toString() {
    return '''VariantSize(
                id:$id,
name:$name,
unit:$unit,
collection:${collection.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is VariantSize &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.name == name &&
        other.unit == unit &&
        other.collection == collection;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, name, unit, collection);
  }
}

class VariantCollection {
  final int? id;
  final String? nameAr;
  final String? nameEn;
  final String? descriptionAr;
  final String? descriptionEn;
  const VariantCollection({
    this.id,
    this.nameAr,
    this.nameEn,
    this.descriptionAr,
    this.descriptionEn,
  });

  VariantCollection copyWith({
    int? id,
    String? nameAr,
    String? nameEn,
    String? descriptionAr,
    String? descriptionEn,
  }) {
    return VariantCollection(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
    };
  }

  static VariantCollection fromJson(Map<String, Object?> json) {
    return VariantCollection(
      id: json['id'] == null ? null : json['id'] as int,
      nameAr: json['name_ar'] == null ? null : json['name_ar'] as String,
      nameEn: json['name_en'] == null ? null : json['name_en'] as String,
      descriptionAr: json['description_ar'] == null
          ? null
          : json['description_ar'] as String,
      descriptionEn: json['description_en'] == null
          ? null
          : json['description_en'] as String,
    );
  }

  @override
  String toString() {
    return '''VariantCollection(
                id:$id,
nameAr:$nameAr,
nameEn:$nameEn,
descriptionAr:$descriptionAr,
descriptionEn:$descriptionEn
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is VariantCollection &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.nameAr == nameAr &&
        other.nameEn == nameEn &&
        other.descriptionAr == descriptionAr &&
        other.descriptionEn == descriptionEn;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType, id, nameAr, nameEn, descriptionAr, descriptionEn);
  }
}

class VariantColor {
  final int? id;
  final String? name;
  final String? hash;
  const VariantColor({this.id, this.name, this.hash});

  VariantColor copyWith({int? id, String? name, String? hash}) {
    return VariantColor(
        id: id ?? this.id, name: name ?? this.name, hash: hash ?? this.hash);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'hash': hash,
    };
  }

  static VariantColor fromJson(Map<String, Object?> json) {
    return VariantColor(
      id: json['id'] == null ? null : json['id'] as int,
      name: json['name'] == null ? null : json['name'] as String,
      hash: json['hash'] == null ? null : json['hash'] as String,
    );
  }

  @override
  String toString() {
    return '''VariantColor(
                id:$id,
name:$name,
hash:$hash
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is VariantColor &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.name == name &&
        other.hash == hash;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, name, hash);
  }
}
