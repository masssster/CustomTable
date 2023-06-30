import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTableBloc extends Bloc<FetchData, List<String>> {
  CustomTableBloc() : super([]) {
    on<FetchData>((_, emit) async {
      List<String> data = List<String>.generate(
          _.take, (index) => (index + (_.page * 10)).toString());
      emit(data);
    });
  }
}

class FetchData {
  FetchData({required this.page, required this.take});
  late int page;
  late int take;
}
