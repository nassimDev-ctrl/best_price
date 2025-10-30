import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/core/utils/helper_functions.dart';

import 'package:best_price/feature/cart/data/models/cart_model.dart';
import 'package:best_price/feature/cart/presentation/manager/delete_from_my_cart_cubit/delete_from_my_cart_cubit.dart';
import 'package:best_price/feature/cart/presentation/widgets/custom_edit_quantity.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../core/widgets/question_dialog.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.myCart,
  });
  final MyCart myCart;
  @override
  Widget build(BuildContext context) {
    final cartProduct = myCart.product ?? const Product();
    final variant = myCart.variant;
    double price = (cartProduct.price ?? 0).toDouble();
    double discountPercentage = (cartProduct.discountPrice ?? 0).toDouble();
    double offerPrice = price - (price * discountPercentage / 100);
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 8.w,
        end: 8.w,
        top: 8.h,
        bottom: 15.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.greyOpacity,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: cartProduct.image ?? " ",
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  cartProduct.name.toString() ?? "No title",
                  style: AppStyles.textStyle18w700,
                ),
                if ((variant?.size?.isNotEmpty ?? false) ||
                    (variant?.color?.isNotEmpty ?? false)) ...[
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      if (variant?.size?.isNotEmpty ?? false)
                        Text(
                          "المقاس: ${variant!.size}",
                          style: AppStyles.textStyle16w400
                              .copyWith(color: AppColor.greyText),
                        ),
                      if (variant?.color?.isNotEmpty ?? false) ...[
                        if (variant?.size?.isNotEmpty ?? false)
                          SizedBox(width: 14),
                        Text(
                          "اللون: ${variant!.color}",
                          style: AppStyles.textStyle16w400
                              .copyWith(color: AppColor.greyText),
                        ),
                        if (variant?.colorHash?.isNotEmpty ?? false) ...[
                          SizedBox(width: 6),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _parseColor(variant.colorHash),
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade300),
                            ),
                          ),
                        ]
                      ],
                    ],
                  ),
                ],
                SizedBox(height: 10.h),
                RichText(
                  text: TextSpan(
                    text: offerPrice != cartProduct.price
                        ? offerPrice.toString()
                        : "",
                    style: AppStyles.textStyle16w700,
                    children: [
                      const TextSpan(text: "   "),
                      TextSpan(
                        text: "${cartProduct.price.toString()} ل.س",
                        style: AppStyles.textStyle14w400.copyWith(
                          decoration: cartProduct.discountPrice != null
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                RichText(
                  text: TextSpan(
                    text: "الكمية",
                    style: AppStyles.textStyle16w400
                        .copyWith(color: AppColor.greyOpacity),
                    children: [
                      TextSpan(
                        text: ": ${myCart.quantity}",
                        style: AppStyles.textStyle16w400
                            .copyWith(color: AppColor.black2),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomEditQuantity(
                      id: myCart.id.toString(),
                      minSellerQuantity: cartProduct.minSellerQuantity ?? 1,
                    ),
                    IconButton(
                      onPressed: () {
                        HelperFunctions.showCustomDialog(
                            context,
                            BlocConsumer<DeleteFromMyCartCubit,
                                DeleteFromMyCartState>(
                              listener: (context, state) {
                                if (state is DeleteFromMyCartFailures) {
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      const CustomSnackBar.error(
                                          message: "خطا في حذف المنتج"));
                                } else if (state is DeleteFromMyCartSuccess) {
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      const CustomSnackBar.success(
                                          message: "تم حذف المنتج"));
                                  HelperFunctions.navigateToBack(context);
                                }
                              },
                              builder: (context, state) {
                                return ModalProgressHUD(
                                  inAsyncCall: state is DeleteFromMyCartLoading,
                                  child: QuestionDialog(
                                    title: S
                                        .of(context)
                                        .delete_product, //"Delete Product",
                                    contain: S
                                        .of(context)
                                        .delete_product_contain_message,
                                    onTapYes: () async {
                                      await DeleteFromMyCartCubit.get(context)
                                          .deleteFromCart(cartProduct.id ?? 0);
                                    },
                                  ),
                                );
                              },
                            ));
                      },
                      icon: SvgPicture.asset(
                        IconsPath.deleteIcon,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) {
      return Colors.grey.shade200;
    }
    String value = hex.replaceFirst('#', '');
    if (value.length == 6) {
      value = 'FF$value';
    }
    final int? intVal = int.tryParse(value, radix: 16);
    if (intVal == null) {
      return Colors.grey.shade200;
    }
    return Color(intVal);
  }
}
