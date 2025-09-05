import 'package:best_price/core/cache/cache_helper.dart';
import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/helper_functions.dart';
import 'package:best_price/core/utils/keys.dart';
import 'package:best_price/core/widgets/circular_progress_indicator.dart';
import 'package:best_price/feature/account/presentation/view/widgets/susses_account_dialog.dart';
import 'package:best_price/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:best_price/feature/auth/sign_up/presentation/view/otp_page_view.dart';
import 'package:best_price/feature/auth/sign_up/presentation/view/sign_up_view.dart';
import 'package:best_price/feature/home/presentation/view/pages/home_page_view.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/app_bottom.dart';
import '../widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    LoginCubit loginCubit = LoginCubit.get(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          // padding: EdgeInsets.zero,
          children: [
            // Padding(
            //   padding: EdgeInsetsDirectional.only(start: 16.w, top: 4.h),
            //   child: Row(
            //     children: [
            //       AppBarBottom(
            //         iconPath: IconsPath.cancelIcon,
            //         onTap: () {
            //           CacheHelper.setData(key: Keys.kIsGuest, value: true);
            //           HelperFunctions.navigateToScreenAndRemove(
            //               context, const HomePageView());
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: height * 0.03, //27.h,
            ),
            Center(
              child: Text(S.of(context).login, //'Login',
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle24),
            ),
            // SizedBox(
            //   height: 9.h,
            // ),
            // Padding(
            //   padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
            //   child: Text(
            //       S
            //           .of(context)
            //           .lorem_small, //'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
            //       textAlign: TextAlign.center,
            //       style: AppStyles.textStyle14),
            // ),
            SizedBox(height: 11.h),
            const LoginForm(),
            SizedBox(
              height: 12.h,
            ),

            // const ForgetPasswordText(),
            SizedBox(
              height: height * 0.09, //76.h,
            ),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  //! state from response , if true the login is success and if false the login error and message
                  //! know what the error ...
                  // Todo :
                  if (state.status) {
                    CacheHelper.setData(key: Keys.kIsFirstTime, value: true);
                    HelperFunctions.navigateToScreenAndRemove(
                        context, const HomePageView());
                  } else {
                    HelperFunctions.showCustomDialog(
                        context,
                        UpdateAccountDialog(
                          title: S.of(context).sign_up_error, //"Sign up error",
                          contain: state.message,
                        ));
                  }
                } else if (state is LoginFailure) {
                  if (state.errMessage == "Please verify your account first") {
                    HelperFunctions.navigateToScreenAndRemove(
                        context,
                        OtpPageView(
                          phoneOrEmail: loginCubit.emailController.text,
                        ));
                  } else {
                    HelperFunctions.showCustomDialog(
                        context,
                        UpdateAccountDialog(
                          title: S.of(context).sign_up_error, //"Sign up error",
                          contain: state.errMessage,
                        ));
                  }
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const CustomCircularProgressIndicator();
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: AppBottom(
                      // title: S.of(context).login, // "LogIn",
                      title: S.of(context).sign_in,
                      onTap: () async {
                        loginCubit.logIn();
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                HelperFunctions.navigateToScreen(context, const SignUpView());
              },
              child: Text(
                S
                    .of(context)
                    .dont_have_an_account_Register, //'Don’t have an account? Register',
                textAlign: TextAlign.center,
                style: AppStyles.textStyle16w400.copyWith(
                    color: AppColor.buddhaGold, fontWeight: FontWeight.bold),
              ),
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
