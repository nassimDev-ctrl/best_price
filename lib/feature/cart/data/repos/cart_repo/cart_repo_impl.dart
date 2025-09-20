import 'dart:developer';

import 'package:best_price/core/api/api_service.dart';
import 'package:best_price/core/errors/failures.dart';
import 'package:best_price/core/utils/keys.dart';
import 'package:best_price/core/utils/service_locator.dart';
import 'package:best_price/feature/cart/data/models/cart_model.dart';
import 'package:best_price/feature/cart/data/models/order_model.dart';
import 'package:best_price/feature/cart/data/repos/cart_repo/cart_repo.dart';
import 'package:dartz/dartz.dart';

class CartRepoImpl implements CartRepo {
  @override
  Future<Either<Failure, CartModel>> getMyCart() async {
    try {
      var response = await getIt
          .get<ApiService>()
          .get(endPoint: UrlKeys.getMyCartEndPoint);
      return right(CartModel.fromJson(response));
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFromCart(int productId) async {
    try {
      await getIt.get<ApiService>().delete(
          endPoint: "${UrlKeys.deleteFromCartEndPoint}/", id: productId);
      return right("Deleted");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> changeQuantityFromCart(
      Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> addToMyCart(
      String productId, Map<String, dynamic> data) async {
    try {
      await getIt
          .get<ApiService>()
          .post(endPoint: "${UrlKeys.addMyCartEndPoint}$productId", data: data);

      return right("added");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> addOrder(OrderModel order) async {
    try {
      final response = await getIt.get<ApiService>().post(
            endPoint: UrlKeys.createOrder,
            data: order.toJson(),
          );
      log(name: "Add Order API", "$response and this body ${order.toJson()}");
      return right("Order created successfully");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }
}
