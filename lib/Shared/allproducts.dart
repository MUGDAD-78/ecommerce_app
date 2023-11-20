class Product {
  String picture;
  double price;
  String name;
  String location;
  Product({
    required this.picture,
    required this.price,
    required this.name,
    this.location = "Main Branch",
  });
}


  List allProudcts = [
      Product(name : "Product1",picture: "assets/1.webp", price: 12.30,),
      Product(name : "Product2",picture: "assets/2.webp", price: 12.30,),
      Product(name : "Product3",picture: "assets/3.webp", price: 12.30,),
      Product(name : "Product4",picture: "assets/4.webp", price: 12.30,),
      Product(name : "Product5",picture: "assets/5.webp", price: 12.30,),
      Product(name : "Product6",picture: "assets/6.webp", price: 12.30,),
      Product(name : "Product7",picture: "assets/7.webp", price: 12.30,),
      Product(name : "Product8",picture: "assets/8.webp", price: 12.30,),
    ];
