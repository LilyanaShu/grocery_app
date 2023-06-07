import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/features/cart/ui/cart.dart';
import 'package:grocery_app/features/home/ui/show_fav.dart';
import 'package:grocery_app/features/home/ui/show_list.dart';

import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState ,
      buildWhen: (previous, current) {
        //print('buildwhen' + homeBloc.state.toString() );
        return current is !HomeActionState && current is !HomeFavoriteRebuildState ; },
        // {print(homeBloc.state.toString());
      listener: (context, state) {
        // TODO: implement listener
        if(state is HomeGotoCartActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));
        }
        else if (state is HomeGotoFavoritesActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ShowFav(list: state.favList, homeBloc: homeBloc)));
        }
        else if (state is HomeAddFavoritesActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fav listed')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType){
           case HomeLoadingState:
            return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
          case HomeSuccessState:
            final successState = state as HomeSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Grocery App'),
                actions: [
                  IconButton(
                      onPressed: (){
                        homeBloc.add(HomeFavoritesPageEvent(favList: successState.list));
                      },
                      icon: const Icon(Icons.favorite_border_outlined)
                  ),
                  IconButton(
                      onPressed: (){
                        homeBloc.add(HomeCartPageEvent());
                      },
                      icon: const Icon(Icons.shopping_cart_outlined))
                ],
              ),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: successState.list.length,
                  itemBuilder: (context, index){
                    return ShowList(list: successState.list[index], homeBloc: homeBloc,);
                  }
              ),
            );
          case HomeErrorState:
            return const Scaffold(body: Center(child: Text("Error"),),);
          default:
            return Scaffold(body: Center(child: Text('case default $state' ),),);
        }
      },
    );
  }
}
