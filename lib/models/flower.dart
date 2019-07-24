class Flower {
  final String category;
  final double price;
  final String instructions;
  final String photo;
  final String name;
  final int productId;

  Flower(
      {this.category,
      this.price,
      this.instructions,
      this.photo,
      this.name,
      this.productId});

  factory Flower.fromMap(Map<String, dynamic> json) => new Flower(
      category: json['category'] as String,
      price: json['price'] as double,
      instructions: json['instructions'] as String,
      photo: json['photo'] as String,
      name: json['name'] as String,
      productId: json['productId'] as int
  );
}
