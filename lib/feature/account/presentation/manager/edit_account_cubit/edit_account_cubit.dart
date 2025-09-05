import 'package:best_price/core/api/api_response_model.dart';
import 'package:best_price/core/cache/cache_helper.dart';
import 'package:best_price/core/utils/keys.dart';
import 'package:best_price/core/utils/service_locator.dart';
import 'package:best_price/feature/account/data/repo/edit_account_repo/edit_account_repo.dart';
import 'package:best_price/feature/auth/sign_up/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_account_state.dart';

class EditAccountCubit extends Cubit<EditAccountState> {
  EditAccountCubit() : super(EditAccountInitial());
  static EditAccountCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> editAccountFormKey = GlobalKey<FormState>();
  Response editAccountResponse = Response(status: false);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Future<void> updateCached() async {
    await CacheHelper.setData(key: Keys.kUserName, value: nameController.text);
    await CacheHelper.setData(
        key: Keys.kUserEmail, value: emailController.text);
    // await CacheHelper.setData(
    //     key: Keys.kUserMobile, value: phoneController.text);
  }

  Future<void> initTextController() async {
    nameController.text = await CacheHelper.getData(key: Keys.kUserName);
    emailController.text = await CacheHelper.getData(key: Keys.kUserEmail);
  }

  Future<void> updateUserAccount() async {
    if (!editAccountFormKey.currentState!.validate()) {
      return;
    }
    emit(EditAccountLoading());
    UserModel updateUser = UserModel(
      name: nameController.text,
      email: emailController.text,
    );
    Map<String, dynamic> data = updateUser.toJson();
    var result = await getIt.get<EditAccountRepo>().editAccount(data);
    result.fold((error) {
      emit(EditAccountFailure(errMessage: error.errMassage));
    }, (edited) async {
      await updateCached();
      emit(EditAccountSuccess());
    });
  }
}
