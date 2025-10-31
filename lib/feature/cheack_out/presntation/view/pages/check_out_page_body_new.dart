import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/core/utils/dimensions.dart';
import 'package:best_price/core/utils/helper_functions.dart';
import 'package:best_price/core/utils/validate.dart';
import 'package:best_price/core/widgets/app_bar_row.dart';
import 'package:best_price/core/widgets/app_bottom.dart';
import 'package:best_price/core/widgets/custom_loading.dart';
import 'package:best_price/feature/auth/shared/widgets/auth_field_text.dart';
import 'package:best_price/feature/auth/shared/widgets/auth_text_field.dart';
import 'package:best_price/feature/cart/presentation/manager/my_cart_cubit/my_cart_cubit.dart';
import 'package:best_price/feature/cheack_out/presntation/manager/add_order_cubit/add_order_cubit.dart';
import 'package:best_price/feature/splash/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CheckOutPageBodyNew extends StatelessWidget {
  const CheckOutPageBodyNew({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LangCubit langCubit = LangCubit.get(context);
    AddOrderCubit addOrderCubit = AddOrderCubit.get(context);
    final _formKey = GlobalKey<FormState>();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Coupon controller: prefill from arguments if present
    final TextEditingController couponController =
        addOrderCubit.couponCodeController;
    if (args != null &&
        args['coupon_code'] != null &&
        couponController.text.isEmpty) {
      couponController.text = args['coupon_code'];
    }

    return Form(
      key: _formKey,
      child: ListView(
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: Dimensions.dStartPadding.w),
          children: [
            SizedBox(
              height: 14.h,
            ),
            AppBarRow(
              iconPath: langCubit.lang == "en"
                  ? IconsPath.arrowLeftIcon
                  : IconsPath.rightArrowIcon,
              title: S.of(context).checkout, //"Checkout",
              onFirstIconTap: () {
                HelperFunctions.navigateToBack(context);
              },
            ),
            SizedBox(
              height: 32.h,
            ),
            AuthFieldText(
              title: S.of(context).shipping_address,
            ),
            SizedBox(
              height: 20.h,
            ),
            AuthTextField(
              textEditingController: addOrderCubit.shippingAddressController,
              keyboardType: TextInputType.streetAddress,
              validator: (p0) => Validate.validateFailed(context, p0),
            ),

            // SizedBox(
            //   height: 32.h,
            // ),
            // AuthFieldText(
            //   title: S.of(context).name,
            // ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // AuthTextField(
            //   textEditingController: addOrderCubit.fullNameController,
            //   keyboardType: TextInputType.name,
            //   validator: (p0) => Validate.validateFullName(context, p0),
            // ),
            // SizedBox(
            //   height: 32.h,
            // ),
            // AuthFieldText(
            //   title: S.of(context).phone_number_,
            // ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // AuthTextField(
            //   maxLength: 10,
            //   inputFormatters: [
            //     FilteringTextInputFormatter.digitsOnly,
            //   ],
            //   textEditingController: addOrderCubit.phoneController,
            //   keyboardType: TextInputType.phone,
            //   validator: (p0) => Validate.validatePhoneNumber(context, p0),
            // ),
            SizedBox(
              height: 32.h,
            ),
            AuthFieldText(
              title: 'كود الخصم (اختياري)',
            ),
            SizedBox(
              height: 20.h,
            ),
            AuthTextField(
              textEditingController: couponController,
              keyboardType: TextInputType.text,
              hintText: 'أدخل كود الخصم إن وجد',
              // No validator: optional field
            ),
            SizedBox(
              height: 32.h,
            ),
            AuthFieldText(
              title: S.of(context).notes,
            ),
            SizedBox(
              height: 20.h,
            ),
            AuthTextField(
              maxLine: 3,
              textEditingController: addOrderCubit.noteController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 32.h,
            ),
            // AuthFieldText(
            //   title: S.of(context). e_mail,
            // ),
            // SizedBox(
            //   height: 20.h,
            // ),
            // AuthTextField(
            //   textEditingController: addOrderCubit.emailController,
            //   keyboardType: TextInputType.emailAddress,
            //   validator: (p0) => Validate.validateEmail(context, p0),
            // ),
            // SizedBox(
            //   height: 32.h,
            // ),
            BlocConsumer<AddOrderCubit, AddOrderState>(
              listener: (context, state) async {
                if (state is AddOrderSuccess) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.success(
                      message: "تم انشاء الطلب بنجاح",
                      backgroundColor: AppColor.green,
                      textStyle: AppStyles.textStyle14.copyWith(
                        color: AppColor.whiteColorOpacity,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                  await BlocProvider.of<MyCartCubit>(context)
                      .getMyCart(context);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }

                  // Optional: Navigate or clear cart
                } else if (state is AddOrderError) {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: state.errorMessage, // Dynamic error message
                      backgroundColor: Colors.red,
                      textStyle: AppStyles.textStyle14.copyWith(
                        color: AppColor.whiteColorOpacity,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final addOrderCubit = AddOrderCubit.get(context);
                if (state is AddOrderLoading) {
                  return const Center(
                    child: CustomLoading(),
                  );
                } else {
                  return AppBottom(
                    title: S.of(context).confirm,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        // Write field value into cubit
                        addOrderCubit.couponCodeController.text =
                            couponController.text.trim();
                        addOrderCubit.submitOrder(context);
                      }
                    },
                  );
                }
              },
            )
          ]),
    );
  }
}
