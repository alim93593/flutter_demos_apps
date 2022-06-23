// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/models/shop_app_models/search_model.dart';
import 'package:flutter_demo/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_demo/shared/network/end_point.dart';
import 'package:flutter_demo/shared/network/remote/dio_helper.dart';


class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchIntialState());

  static SearchCubit get(context) =>BlocProvider.of(context);
  SearchModel model;
  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH,token: token, data: {
      'text':text
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      print(model);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState(error));
    });
  }

}