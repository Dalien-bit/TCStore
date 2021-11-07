class Product {
  final String productName;
  final String? productId;
  final double price;
  final String description;
  final String photo;
  final int quantityAvailable;

  Product({
    required this.productName,
    this.productId,
    required this.price,
    required this.description,
    required this.photo,
    required this.quantityAvailable,
  });
}

class Item {
  final String itemName;
  final String? itemId;
  final String? photo;
  final List<Product>? listOfProducts;

  Item({
    required this.itemName,
    this.itemId,
    this.photo,
    this.listOfProducts,
  });
}

