import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/core/utils/helper_functions.dart';
import 'package:best_price/feature/account/presentation/view/pages/about_best_price.dart';
import 'package:best_price/feature/account/presentation/view/pages/contact_us.dart';
import 'package:best_price/feature/account/presentation/view/pages/our_policy_view.dart';
import 'package:best_price/feature/account/presentation/view/pages/terms_conditions.dart';
import 'package:best_price/feature/account/presentation/view/widgets/option_item.dart';
import 'package:best_price/feature/splash/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SupportListOptions extends StatelessWidget {
  const SupportListOptions({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    LangCubit langCubit = LangCubit.get(context);
    return Container(
      decoration: AppStyles.accountContainerDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: 27.h,
          ),
          OptionItem(
              onTap: () {
                HelperFunctions.navigateToScreen(
                    context, const AboutBestPrice());
              },
              trailing: langCubit.lang == 'en'
                  ? SvgPicture.asset(
                      IconsPath.rightArrowIcon,
                    )
                  : SvgPicture.asset(
                      IconsPath.arrowLeftIcon,
                    ),
              title: S.of(context).about_best_price, //"About Best price",
              iconPath: IconsPath.aboutIcon),
          SizedBox(
            height: 8.h,
          ),
          OptionItem(
              onTap: () {
                HelperFunctions.navigateToScreen(
                    context, const OurPolicyView());
              },
              trailing: langCubit.lang == 'en'
                  ? SvgPicture.asset(
                      IconsPath.rightArrowIcon,
                    )
                  : SvgPicture.asset(
                      IconsPath.arrowLeftIcon,
                    ),
              title: S.of(context).our_policies, //"Our Policies",
              iconPath: IconsPath.policiesIcon),
          SizedBox(
            height: 8.h,
          ),
          // OptionItem(
          //     onTap: () {
          //       HelperFunctions.navigateToScreen(
          //           context, const TermsConditions());
          //     },
          //     trailing: langCubit.lang == 'en'
          //         ? SvgPicture.asset(
          //             IconsPath.rightArrowIcon,
          //           )
          //         : SvgPicture.asset(
          //             IconsPath.arrowLeftIcon,
          //           ),
          //     title: S.of(context).terms_conditions, // "Terms & Conditions",
          //     iconPath: IconsPath.policiesIcon),
          // SizedBox(
          //   height: 8.h,
          // ),
          // OptionItem(
          //     onTap: () {
          //       HelperFunctions.navigateToScreen(context, const ContactUs());
          //     },
          //     trailing: langCubit.lang == 'en'
          //         ? SvgPicture.asset(
          //             IconsPath.rightArrowIcon,
          //           )
          //         : SvgPicture.asset(
          //             IconsPath.arrowLeftIcon,
          //           ),
          //     title: S.of(context).contact_us, //"Contact Us",
          //     iconPath: IconsPath.contactIcon),
          SizedBox(
            height: 11.h,
          ),
        ],
      ),
    );
  }
}
