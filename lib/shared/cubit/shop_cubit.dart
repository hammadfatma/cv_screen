import 'package:cvscreen/models/cart/cart.dart';
import 'package:cvscreen/models/cart/product.dart';
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
    await dioHelper.getUsers().then((value) async {
      var data = value.map((element) => User.fromJson(element)).toList();
      users = data;
      for (var element in data) {
        element.username == userName ? userId = element.id! : null;
        if (element.id == userId) {
          userItem = element;
          await fetchCartsByUserId(userId);
        }
      }
      emit(UsersSuccessState());
    }).catchError((error) {
      emit(UsersFailureState());
    });
  }

  List<Product> allProductsInCart = [];
  List<Map<String, dynamic>> matchingProducts = [];
  List<ProductModel> productsInCart = [];
  Future<void> fetchCartsByUserId(int? userId) async {
    emit(CartsByUserIdLoadingState());
    await dioHelper.getCartsByUserId(userId).then((value) async {
      var data = value.map((element) => Cart.fromJson(element)).toList();
      for (var element in data) {
        element.products != null && element.products is List<Product>
            ? allProductsInCart.addAll(List<Product>.from(element.products!))
            : [];
      }
      for (var productInCart in allProductsInCart) {
        final product = products.firstWhere(
          (element) => element.id == productInCart.productId,
        );
        product.quantity = productInCart.quantity;
        matchingProducts.add(product.toJson());
      }
      productsInCart = matchingProducts
          .map((element) => ProductModel.fromJson(element))
          .toList();
      emit(CartsByUserIdSuccessState());
    }).catchError((error) {
      emit(CartsByUserIdFailureState());
    });
  }
}
