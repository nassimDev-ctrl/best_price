import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/utils/helper_functions.dart';
import 'package:best_price/core/widgets/app_bottom.dart';
import 'package:best_price/core/widgets/circular_progress_indicator.dart';
import 'package:best_price/core/widgets/error_widget.dart';
import 'package:best_price/core/widgets/not_found_widget.dart';
import 'package:best_price/feature/cart/data/models/cart_model.dart';
import 'package:best_price/feature/cart/presentation/manager/change_quantity_cubit/change_quantity_cubit.dart';
import 'package:best_price/feature/cart/presentation/manager/delete_from_my_cart_cubit/delete_from_my_cart_cubit.dart';
import 'package:best_price/feature/cart/presentation/manager/my_cart_cubit/my_cart_cubit.dart';
import 'package:best_price/feature/cheack_out/presntation/view/pages/cheackout_view_new.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_style.dart';
import '../widgets/cart_item.dart';
import '../widgets/custom_row_text.dart';
import '../widgets/intermittent_divider.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    MyCartCubit myCartCubit = MyCartCubit.get(context);
    ChangeQuantityCubit changeQuantityCubit = ChangeQuantityCubit.get(context);
    changeQuantityCubit.initializeTextEditingControllers(
        myCartCubit.myCart.data?.result?.myCart ?? []);
    myCartCubit.getMyCart(context);
    return BlocConsumer<DeleteFromMyCartCubit, DeleteFromMyCartState>(
      listener: (context, state) async {
        if (state is DeleteFromMyCartSuccess) {
          await myCartCubit.getMyCart(context);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            await myCartCubit.getMyCart(context);
          },
          color: AppColor.corn,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 14.h),
                      child: Text(
                        S.of(context).my_cart, //'My Cart',
                        style: AppStyles.textStyle20w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  BlocBuilder<MyCartCubit, MyCartState>(
                    builder: (context, state) {
                      if (state is MyCartLoading) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height -
                              kToolbarHeight -
                              MediaQuery.of(context).padding.top,
                          child: const Center(
                            child: CustomCircularProgressIndicator(),
                          ),
                        );
                      } else if (state is MyCartFailures) {
                        return CustomErrorWidget(
                          onTap: () {
                            myCartCubit.getMyCart(context);
                          },
                        );
                      } else {
                        if (myCartCubit.myCart.data?.result?.myCart?.isEmpty ??
                            true) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height -
                                kToolbarHeight -
                                MediaQuery.of(context).padding.top,
                            child: Center(
                              child: NoResult(
                                  title: S.of(context).no_Product_In_Cart),
                            ),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: myCartCubit
                                        .myCart.data?.result?.myCart?.length ??
                                    0,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 20.h,
                                ),
                                itemBuilder: (context, index) => CartItem(
                                  id: myCartCubit.myCart.data?.result
                                          ?.myCart?[index].id ??
                                      -1,
                                  quantity: myCartCubit.myCart.data?.result
                                          ?.myCart?[index].quantity ??
                                      0,
                                  cartProduct: myCartCubit.myCart.data?.result
                                          ?.myCart?[index].product ??
                                      const Product(),
                                ),
                              ),
                              SizedBox(
                                height: 43.h,
                              ),
                              // Coupon Code Section
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: AppColor.containerBackColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'كود الخصم',
                                      style: AppStyles.textStyle16w700.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'أدخل كود الخصم',
                                              hintStyle: AppStyles
                                                  .textStyle14w400
                                                  .copyWith(
                                                color: Colors.grey[600],
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: BorderSide(
                                                  color: AppColor.corn,
                                                  width: 2,
                                                ),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 12.h,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                            ),
                                            style: AppStyles.textStyle14w400,
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        ElevatedButton(
                                          onPressed: () {
                                            // TODO: Implement coupon apply logic
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.corn,
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20.w,
                                              vertical: 12.h,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: Text(
                                            'تطبيق',
                                            style: AppStyles.textStyle14w700
                                                .copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              // CustomRowText(
                              //   text1: S.of(context).sub_total,
                              //   textStyle1: AppStyles.textStyle18w400,
                              //   text2: '1019.800 KD',
                              //   textStyle2: AppStyles.textStyle18w700,
                              // ),
                              // const SizedBox(height: 10),
                              const IntermittentDivider(
                                dashWidth: 3,
                              ),
                              const SizedBox(height: 5),
                              CustomRowText(
                                text1: S.of(context).total,
                                textStyle1: AppStyles.textStyle18w400,
                                text2: myCartCubit
                                        .myCart.data?.result?.totalFinally
                                        .toString() ??
                                    "",
                                textStyle2: AppStyles.textStyle18w700,
                              ),
                              SizedBox(
                                height: 45.h,
                              ),
                              AppBottom(
                                title: "المتابعة والدفع",
                                onTap: () {
                                  HelperFunctions.navigateToScreen(
                                    context,
                                    const CheckOutPageNew(),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                            ],
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
