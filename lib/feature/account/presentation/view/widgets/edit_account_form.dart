import 'package:best_price/core/utils/validate.dart';
import 'package:best_price/feature/account/presentation/manager/edit_account_cubit/edit_account_cubit.dart';
import 'package:best_price/feature/auth/shared/widgets/auth_field_text.dart';
import 'package:best_price/feature/auth/shared/widgets/auth_text_field.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditAccountForm extends StatelessWidget {
  const EditAccountForm({
    super.key,
  });
// todo : finish translate
  @override
  Widget build(BuildContext context) {
    EditAccountCubit editAccountCubit = EditAccountCubit.get(context);
    return Form(
      key: editAccountCubit.editAccountFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthFieldText(
            title: S.of(context).full_name_, //"Full Name*",
          ),
          SizedBox(
            height: 10.h,
          ),
          AuthTextField(
            textEditingController: editAccountCubit.nameController,
            validator: (p0) {
              return Validate.validateFailed(context, p0);
            },
            keyboardType: TextInputType.name,
            hintText: S.of(context).enter_your_name, //"Enter your name",
          ),
          SizedBox(
            height: 30.h,
          ),
          AuthFieldText(
            title: S.of(context).email_, // "Email*",
          ),
          SizedBox(
            height: 10.h,
          ),
          AuthTextField(
            textEditingController: editAccountCubit.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (p0) {
              return Validate.validateEmail(context, p0);
            },
            hintText: S.of(context).enter_your_email, //"Enter your E-mail",
          ),
          // SizedBox(
          //   height: 30.h,
          // ),
          // AuthFieldText(
          //   title: S.of(context).mobile_number_, //"Mobile Number*",
          // ),
          // SizedBox(
          //   height: 10.h,
          // ),
          // AuthTextField(
          //   textEditingController: editAccountCubit.phoneController,
          //   keyboardType: TextInputType.phone,
          //   validator: (p0) {
          //     return Validate.validatePhoneNumber(context, p0);
          //   },
          //   hintText: S.of(context).enter_your_phone, //"Enter your phone",
          // ),
        ],
      ),
    );
  }
}
