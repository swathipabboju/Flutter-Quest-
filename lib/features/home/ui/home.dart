import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/features/home/bloc/home_bloc.dart';
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
        }else if(state is HomeNavigationToWishlistPageActionState){
              Navigator.pushNamed(context, AppRoutes.whishlistPage);
        }
      },
      builder: (context, state) {
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
        );
      },
    );
  }
}
