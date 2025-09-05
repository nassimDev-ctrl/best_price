import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/feature/account/presentation/manager/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:best_price/feature/account/presentation/view/widgets/option_item.dart';
import 'package:best_price/feature/splash/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'language_bottom_sheet.dart';

class SettingsListOptions extends StatelessWidget {
  const SettingsListOptions({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    LangCubit langCubit = LangCubit.get(context);

    return Container(
      width: 361.w,
      // height: 123.h,
      decoration: AppStyles.accountContainerDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: 27.h,
          ),
          // OptionItem(
          //   title: S.of(context).notification, //"Notification",
          //   iconPath: IconsPath.notificationIcon,
          //   trailing: SizedBox(
          //     height: 27.h,
          //     width: 45.01.w,
          //     child: CupertinoSwitch(
          //       value: true,
          //       onChanged: (value) {},
          //     ),
          //   ),
          // ),
          OptionItem(
              title: S.of(context).language, //"Language",
              onTap: () {
                showLanguageBottomSheet(context);
              },
              iconPath: IconsPath.languageIcon,
              trailing: Text(
                BlocProvider.of<LangCubit>(context).lang,
                style: AppStyles.textStyle16w400.copyWith(color: Colors.black),
              )),
          SizedBox(
            height: 10.h,
          ),
          BlocBuilder<GetUserInfoCubit, GetUserInfoState>(
            builder: (context, state) {
              if (state is GetUserInfoSuccess) {
                return Visibility(
                  visible: state.userInfo.data?.isAdmin ?? false,
                  child: OptionItem(
                    title: S.of(context).dashboard, //"Language",
                    onTap: () async {
                      const url = 'https://dashboard.ghinashop.net/';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },

                    iconPath: IconsPath.dashboradIcon,
                    trailing: langCubit.lang == 'en'
                        ? SvgPicture.asset(
                            IconsPath.rightArrowIcon,
                          )
                        : SvgPicture.asset(
                            IconsPath.arrowLeftIcon,
                          ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Future showLanguageBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (context) {
        return const LanguageBottomSheet();
      },
    );
  }
}
