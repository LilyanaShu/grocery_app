import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/features/home/bloc/home_bloc.dart';
import 'package:grocery_app/models/list_model.dart';

class ShowFav extends StatelessWidget {
  final List<ListModel> list;
  final HomeBloc homeBloc;
  const ShowFav({required this.list, required this.homeBloc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Items'),
      ),
      body: BlocBuilder(
        bloc: homeBloc,
          buildWhen: (previous, current) => current is !HomeActionState,
          builder: (context, state){
            switch(state.runtimeType){
              case(HomeFavoriteRebuildState):
              {
                final rebuild = state as HomeFavoriteRebuildState;
                return ListView.builder(
                    itemCount: rebuild.list.length,
                    itemBuilder: (context,index){
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          alignment: Alignment.center,

                                          image: NetworkImage(rebuild.list[index].imgUrl),
                                          fit: BoxFit.contain
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("\$ ${rebuild.list[index].price} - ", style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      )
                                      ),
                                      Text(rebuild.list[index].name, style: const TextStyle(
                                        fontSize: 16,
                                      ),),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: (){
                                           // homeBloc.add(HomeCartIconClickedEvent(cartClicked: list[index]));

                                          },
                                          child: const Row(
                                            children: [
                                              Text('Add cart  '),
                                              Icon(Icons.add, size: 20,),
                                            ],
                                          )),
                                      const SizedBox(width: 5,)
                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                top: 115,
                                left: -5,
                                child: IconButton(
                                    onPressed: (){
                                      homeBloc.add(HomeRemoveFavClickedEvent(favRemove: rebuild.list[index].copyWith(fav: !rebuild.list[index].fav)));
                                    },
                                    icon: Icon(
                                      rebuild.list[index].fav? Icons.favorite : Icons.favorite_border_outlined,
                                      color: rebuild.list[index].fav ? Colors.redAccent : Colors.black,
                                    )
                                ),
                              )
                            ]
                        ),
                      );

                    }
                );
              }
              default:
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context,index){
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          alignment: Alignment.center,

                                          image: NetworkImage(list[index].imgUrl),
                                          fit: BoxFit.contain
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("\$ ${list[index].price} - ", style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      )
                                      ),
                                      Text(list[index].name, style: const TextStyle(
                                        fontSize: 16,
                                      ),),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: (){
                                            homeBloc.add(HomeCartIconClickedEvent(cartClicked: list[index]));

                                          },
                                          child: const Row(
                                            children: [
                                              Text('Add cart  '),
                                              Icon(Icons.add, size: 20,),
                                            ],
                                          )),
                                      const SizedBox(width: 5,)
                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                top: 115,
                                left: -5,
                                child: IconButton(
                                    onPressed: (){
                                      homeBloc.add(HomeRemoveFavClickedEvent(favRemove: list[index].copyWith(fav: !list[index].fav)));
                                    },
                                    icon: Icon(
                                      list[index].fav? Icons.favorite : Icons.favorite_border_outlined,
                                      color: list[index].fav ? Colors.redAccent : Colors.black,
                                    )
                                ),
                              )
                            ]
                        ),
                      );

                    }
                );
            }
          }
      )
    );
  }
}
