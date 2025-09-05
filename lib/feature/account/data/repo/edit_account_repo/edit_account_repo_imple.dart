import 'package:best_price/core/api/api_service.dart';
import 'package:best_price/core/errors/failures.dart';
import 'package:best_price/core/utils/service_locator.dart';
import 'package:best_price/feature/account/data/repo/edit_account_repo/edit_account_repo.dart';
import 'package:dartz/dartz.dart';

class EditAccountRepoImpl implements EditAccountRepo {
  @override
  Future<Either<Failure, String>> editAccount(Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> response = await getIt
          .get<ApiService>()
          .put(endPoint: "auth/updateMe", data: data);
      return right("Updated");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> changePhone(String phone) async {
    try {
      Map<String, dynamic> response = await getIt.get<ApiService>().post(
          endPoint: "auth/request-phone-change", data: {"newPhone": phone});
      return right("Updated");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }

  @override
  Future<Either<Failure, String>> verifyCode(String phone, String code) async {
    try {
      print(phone);
      print(code);
      Map<String, dynamic> response = await getIt.get<ApiService>().post(
          endPoint: "auth/verify-phone-change",
          data: {"newPhone": phone, "otp": code});
      return right("Verified");
    } catch (e) {
      return left(ErrorHandler.handleError(e));
    }
  }
}
