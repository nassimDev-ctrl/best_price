import 'package:best_price/core/api/api_service.dart';
import 'package:best_price/core/errors/failures.dart';
import 'package:best_price/core/utils/service_locator.dart';
import 'package:best_price/feature/featured_products/data/featured_producte_repo/featured_producte_repo.dart';
import 'package:best_price/feature/home/data/models/home_model.dart';
import 'package:dartz/dartz.dart';

class FeaturedProductsRepoImpl implements FeaturedProductRepo {
  @override
  Future<Either<Failure, Tuple2<List<Product>, num>>>
      getFeaturedProducts() async {
    try {
      var response = await getIt
          .get<ApiService>()
          .get(endPoint: "products/products/featured?limit=160");
      List<Product> productsList = [];
      for (var element in response['data']['products']) {
        productsList.add(Product.fromJson(element));
      }
      //? find the max price of list
      num maxPrice = 0;
      for (var element in productsList) {
        if (element.discountPrice != null) {
          if (element.discountPrice > maxPrice) {
            maxPrice = element.discountPrice;
          }
        }
      }
      return right(Tuple2(productsList, maxPrice));
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }
}
