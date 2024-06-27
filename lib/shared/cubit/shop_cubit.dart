import 'package:cvscreen/models/product_model.dart';
import 'package:cvscreen/shared/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit(this.dioHelper) : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  final DioHelper dioHelper;
  List<ProductModel> products = [];
  Future<void> fetchProducts() async {
    emit(ProductsLoadingState());
    await dioHelper.getProducts().then((value) {
      var data =
          value.map((element) => ProductModel.fromJson(element)).toList();
      products = data;
      emit(ProductsSuccessState());
    }).catchError((error) {
      emit(ProductsFailureState());
    });
  }
}
