// presentation/cubit/home_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuragen_hackathon/features/HomeScreen/data/models/test_model.dart';
import 'package:neuragen_hackathon/features/HomeScreen/data/models/user_model.dart';
import 'package:neuragen_hackathon/features/HomeScreen/domain/usecases/get_test_history.dart';

import '../../domain/usecases/get_user_info.dart';

class HomeState {
  final UserModel? user;
  final List<TestModel>? testHistory;
  final bool isLoading;
  final String? error;

  HomeState({this.user, this.testHistory, this.isLoading = false, this.error});

  HomeState copyWith(
      {UserModel? user,
      List<TestModel>? testHistory,
      bool? isLoading,
      String? error}) {
    return HomeState(
      user: user ?? this.user,
      testHistory: testHistory ?? this.testHistory,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  final GetUserInfo getUserInfo;
  final GetTestHistory getTestHistory;

  HomeCubit(this.getUserInfo, this.getTestHistory)
      : super(HomeState(isLoading: true));

  Future<void> loadHomeData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final userMap = {
        "name": "Ahmet",
        "surname": "Yılmaz",
        "email": "ahmet@example.com",
        "birth_year": '2017',
        "school_grade": 'IlkOkulu'
      };
      UserModel user = UserModel.fromJson(userMap); //await getUserInfo();
      Map<String, Object> historyMap = {
        "history": [
          {"date": "2023-10-01", "score": 85},
          {"date": "2023-10-15", "score": 90}
        ]
      };

// historyMap içerisindeki 'history' öğesini List<Map<String, dynamic>> olarak alıyoruz
      List<Map<String, dynamic>> historyList =
          List<Map<String, dynamic>>.from(historyMap['history'] as List);

// historyList öğesini List<TestModel> türüne dönüştürme
      List<TestModel> testHistory =
          historyList.map((item) => TestModel.fromJson(item)).toList();
      //await getTestHistory();

      emit(state.copyWith(
          user: user, testHistory: testHistory, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
