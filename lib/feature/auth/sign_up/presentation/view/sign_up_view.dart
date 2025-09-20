import 'package:best_price/core/cache/cache_helper.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/core/utils/helper_functions.dart';
import 'package:best_price/core/utils/keys.dart';
import 'package:best_price/core/widgets/app_bar_bottom.dart';
import 'package:best_price/core/widgets/app_bottom.dart';
import 'package:best_price/core/widgets/circular_progress_indicator.dart';
import 'package:best_price/feature/account/presentation/view/widgets/susses_account_dialog.dart';
import 'package:best_price/feature/auth/sign_up/presentation/manager/sign_up/sign_up_cubit.dart';
import 'package:best_price/feature/auth/sign_up/presentation/view/otp_page_view.dart';
import 'package:best_price/feature/home/presentation/view/pages/home_page_view.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/already_have_an_account_text.dart';
import '../widgets/sign_up_form.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // todo : finish translate
//! note : the padding for list in zero each element  has a custom padding
  @override
  Widget build(BuildContext context) {
    SignUpCubit signUpCubit = SignUpCubit.get(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w, top: 12.h),
              child: const Row(
                children: [
                  AppBarBottom(
                    iconPath: IconsPath.arrowLeftIcon,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 27.h,
            ),
            Center(
              child: Text(S.of(context).sign_up, //'Sign Up',
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle24
                      .copyWith(fontWeight: FontWeight.w700)),
            ),
            SizedBox(
              height: 26.h,
            ),
            const AlreadyHaveAnAccountText(),

            SizedBox(
              height: 14.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.w),
              child: const SignUpForm(),
            ),
            // Padding(
            //   padding: EdgeInsetsDirectional.only(start: 16.w),
            //   child: const TermOk(),
            // ),

            BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpSuccess) {
                  if (state.statueMessage) {
                    CacheHelper.setData(key: Keys.kIsFirstTime, value: true);
                    HelperFunctions.showCustomDialog(
                        context,
                        UpdateAccountDialog(
                          title: S.of(context).sign_up, // "Sign up",
                          contain: S
                              .of(context)
                              .success_register_message, // "You have successfully\nRegistered with Best Price",
                        ));
                    Future.delayed(const Duration(seconds: 3), () {
                      if (context.mounted) {
                        HelperFunctions.navigateToScreen(
                          context,
                          OtpPageView(
                              phoneOrEmail: signUpCubit.phoneController.text),
                        );
                      }
                    });
                  } else {
                    HelperFunctions.showCustomDialog(
                        context,
                        UpdateAccountDialog(
                          title: S.of(context).sign_up_error, //"Sign up Error",
                          contain: state.message,
                        ));
                  }
                } else if (state is SignUpFailure) {
                  HelperFunctions.showCustomDialog(
                      context,
                      UpdateAccountDialog(
                        title: S.of(context).sign_up_error, //"Sign up Error",
                        contain: state.errMessage,
                      ));
                }
              },
              builder: (context, state) {
                if (state is SignUpLoading) {
                  return const CustomCircularProgressIndicator();
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: AppBottom(
                      title: S.of(context).sign_up, //"Sign Up",
                      onTap: () async {
                        await signUpCubit.signUp();
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 35.h,
            ),
          ],
        ),
      ),
    );
  }
}
// +963  0969687020
