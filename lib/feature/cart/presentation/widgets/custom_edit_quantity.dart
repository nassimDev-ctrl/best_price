import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/theme/app_style.dart';

import 'package:best_price/feature/cart/presentation/manager/change_quantity_cubit/change_quantity_cubit.dart';
import 'package:best_price/feature/cart/presentation/manager/my_cart_cubit/my_cart_cubit.dart';
import 'package:best_price/feature/cart/presentation/widgets/custom_edit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomEditQuantity extends StatelessWidget {
  const CustomEditQuantity({
    super.key,
    required this.id,
    required this.minSellerQuantity,
  });
  final String id;
  final num minSellerQuantity;
  @override
  Widget build(BuildContext context) {
    ChangeQuantityCubit changeQuantityCubit = ChangeQuantityCubit.get(context);
    MyCartCubit myCartCubit = MyCartCubit.get(context); // Access MyCartCubit

    return BlocConsumer<ChangeQuantityCubit, ChangeQuantityState>(
      listener: (context, state) {
        // You can handle any side effects if needed.
      },
      builder: (context, state) {
        return Row(
          children: [
            CustomEditButton(
              color: AppColor.greyOpacity,
              onTap: () {
                changeQuantityCubit.decrementQuantity(
                    id, minSellerQuantity, context);
                final newQuantity = int.tryParse(
                        changeQuantityCubit.textEditingControllers[id]?.text ??
                            '0') ??
                    0;
                myCartCubit.updateCartItemQuantity(
                    id, newQuantity); // Update the quantity in MyCartCubit
              },
              child: const Icon(
                Icons.remove,
              ),
            ),
            SizedBox(
              width: 42,
              child: Center(
                child: TextFormField(
                  enabled: false,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  keyboardType: TextInputType.phone,
                  controller: changeQuantityCubit.textEditingControllers[id],
                  textAlign: TextAlign.center,
                  readOnly: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: AppStyles.textStyle16w700.copyWith(
                    color: AppColor.black,
                  ),
                  onChanged: (value) {
                    final newQuantity = int.tryParse(value) ?? 0;
                    myCartCubit.updateCartItemQuantity(
                        id, newQuantity); // Update the quantity in MyCartCubit
                  },
                ),
              ),
            ),
            CustomEditButton(
              color: AppColor.corn,
              onTap: () {
                changeQuantityCubit.incrementQuantity(id);
                final newQuantity = int.tryParse(
                        changeQuantityCubit.textEditingControllers[id]?.text ??
                            '0') ??
                    0;
                myCartCubit.updateCartItemQuantity(
                    id, newQuantity); // Update the quantity in MyCartCubit
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          ],
        );
      },
    );
  }
}
