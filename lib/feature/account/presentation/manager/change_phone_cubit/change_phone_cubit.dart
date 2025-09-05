import 'package:best_price/core/api/api_response_model.dart';
import 'package:best_price/core/utils/logger.dart';
import 'package:best_price/core/utils/service_locator.dart';
import 'package:best_price/feature/account/data/repo/edit_account_repo/edit_account_repo.dart';
import 'package:best_price/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'change_phone_state.dart';

class ChangePhoneCubit extends Cubit<ChangePhoneState> {
  ChangePhoneCubit() : super(ChangePhoneInitial());

  static ChangePhoneCubit get(context) => BlocProvider.of(context);

  final TextEditingController newPhoneController = TextEditingController();
  GlobalKey<FormState> changePhoneFormKey = GlobalKey<FormState>();
  Response changePhoneResponse = Response(status: false);
  void initState() {
    emit(ChangePhoneInitial());
  }

  void clearControllers() {
    newPhoneController.clear();
  }

  Future<void> changePhone(BuildContext context) async {
    if (!changePhoneFormKey.currentState!.validate()) {
      return;
    }

    emit(ChangePhoneLoading());

    Map<String, dynamic> data = {
      'mobile':
          context.read<LoginCubit>().formatPhoneNumber(newPhoneController.text),
    };

    var result = await getIt.get<EditAccountRepo>().changePhone(data['mobile']);
    result.fold((error) {
      LoggerHelper.error(error.errMassage);
      emit(ChangePhoneFailures(errMessage: error.errMassage));
    }, (changed) {
      emit(ChangePhoneSuccess());
    });
  }

  Future<void> verifyCode(
      BuildContext context, String phone, String code) async {
    emit(ChangePhoneLoading());

    var result = await getIt.get<EditAccountRepo>().verifyCode(phone, code);
    result.fold((error) {
      LoggerHelper.error(error.errMassage);
      emit(ChangePhoneFailures(errMessage: error.errMassage));
    }, (verified) {
      emit(ChangePhoneSuccess());
    });
  }
}
