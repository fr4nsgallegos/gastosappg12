class TypeModel {
  String type;
  String image;

  TypeModel(this.type, this.image);
}

List<TypeModel> typesList = [
  TypeModel("Alimentos", "assets/icons/alimentos.webp"),
  TypeModel("Banco y seguro", "assets/icons/bancos.webp"),
  TypeModel("Entretenimiento", "assets/icons/entretenimiento.webp"),
  TypeModel("Servicios", "assets/icons/servicios.webp"),
  TypeModel("Otros", "assets/icons/otros.webp"),
];
