import 'dart:developer';

import 'package:best_price/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/logger.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/model/pruduct_details_model.dart';
import '../../../data/repo/product_details_repo.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.id) : super(ProductDetailsInitial()) {
    quantityController = TextEditingController(text: quantity.toString());
    getProductDetails(id);
  }

  final int id;
  static ProductDetailsCubit get(context) => BlocProvider.of(context);
  ProductDetailsModel productDetailsModel = const ProductDetailsModel();
  late TextEditingController quantityController;

  Future<void> getProductDetails(int id) async {
    emit(ProductDetailsCubitLoading());
    log("Item Id $id");
    Either<Failure, ProductDetailsModel> result =
        await getIt.get<ProductDetailsRepo>().getProductDetails(id);
    result.fold((error) {
      LoggerHelper.error(error.errMassage, error.statusCode);
      emit(ProductDetailsCubitFailure(errMessage: error.errMassage));
    }, (getHomePageSuccess) {
      productDetailsModel = getHomePageSuccess;
      // productDetailsModel.data?.images?.add(const Images(
      //     image:
      //         "https://drive.google.com/file/d/10pPaPxrVe4q8oeEOZJVBBD_YtpcInJoe/view?usp=sharing",
      //     type: 11));
      emit(ProductDetailsCubitSuccess());
    });
  }

  int indexImagesDetails = 0;

  onChangeIndexImages(int index) {
    indexImagesDetails = index;
    emit(IndexChanges());
  }

  int colorId = 0;
  Variant? selectedVariant;

  setColor(int id) {
    // Do not allow selecting color before size
    if (sizeId == 0) {
      emit(IndexChanges());
      return;
    }
    colorId = id;
    _updateSelectedVariant();
  }

  int sizeId = 0;
  setSize(int id) {
    sizeId = id;
    // Reset color on size change to force re-selection
    colorId = 0;
    _updateSelectedVariant();
  }

  void _updateSelectedVariant() {
    final variants = productDetailsModel.data?.variants ?? [];

    // Validate that the current size/color combination exists
    if (sizeId != 0 && colorId != 0) {
      final isValid = variants.any(
        (v) => v.size?.id == sizeId && v.color?.id == colorId,
      );
      if (!isValid) {
        // Reset invalid combination
        colorId = 0;
      }
    }

    if (sizeId == 0 || colorId == 0) {
      selectedVariant = null;
      // Reset quantity when variant is deselected
      quantity = 1;
      quantityController.text = quantity.toString();
      emit(IndexChanges());
      return;
    }

    selectedVariant = variants.firstWhere(
      (v) => v.size?.id == sizeId && v.color?.id == colorId,
      orElse: () => const Variant(),
    );

    // Update quantity based on variant availability
    if (selectedVariant?.id != null) {
      final variantQuantity = selectedVariant!.quantity ?? 0;
      if (quantity > variantQuantity && variantQuantity > 0) {
        quantity = variantQuantity;
        quantityController.text = quantity.toString();
      }
    } else {
      quantity = 1;
      quantityController.text = quantity.toString();
    }
    emit(IndexChanges());
  }

  int quantity = 01;
  int quantityData = 1;

  // bool checkIfSizeAndColorExist(
  //     int sizeId, int colorId, List<Variant>? variants) {
  //   if (colorId == 0 || sizeId == 0) {
  //     return true;
  //   }

  //   for (var variant in variants!) {
  //     if (variant.sizeId == sizeId && variant.colorId == colorId) {
  //       quantityData = variant.quantity!;
  //       return true;
  //     }
  //   }

  //   return false;
  // }
  void plusQuantity() {
    int maxQuantity = selectedVariant?.quantity ??
        productDetailsModel.data?.quantity ??
        999999;
    if (quantity < maxQuantity) {
      quantity++;
      quantityController.text = quantity.toString();
      emit(IndexChanges());
    }
  }

  void minQuantity() {
    if (quantity > 1) {
      quantity--;
      quantityController.text = quantity.toString();
    }
    emit(IndexChanges());
  }

  void setQuantity(int value) {
    int maxQuantity = selectedVariant?.quantity ??
        productDetailsModel.data?.quantity ??
        999999;
    if (value >= 1 && value <= maxQuantity) {
      quantity = value;
      quantityController.text = value.toString();
      emit(IndexChanges());
    }
  }
}
