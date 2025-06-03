class SubSubCategory {
  final int id;
  final String name;

  SubSubCategory({required this.id, required this.name});
}

class SubCategory {
  final int id;
  final String name;
  final List<SubSubCategory> subSubcategories;

  SubCategory(
      {required this.id, required this.name, required this.subSubcategories});
}

class Category {
  final int id;
  final String name;
  final List<SubCategory> subcategories;

  Category({required this.id, required this.name, required this.subcategories});
}
