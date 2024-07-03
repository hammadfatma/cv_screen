import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cvscreen/models/product_model.dart';
import 'package:cvscreen/modules/orders/order_placed.dart';
import 'package:cvscreen/shared/components/components.dart';
import 'package:cvscreen/shared/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
    required this.collectedProducts,
    required this.cubitContext,
  });
  final List<ProductModel> collectedProducts;
  final BuildContext cubitContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConditionalBuilder(
              condition: collectedProducts.isNotEmpty,
              builder: (context) {
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return builCartItem(
                                context, collectedProducts[index]);
                          },
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: collectedProducts.length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              r'Total: $'
                              '${BlocProvider.of<ShopCubit>(cubitContext).totalPrice}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(128, 44, 110, 1),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                        'We will send your order to the address on the profile page, are you sure?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          navigateAndFinish(
                                            context,
                                            const OrderPlacedScreen(),
                                          );
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(128, 44, 110, 1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'PLACE ORDER',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              fallback: (context) => Center(
                child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGZrYPpavyKZYvBAC1WaQJODDlyxiBRLjZ7v5gpDK-QEGbdHPgADpNRSsYNw&s'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget builCartItem(context, ProductModel model) {
  return Container(
    height: 200,
    width: double.maxFinite,
    decoration: BoxDecoration(
      color: const Color(0xFFE3DFFD),
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
            left: 25,
            top: 15,
            bottom: 15,
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.network(
                  model.image,
                  width: double.maxFinite,
                  height: 130.0,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 5,
            left: 170,
            child: SizedBox(
              width: double.minPositive,
              child: Text(
                model.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          Positioned(
            top: 95,
            right: 5,
            left: 170,
            child: SizedBox(
              width: double.minPositive,
              child: Text(
                "quantity : ${model.quantity.toString()}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          Positioned(
            top: 155,
            right: 5,
            left: 170,
            child: SizedBox(
              width: double.minPositive,
              child: Text(
                r'$' '${model.price.toString()}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(128, 44, 110, 1)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
