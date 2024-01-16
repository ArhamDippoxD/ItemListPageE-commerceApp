class Product {
  String name;
  double price;
  String image;
  double imageWidth;
  double imageHeight;

  int quantity;
   String size;
   String color;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.imageWidth,
    required this.imageHeight,
    this.quantity=0,
    required this.color,
    required this.size,
  });
}
