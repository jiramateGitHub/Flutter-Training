class ProductModel{
  // Field
  String name, detail, path;

  // Method
  ProductModel(this.name, this.detail, this.path);

  ProductModel.fromMap(Map <String, dynamic> map){
    name = map['name'];
    detail = map['detail'];
    path = map['path'];
  }
}