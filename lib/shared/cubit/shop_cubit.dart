import 'package:cvscreen/models/product_model.dart';
import 'package:cvscreen/shared/network/remote/dio_helper.dart';
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

  List<ProductModel> productsByCategory = [];
  Future<void> fetchProductsByCategory(String categoryName) async {
    emit(ProductsByCategoryLoadingState());
    await dioHelper.getProductsByCategory(categoryName).then((value) {
      var data =
          value.map((element) => ProductModel.fromJson(element)).toList();
      productsByCategory = data;
      emit(ProductsByCategorySuccessState());
    }).catchError((error) {
      emit(ProductsByCategoryFailureState());
    });
  }

  int currentIndex = 0;
  List<String> categories = [
    "all",
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing",
  ];
  void changeCategories(int index, String categoryName) {
    currentIndex = index;
    if (index == 0) {
      fetchProducts();
    } else {
      fetchProductsByCategory(categoryName);
    }
    emit(ShopChangeCategoriesState());
  }
}
