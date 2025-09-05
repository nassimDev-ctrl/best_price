import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/core/utils/helper_functions.dart';
import 'package:best_price/core/utils/validate.dart';
import 'package:best_price/core/widgets/app_bar_row.dart';
import 'package:best_price/core/widgets/app_bottom.dart';
import 'package:best_price/core/widgets/circular_progress_indicator.dart';
import 'package:best_price/feature/account/presentation/manager/change_phone_cubit/change_phone_cubit.dart';
import 'package:best_price/feature/account/presentation/view/widgets/susses_account_dialog.dart';
import 'package:best_price/feature/auth/shared/widgets/auth_field_text.dart';
import 'package:best_price/feature/auth/shared/widgets/auth_text_field.dart';
import 'package:best_price/feature/auth/sign_up/presentation/view/otp_page_view.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePhoneView extends StatelessWidget {
  const ChangePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePhoneCubit changePhoneCubit = ChangePhoneCubit.get(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          changePhoneCubit.clearControllers();
          return true;
        },
        child: Form(
          key: changePhoneCubit.changePhoneFormKey,
          child: ListView(
            padding: EdgeInsetsDirectional.only(start: 16.w),
            children: [
              SizedBox(
                height: 14.h,
              ),
              AppBarRow(
                iconPath: IconsPath.arrowLeftIcon,
                title: S.of(context).change_phone_number,
                onFirstIconTap: () {
                  HelperFunctions.navigateToBack(context);
                  changePhoneCubit.clearControllers();
                },
              ),
              SizedBox(
                height: 41.h,
              ),
              AuthFieldText(
                title: S.of(context).new_phone_number_,
              ),
              SizedBox(
                height: 8.h,
              ),
              AuthTextField(
                validator: (p0) {
                  return Validate.validatePhoneNumber(context, p0);
                },
                textEditingController: changePhoneCubit.newPhoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              SizedBox(
                height: 100.h,
              ),
              BlocConsumer<ChangePhoneCubit, ChangePhoneState>(
                listener: (context, state) {
                  if (state is ChangePhoneSuccess) {
                    HelperFunctions.navigateToScreen(
                        context,
                        OtpPageView(
                            phoneOrEmail:
                                changePhoneCubit.newPhoneController.text,
                            isChangePhone: true));
                  } else if (state is ChangePhoneFailures) {
                    HelperFunctions.showCustomDialog(
                        context,
                        UpdateAccountDialog(
                          contain: state.errMessage,
                          title: S.of(context).change_phone_error,
                        ));
                  }
                },
                builder: (context, state) {
                  if (state is ChangePhoneLoading) {
                    return const Center(
                      child: CustomCircularProgressIndicator(),
                    );
                  } else {
                    return Padding(
                      padding:
                          EdgeInsetsDirectional.only(end: 16.0.w, bottom: 64.h),
                      child: AppBottom(
                        onTap: () async {
                          await changePhoneCubit.changePhone(context);
                        },
                        title: S.of(context).change,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
