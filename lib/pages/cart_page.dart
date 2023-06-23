import 'package:flutter/material.dart';
import 'package:zeazeoshop/models/cart_model/cart_item_model.dart';
import 'package:zeazeoshop/theme.dart';
import 'package:zeazeoshop/utils/shared_pref.dart';
import 'package:zeazeoshop/widgets/cart_card.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var cart = <CartItemModel>[];
  var totalPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getCartWithDistinct();
  }

  void _getCartWithDistinct() {
    var idSet = <int>{};
    var distinct = <CartItemModel>[];
    for (var d in SharedPrefs().cart ?? <CartItemModel>[]) {
      if (d.productItemModel?.id == null) continue;

      if (idSet.add(d.productItemModel?.id ?? 0)) {
        distinct.add(d);
      }

      ///
      else {
        int existItemIndex = distinct.indexWhere((element) =>
            element.productItemModel?.id == d.productItemModel?.id);

        distinct[existItemIndex].quantity =
            (distinct[existItemIndex].quantity ?? 0) + (d.quantity ?? 0);
      }
    }

    setState(() {
      cart = distinct;
    });

    _updateTotalPrice();
  }

  void _updateTotalPrice() {
    int totalPrice = 0;

    for (var element in cart) {
      int pricePerElement =
          (element.quantity ?? 0) * (element.productItemModel?.price ?? 0);

      setState(() {
        totalPrice += pricePerElement;
      });
    }

    this.totalPrice = totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Keranjang',
        ),
        elevation: 0,
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon_empty_cart.png',
              width: 80,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Keranjang Kosong',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Cari Produk Lainnya',
              style: secondaryTextStyle,
            ),
            Container(
              width: 154,
              height: 44,
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home', (route) => false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
                child: Text(
                  'Explore Store',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView.builder(
        itemCount: cart.length,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        itemBuilder: (context, index) {
          var item = cart[index];

          void onTapAdd() {
            var cartAddedQty = cart.map((e) {
              if (e.productItemModel?.id == item.productItemModel?.id) {
                return e.copyWith(quantity: (e.quantity ?? 0) + 1);
              }

              return e;
            }).toList();

            setState(() {
              cart = cartAddedQty;
            });

            _updateTotalPrice();
          }

          void onTapMin() {
            var cartMinQty = <CartItemModel>[];

            for (var e in cart) {
              if (e.productItemModel?.id == item.productItemModel?.id) {
                if (e.quantity == 1) continue;

                cartMinQty.add(e.copyWith(quantity: (e.quantity ?? 1) - 1));
                continue;
              }

              cartMinQty.add(e);
            }

            setState(() {
              cart = cartMinQty;
            });

            _updateTotalPrice();
          }

          void onTapRemove() {
            setState(() {
              cart = cart
                  .where((element) =>
                      element.productItemModel?.id != item.productItemModel?.id)
                  .toList();
            });

            _updateTotalPrice();
          }

          return CartCard(
            cartItemModel: item,
            onTapAdd: onTapAdd,
            onTapMin: onTapMin,
            onTapRemove: onTapRemove,
          );
        },
      );
    }

    Widget customBottomNav() {
      return Container(
        height: 180,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: primaryTextStyle,
                  ),
                  Text(
                    '\$$totalPrice',
                    style: priceTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              thickness: 0.3,
              color: subtitleColor,
            ),
            SizedBox(
              height: 30,
            ),
            IgnorePointer(
              ignoring: totalPrice == 0,
              child: Opacity(
                opacity: totalPrice == 0 ? 0.5 : 1,
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/checkout', arguments: {
                        'cart': cart,
                        'totalPrice': totalPrice,
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lanjut Checkout',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: primaryTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () {
        SharedPrefs().cart = cart;

        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: backgroundColor3,
        appBar: header(),
        body: content(),
        bottomNavigationBar: customBottomNav(),
      ),
    );
  }
}
