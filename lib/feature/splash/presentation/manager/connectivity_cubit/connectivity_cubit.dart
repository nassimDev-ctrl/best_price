import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial());
  static ConnectivityCubit get(context) => BlocProvider.of(context);

  Future<void> checkInternetStatus() async {
    emit(Connected());
  }
}
