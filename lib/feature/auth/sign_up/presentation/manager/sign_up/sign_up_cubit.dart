import 'dart:developer';

import 'package:best_price/core/cache/cache_helper.dart';
import 'package:best_price/core/utils/keys.dart';
import 'package:best_price/core/utils/logger.dart';
import 'package:best_price/core/utils/service_locator.dart';
import 'package:best_price/feature/auth/sign_up/data/model/user_model.dart';
import 'package:best_price/feature/auth/sign_up/data/signup_repo/signup_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  String formatPhoneNumber(String phone) {
    phone = phone.trim();
    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }
    return '+963$phone';
  }

  Future<void> signUp() async {
    if (!signUpFormKey.currentState!.validate()) {
      return;
    }
    emit(SignUpLoading());
    UserModel newUser = UserModel(
        name: fullNameController.text.trim(),
        email: emailController.text.trim(),
        mobile: formatPhoneNumber(phoneController.text),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim());

    var result = await getIt.get<SignUprRepo>().signUp(newUser);
    result.fold((error) {
      LoggerHelper.error(error.errMassage);
      emit(SignUpFailure(errMessage: error.errMassage));
    }, (success) {
      CacheHelper.setData(key: Keys.kIsGuest, value: false);

      emit(SignUpSuccess(
          statueMessage: success.value1, message: success.value2));
    });
  }

  Future<void> verifyCode(String phone, String code) async {
    emit(SignUpLoading());
    var result = await getIt.get<SignUprRepo>().verificationCode(phone, code);
    result.fold((error) {
      LoggerHelper.error("Error${error.errMassage}");
      emit(SignUpFailure(errMessage: error.errMassage));
    }, (message) {
      emit(SignUpSuccess(statueMessage: true, message: message));
    });
  }
}
