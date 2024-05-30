class ShortingCat{
  static List<CategoryShorting> categoryShorting = [];

}

class CategoryShorting {
  final String proCategory;

  CategoryShorting({required this.proCategory});

  factory CategoryShorting.fromMap(Map<String, dynamic> map) {
    // Add return statement at the end
    return CategoryShorting(proCategory: map['proCategory']);
  }

  toMap() {
    return {
      'proCategory': proCategory,
    };
  }
}