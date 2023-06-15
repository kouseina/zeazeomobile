import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeazeoshop/models/product_model/product_item_model.dart';
import 'package:zeazeoshop/models/user_model.dart';
import 'package:zeazeoshop/providers/auth_provider.dart';
import 'package:zeazeoshop/services/product_service.dart';
import 'package:zeazeoshop/theme.dart';
import 'package:zeazeoshop/widgets/product_card.dart';
import 'package:zeazeoshop/widgets/product_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? user;
  var categoriesList = <Map<String, dynamic>>[];
  var propularProductsList = <ProductItemModel>[];
  var newProductsList = <ProductItemModel>[];

  var selectedCategoryId = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUser();
    getAllCategories();
    getPopularProducts();
    getNewProducts();
  }

  void getUser() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      user = UserModel.fromJson(jsonDecode(prefs.getString('user') ?? ''));
    });
  }

  void getAllCategories() async {
    var response = await ProductService().getAllCategories();

    setState(() {
      categoriesList = response;
    });

    print("category : $categoriesList");
  }

  void getPopularProducts() async {
    var response = await ProductService().getAllProducts();

    setState(() {
       propularProductsList = response;
    });

    print("popular products : $propularProductsList");
  }

  void getNewProducts() async {
    var response = await ProductService().getAllProducts();

    setState(() {
       newProductsList = response;
    });

    print("new products : $newProductsList");
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hallo, ${user?.name}',
                    style: primaryTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    '@${user?.username}',
                    style: subtitleTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image_profile.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget categories() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
            var item = categoriesList[index];
            bool isSelected = selectedCategoryId == (item['id'] ?? 0);

            return Padding(
              padding: EdgeInsets.only(left: index == 0 ? defaultMargin : 0,right: 16),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedCategoryId = (item['id'] ?? 0);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected ? primaryColor : transparentColor,
                    border: Border.all(
                      color: isSelected ? transparentColor : subtitleColor,
                    ),
                  ),
                  child: Text(
                    item['name'] ?? '',
                    style: isSelected ? primaryTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                    ) : subtitleTextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            );
          },),
        ),
      );
    }

    Widget popularProductsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Produk Populer',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
        height: 300,
        margin: EdgeInsets.only(top: 14),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: propularProductsList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:  EdgeInsets.only(left: index == 0 ? defaultMargin : 0),
              child: ProductCard(item: propularProductsList[index]),
            );
        },)
      );
    }

    Widget newArrivalsTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Produk Terbaru',
          style: primaryTextStyle.copyWith(
            fontSize: 22,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: newProductsList.length,
          itemBuilder: (context, index) {
            return ProductTile(item: newProductsList[index],);
          },
        ),
      );
    }

    return ListView(
      children: [
        header(),
        categories(),
        popularProductsTitle(),
        popularProducts(),
        newArrivalsTitle(),
        newArrivals(),
      ],
    );
  }
}
