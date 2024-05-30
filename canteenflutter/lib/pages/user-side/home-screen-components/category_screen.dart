import 'package:canteenflutter/api/common-api/get_product_category_wise.dart';
import 'package:canteenflutter/api/user-side-api/home-screen-components-api/get_category.dart';
import 'package:canteenflutter/pages/user-side/home-screen-components/in_category_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreenUser extends StatefulWidget {
  const CategoryScreenUser({super.key});

  @override
  State<CategoryScreenUser> createState() => _CategoryScreenUserState();
}

class _CategoryScreenUserState extends State<CategoryScreenUser> {
  Future refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      GetCategory.getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 200),
            child: SizedBox(
              height: 50,
              width: 200,
              // decoration: BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Image.asset(MSpalsIcon),
                  // Text('MU Canteen'),
                  Container(
                    height: 75,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xfff65b08),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xfff65b08),
        toolbarHeight: 60,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: GetCategory.getCategory(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<CategoryList> category = snapshot.data;
              return Center(
                child: ListView.builder(
                  itemCount: category.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              GetStoredProductDataShortedByCategory
                                  .getProductDataCategoryWise(
                                      category[index].categoryName);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InCategoryScreenUser(
                                              category: category[index]
                                                  .categoryName)));
                            },
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              
                              child: SizedBox(
                                height: 100,
                                width: 375,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50,right: 180),
                                      child: SizedBox(
                                        width: 100,
                                        child: Text(
                                          category[index].categoryName,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.forward),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
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
