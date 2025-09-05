import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/feature/account/data/models/user_info_model.dart';
import 'package:best_price/feature/account/presentation/manager/edit_account_cubit/edit_account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAccountInfo extends StatelessWidget {
  const MyAccountInfo({
    super.key,
    required this.userInfo,
  });
  final UserInfoResponse userInfo;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditAccountCubit, EditAccountState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: AppStyles.accountContainerDecoration(),
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 14.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  userInfo.data?.name ?? "",
                  style: AppStyles.textStyle20w700,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  userInfo.data?.email ?? "",
                  style:
                      AppStyles.textStyle16w400.copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  userInfo.data?.mobile ?? "",
                  style:
                      AppStyles.textStyle16w400.copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
