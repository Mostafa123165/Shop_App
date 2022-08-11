import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_state.dart';
import 'package:shopapp/modules/login_screen/login_screen.dart';
import 'package:shopapp/modules/search/search_screen.dart';
import 'package:shopapp/network/cash_helper.dart';

class ShopLayOut extends StatelessWidget {
  ShopLayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeMainState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Home',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  print('asd');
                  cubit.changeAppMode();
                },
                icon: Icon(
                  Icons.dark_mode,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ));
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changBottomNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
