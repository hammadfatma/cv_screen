import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:cvscreen/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: products.isNotEmpty,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            color: Colors.white,
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.58,
              children: List.generate(
                products.length,
                (index) => buildGridProduct(products[index]),
              ),
            ),
          ),
        );
      },
      fallback: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildGridProduct(ProductModel model) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(model.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            r'$' '${model.price.toString()}',
            style: const TextStyle(
              color: Color.fromRGBO(128, 44, 110, 1),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
