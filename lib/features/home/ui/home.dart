import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/features/home/bloc/home_bloc.dart';
import 'package:sample_app/features/home/ui/product_data_model.dart';
import 'package:sample_app/res/color_constants.dart';
import 'package:sample_app/res/styles/font_styles.dart';
import 'package:sample_app/utils/Routes/appRoutes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final home_bloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: home_bloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigationToCartPageActionState) {
          Navigator.pushNamed(context, AppRoutes.cartpage);
        } else if (state is HomeNavigationToWishlistPageActionState) {
          Navigator.pushNamed(context, AppRoutes.whishlistPage);
        } else if (state is HomeProductItemCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Product added to whishlist")));
        } else if (state is HomeProductItemWhsihlistActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Product added to cart")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Center(
              child: CircularProgressIndicator(),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  centerTitle: true,
                  title: Text(
                    "Grocery App",
                    style: FontStyles.textStyle,
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          home_bloc.add(HomeWishlistButtonNavigateEvent());
                        },
                        icon: Icon(
                          Icons.favorite_border,
                          color: ColorConstants.white,
                        )),
                    IconButton(
                        onPressed: () {
                          home_bloc.add(HomeCarttButtonNavigateEvent());
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: ColorConstants.white,
                        )),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                        productDataModel: successState.products[index],
                        home_bloc: home_bloc,
                      );
                    },
                  ),
                ));
          case HomeErrorState:
            return Scaffold(
              body: Text("Error loading product details"),
            );
          default:
            return SizedBox();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    home_bloc.add(HomeInitialEvent());
  }
}
