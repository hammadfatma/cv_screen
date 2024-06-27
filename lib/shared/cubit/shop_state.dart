part of 'shop_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ProductsLoadingState extends ShopStates {}

class ProductsSuccessState extends ShopStates {}

class ProductsFailureState extends ShopStates {}
