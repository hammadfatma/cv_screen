part of 'shop_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeCategoriesState extends ShopStates {}

class ProductsLoadingState extends ShopStates {}

class ProductsSuccessState extends ShopStates {}

class ProductsFailureState extends ShopStates {}

class ProductsByCategoryLoadingState extends ShopStates {}

class ProductsByCategorySuccessState extends ShopStates {}

class ProductsByCategoryFailureState extends ShopStates {}

class UsersLoadingState extends ShopStates {}

class UsersSuccessState extends ShopStates {}

class UsersFailureState extends ShopStates {}

class CartsByUserIdLoadingState extends ShopStates {}

class CartsByUserIdSuccessState extends ShopStates {}

class CartsByUserIdFailureState extends ShopStates {}
