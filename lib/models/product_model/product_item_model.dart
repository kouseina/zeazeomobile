class ProductItemModel {
  int? id;
  String? name;
  int? price;
  String? description;
  int? categoriesId;
  Category? category;
  List<Galleries>? galleries;

  ProductItemModel(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.categoriesId,
      this.category,
      this.galleries});

  ProductItemModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    categoriesId = json['categories_id'];
    category = json['category'] != null
        ? Category.fromMap(json['category'])
        : null;
    if (json['galleries'] != null) {
      galleries = <Galleries>[];
      json['galleries'].forEach((v) {
        galleries!.add(Galleries.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['categories_id'] = categoriesId;
    if (category != null) {
      data['category'] = category!.toMap();
    }
    if (galleries != null) {
      data['galleries'] = galleries!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;
  Category(
      {this.id, this.name,});

  Category.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Galleries {
  int? id;
  int? productsId;
  String? url;

  Galleries(
      {this.id,
      this.productsId,
      this.url});

  Galleries.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    productsId = json['products_id'];
    url = json['url'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['products_id'] = productsId;
    data['url'] = url;
    return data;
  }
}
