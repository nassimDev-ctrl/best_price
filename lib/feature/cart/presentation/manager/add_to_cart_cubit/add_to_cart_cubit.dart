import 'package:best_price/core/utils/service_locator.dart';
import 'package:best_price/feature/cart/data/repos/cart_repo/cart_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  Future<void> addToCart(String productId, int quantity,
      {int? variantId}) async {
    emit(AddToCartLoading());
    final body = <String, dynamic>{
      "quantity": quantity,
    };
    if (variantId != null) {
      body["variant_id"] = variantId;
    }
    print("The body is: $body");
    var result = await getIt.get<CartRepo>().addToMyCart(productId, body);
    result.fold(
      (l) {
        emit(AddToCartFailures(error: l.errMassage));
      },
      (r) {
        emit(AddToCartSuccess());
      },
    );
  }
}
//jackgeorge1955
