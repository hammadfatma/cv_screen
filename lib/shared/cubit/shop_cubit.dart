import 'package:cvscreen/models/product_model.dart';
import 'package:cvscreen/models/user/user.dart';
import 'package:cvscreen/shared/network/local/cache_helper.dart';
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

  List<User> users = [];
  int userId = 0;
  User userItem = User();
  var userName = CacheHelper.sharedPreferences?.getString("userName");
  Future<void> fetchUsers() async {
    emit(UsersLoadingState());
    await dioHelper.getUsers().then((value) {
      var data = value.map((element) => User.fromJson(element)).toList();
      users = data;
      for (var element in data) {
        element.username == userName ? userId = element.id! : null;
        if (element.id == userId) {
          userItem = element;
        }
      }
      emit(UsersSuccessState());
    }).catchError((error) {
      emit(UsersFailureState());
    });
  }

  Future<void> fetchUserById(int? userId) async {
    emit(UserByIdLoadingState());
    await dioHelper.getUserById(userId).then((value) {
      emit(UserByIdSuccessState());
    }).catchError((error) {
      emit(UserByIdFailureState());
    });
  }
}
