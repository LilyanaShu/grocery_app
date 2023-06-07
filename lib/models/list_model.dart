class ListModel{
  final String id;
  final String name;
  final String desc;
  final String price;
  final String imgUrl;
  final bool fav;

  ListModel({required this.id, required this.name, required this.desc,
    required this.price, required this.imgUrl, required this.fav});

  ListModel copyWith({
    String? id,
    String? name,
    String? desc,
    String? price,
    String? imgUrl,
    bool? fav,
  }) {
    return ListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      fav: fav ?? this.fav,
    );
  }
}