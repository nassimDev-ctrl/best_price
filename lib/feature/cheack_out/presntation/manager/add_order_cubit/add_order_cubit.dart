import 'package:best_price/core/cache/cache_helper.dart';
import 'package:best_price/core/utils/keys.dart';
import 'package:best_price/core/utils/service_locator.dart';
import 'package:best_price/feature/cart/data/models/order_model.dart';
import 'package:best_price/feature/cart/data/repos/cart_repo/cart_repo.dart';
import 'package:best_price/feature/cart/presentation/manager/my_cart_cubit/my_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit() : super(AddOrderInitial());
  static AddOrderCubit get(context) => BlocProvider.of(context);
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final CartRepo _orderRepo = getIt<CartRepo>();
  Future<void> submitOrder(BuildContext context) async {
    emit(AddOrderLoading());

    final myCartCubit = MyCartCubit.get(context);
    final myCartList = myCartCubit.myCart.data?.result?.myCart ?? [];

    final items = myCartList.map((cartItem) {
      return OrderItem(
        productId: cartItem.product?.id ?? 0,
        quantity: cartItem.quantity ?? 1,
      );
    }).toList();

    final request = OrderModel(
      noteController.text,
      shippingAddress: shippingAddressController.text.trim(),
      items: items,
    );
    final result = await _orderRepo.addOrder(request);

    result.fold(
      (failure) {
        emit(AddOrderError(errorMessage: failure.errMassage));
      },
      (successMessage) {
        emit(AddOrderSuccess(successMessage: successMessage));
        clearFields();
      },
    );
  }

  void clearFields() {
    fullNameController.clear();
    phoneController.clear();
    emailController.clear();
    shippingAddressController.clear();
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    shippingAddressController.dispose();
    return super.close();
  }
}
