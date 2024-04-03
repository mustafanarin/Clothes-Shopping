
import 'package:clothes_shopping/model/categories_model.dart';
import 'package:clothes_shopping/service/service.dart';
import 'package:clothes_shopping/views/product.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => CcategoriesPageState();
}

class CcategoriesPageState extends State<CategoriesPage> {

  List<CategoriesModel>? _categoryItems;
  bool isLoading = false;
  late final Service service;

  @override
  void initState() {
    super.initState();
    service = Service();
    fetchCategoryItems();
  }

  void _changeLoading(){
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> fetchCategoryItems() async {
    _changeLoading();
    _categoryItems = await service.fetchCategoryItems();
    _changeLoading();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1
        ), itemBuilder: (context,index) {
          return Card(
            color: Colors.amber,
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(categoryId: _categoryItems?[index].id ?? 0)));
              },
              title: Center(child: Text(_categoryItems?[index].name ?? "",maxLines: 1,)),
            ),
          );
        })
    );
  }
}