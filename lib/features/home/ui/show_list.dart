import 'package:flutter/material.dart';
import 'package:grocery_app/features/home/bloc/home_bloc.dart';
import 'package:grocery_app/models/list_model.dart';

class ShowList extends StatelessWidget {
  final ListModel list;
  final HomeBloc homeBloc;
  const ShowList({required this.list, required this.homeBloc, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

                                  image: NetworkImage(list.imgUrl),
                                  fit: BoxFit.contain
                              ),
                            ),
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("\$ ${list.price} - ", style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              )
                              ),
                              Text(list.name, style: const TextStyle(
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
                                    homeBloc.add(HomeCartIconClickedEvent(cartClicked: list));
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
                                    homeBloc.add(HomeFavoritesIconClickedEvent(favClicked: list.copyWith(fav: !list.fav)));
                                  },
                                  icon: Icon(
                                    list.fav? Icons.favorite : Icons.favorite_border_outlined,
                                    color: list.fav ? Colors.redAccent : Colors.black,
                                  )
                              )


                        )
                    ]
                ),
              );

  }
}
