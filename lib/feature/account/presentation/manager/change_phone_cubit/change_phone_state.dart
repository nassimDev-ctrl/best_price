part of 'change_phone_cubit.dart';

@immutable
sealed class ChangePhoneState {}

final class ChangePhoneInitial extends ChangePhoneState {}

final class ChangePhoneLoading extends ChangePhoneState {}

final class ChangePhoneSuccess extends ChangePhoneState {}

final class ChangePhoneFailures extends ChangePhoneState {
  final String errMessage;

  ChangePhoneFailures({required this.errMessage});
}
