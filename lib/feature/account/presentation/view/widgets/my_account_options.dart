import 'package:best_price/core/cache/cache_helper.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/core/utils/helper_functions.dart';
import 'package:best_price/core/utils/keys.dart';
import 'package:best_price/core/widgets/question_dialog.dart';
import 'package:best_price/feature/account/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:best_price/feature/account/presentation/view/pages/edit_account_page_view.dart';
import 'package:best_price/feature/account/presentation/view/pages/change_password_page_view.dart';
import 'package:best_price/feature/account/presentation/view/pages/change_phone_page_view.dart';
import 'package:best_price/feature/account/presentation/view/widgets/option_item.dart';
import 'package:best_price/feature/auth/login/presentation/view/pages/login_page_view.dart';
import 'package:best_price/feature/splash/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:best_price/feature/wish/presentation/view/view/my_wish_view.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pages/my_orders.dart';

class MyAccountOptions extends StatelessWidget {
  const MyAccountOptions({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    LogoutCubit logoutCubit = LogoutCubit.get(context);
    LangCubit langCubit = LangCubit.get(context);

    return Container(
      decoration: AppStyles.accountContainerDecoration(),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          OptionItem(
              onTap: () {
                HelperFunctions.navigateToScreen(
                    context, const EditAccountView());
              },
              trailing: langCubit.lang == 'en'
                  ? SvgPicture.asset(
                      IconsPath.rightArrowIcon,
                    )
                  : SvgPicture.asset(
                      IconsPath.arrowLeftIcon,
                    ),
              title: S.of(context).edit_account, //"Edit Account",
              iconPath: IconsPath.editAccountIcon),
          OptionItem(
              onTap: () {
                HelperFunctions.navigateToScreen(context, const MyOrders());
              },
              trailing: langCubit.lang == 'en'
                  ? SvgPicture.asset(
                      IconsPath.rightArrowIcon,
                    )
                  : SvgPicture.asset(
                      IconsPath.arrowLeftIcon,
                    ),
              title: S.of(context).my_orders, // "My Orders",
              iconPath: IconsPath.policiesIcon),
          OptionItem(
              onTap: () {
                HelperFunctions.navigateToScreen(
                  context,
                  const MyWishView(),
                  // const LoginView()
                );
              },
              trailing: langCubit.lang == 'en'
                  ? SvgPicture.asset(
                      IconsPath.rightArrowIcon,
                    )
                  : SvgPicture.asset(
                      IconsPath.arrowLeftIcon,
                    ),
              title: S.of(context).wish_list, //"Wish list",
              iconPath: IconsPath.wishIcon),
          OptionItem(
              onTap: () {
                HelperFunctions.navigateToScreen(
                    context, const ChangePhoneView());
              },
              trailing: langCubit.lang == 'en'
                  ? SvgPicture.asset(
                      IconsPath.rightArrowIcon,
                    )
                  : SvgPicture.asset(
                      IconsPath.arrowLeftIcon,
                    ),
              title: S.of(context).change_phone_number, //"Change Phone Number",
              iconPath: IconsPath.changeIcon),
          OptionItem(
              onTap: () {
                HelperFunctions.navigateToScreen(
                    context, const ForgetPasswordView());
              },
              trailing: langCubit.lang == 'en'
                  ? SvgPicture.asset(
                      IconsPath.rightArrowIcon,
                    )
                  : SvgPicture.asset(
                      IconsPath.arrowLeftIcon,
                    ),
              title: S.of(context).change_password, // "Change Password",
              iconPath: IconsPath.changeIcon),
          OptionItem(
              onTap: () async {
                HelperFunctions.showCustomDialog(
                    context,
                    QuestionDialog(
                      title: S.of(context).logout, //"Logout",
                      contain: S
                          .of(context)
                          .are_you_sure_you_want_to_logout, //"Are you sure you want to logout?",
                      onTapYes: () async {
                        // await logoutCubit.logout();
                        await HelperFunctions.clearUserData();
                        HelperFunctions.navigateToScreenAndRemove(
                            context, const LoginView());
                        CacheHelper.setData(key: Keys.kIsLogin, value: false);
                      },
                    ));
              },
              trailing: langCubit.lang == 'en'
                  ? SvgPicture.asset(
                      IconsPath.rightArrowIcon,
                    )
                  : SvgPicture.asset(
                      IconsPath.arrowLeftIcon,
                    ),
              title: S.of(context).logout, //"Logout",
              iconPath: IconsPath.logoutIcon),
          SizedBox(
            height: 5.h,
          )
        ],
      ),
    );
  }
}
