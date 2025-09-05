import 'package:best_price/core/api/api_response_model.dart';
import 'package:best_price/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class EditAccountRepo {
  Future<Either<Failure, String>> editAccount(Map<String, dynamic> data);
  Future<Either<Failure, String>> changePhone(String phone);
  Future<Either<Failure, String>> verifyCode(String phone, String code);
}
