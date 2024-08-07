import 'package:cvscreen/modules/carts/cart_screen.dart';
import 'package:cvscreen/modules/categories/category_screen.dart';
import 'package:cvscreen/modules/products/products_screen.dart';
import 'package:cvscreen/modules/profiles/profile_screen.dart';
import 'package:cvscreen/shared/components/components.dart';
import 'package:cvscreen/shared/cubit/shop_cubit.dart';
import 'package:cvscreen/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(DioHelper(Dio()))
        ..fetchProducts()
        ..fetchUsers(),
      child: BlocBuilder<ShopCubit, ShopStates>(
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text(
                'Shop',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      CartScreen(
                        collectedProducts: cubit.productsInCart,
                        cubitContext: context,
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
                IconButton(
                  onPressed: () {
                    navigateTo(
                      context,
                      ProfileScreen(
                        userModel: cubit.userItem,
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_2_outlined),
                ),
              ],
              automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                Image.network(
                  'https://static.vecteezy.com/system/resources/thumbnails/002/006/967/small/young-women-takes-a-shopping-cart-and-enjoy-online-shopping-through-smartphones-choose-to-buy-gifts-valentine-s-day-concepts-website-or-mobile-phone-application-flat-design-illustration-vector.jpg',
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 20,
                ),
                CategoriesScreen(categoriesName: cubit.categories),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: cubit.currentIndex == 0
                      ? ProductsScreen(products: cubit.products)
                      : ProductsScreen(products: cubit.productsByCategory),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
