class Item {
  String imgPath;
  double price;
  String location;
  Item(
      {required this.imgPath,
      required this.price,
      this.location = "main branch"});
}

final List<Item> items = [
  Item(
      imgPath: "assets/image/images.jpeg",
      price: 1233.99,
      location: "Kerollos Shop"),
  Item(imgPath: "assets/image/images (4).jpeg", price: 1234.99),
  Item(imgPath: "assets/image/images (3).jpeg", price: 1335.99),
  Item(imgPath: "assets/image/images (2).jpeg", price: 1212.99),
];
