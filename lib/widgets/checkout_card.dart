// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:zeazeoshop/models/cart_model/cart_item_model.dart';
import 'package:zeazeoshop/theme.dart';

class CheckoutCard extends StatelessWidget {
  final CartItemModel cartItemModel;

  const CheckoutCard({
    Key? key,
    required this.cartItemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (cartItemModel.productItemModel?.galleries?.isNotEmpty ?? false)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                    cartItemModel.productItemModel?.galleries?.first.url ?? '',
                  ),
                ),
              ),
            )
          else
            Container(
              width: 60,
              height: 60,
              color: Colors.grey,
            ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItemModel.productItemModel?.name ?? '',
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '\$${cartItemModel.productItemModel?.price ?? 0}',
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            '${cartItemModel.quantity ?? 0} Items',
            style: secondaryTextStyle.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
