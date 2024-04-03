import 'package:clothes_shopping/model/product_model.dart';
import 'package:clothes_shopping/service/service.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.categoryId});
  final int? categoryId;
  

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {


  List<ProductModel>? _productItems;
  bool isLoading = false;
  late final Service service;

  @override
  void initState() {
    super.initState();
    service = Service();
    fetchProductWithCategoryId(widget.categoryId ?? 0);
  }

  void _changeLoading(){
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> fetchProductWithCategoryId(int postId) async {
    _changeLoading();
    _productItems = await service.fetchProductWithCategoryId(postId);
    _changeLoading();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          childAspectRatio: 1/1.5
          ), 
          itemBuilder: (context,index) {
            return Card(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child: Image.network(_productItems?[index].images.toString() ?? "aa" )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_productItems?[index].title ?? ""),
                      Text("${_productItems?[index].price} ₺"),
                      //Text()
                    ],
                  )
                ],
              ),
            );
          }),

    );
  }
}