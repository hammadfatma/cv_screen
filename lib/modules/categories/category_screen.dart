import 'package:cvscreen/shared/cubit/shop_cubit.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.categoriesName});
  final List<String> categoriesName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
              categoriesName.length,
              (index) =>
                  buildCategoryItem(context, index, categoriesName[index])),
        ),
      ),
    );
  }

  Widget buildCategoryItem(context, index, String name) {
    final isSelected = ShopCubit.get(context).currentIndex == index;
    return InkWell(
      onTap: () {
        ShopCubit.get(context).changeCategories(index, name);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color.fromRGBO(128, 44, 110, 1) : Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : const Color.fromRGBO(128, 44, 110, 1),
          ),
        ),
      ),
    );
  }
}
