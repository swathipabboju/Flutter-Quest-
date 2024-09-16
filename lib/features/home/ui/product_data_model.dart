import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sample_app/features/home/bloc/home_bloc.dart';
import 'package:sample_app/model/bloc_model/home_product_data.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc home_bloc;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.home_bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(child: _buildImage(productDataModel.imageUrl.toString())),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            '${productDataModel.name}',
            textAlign: TextAlign.start,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                // use '\$' to use $ in as text
                '₹ ${productDataModel.price}',
                softWrap: true,
                maxLines: 2, // Limit the description to 2 lines
                overflow: TextOverflow.ellipsis, //
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    home_bloc.add(HomeWishlistButtonClickedEvent(
                        clickedProduct: productDataModel));
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    home_bloc.add(HomeCartButtonClickedEvent(
                        clickedProduct: productDataModel));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('data:image')) {
      // Extract the Base64 part of the string and decode it
      final base64String = imageUrl.split(',').last;
      final imageBytes = base64Decode(base64String);
      return Image.memory(
        imageBytes,
        fit: BoxFit.fill,
      );
    } else {
      return Image.network(
        imageUrl,
      );
    }
  }
}
