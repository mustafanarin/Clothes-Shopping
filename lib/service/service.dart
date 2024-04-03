import 'dart:io';

import 'package:clothes_shopping/model/categories_model.dart';
import 'package:clothes_shopping/model/product_model.dart';
import 'package:dio/dio.dart';

class Service{
  final Dio _dio;
  Service() : _dio  = Dio(BaseOptions(baseUrl: "https://api.escuelajs.co/api/v1/"));
  

  Future<List<CategoriesModel>?> fetchCategoryItems() async {
    try {
      final response = await _dio.get(_categoryPath.categories.name);

      if(response.statusCode == HttpStatus.ok){
        final datas = response.data;
      
        if(datas is List){
          return datas.map((e) => CategoriesModel.fromJson(e)).toList();
      
        }
      }
    } on DioException catch (error) {
      print(error);
    }
    
    return null;
  }


  Future<List<ProductModel>?> fetchProductWithCategoryId(int categoryId) async {
    try {
      final response = await _dio.get("${_productPath.products.name}/",
      queryParameters: {_productPath.categoryId.name:categoryId});

      if(response.statusCode == HttpStatus.ok){
        final datas = response.data;
      
        if(datas is List){
          return datas.map((e) => ProductModel.fromJson(e)).toList();
      
        }
      }
    }on DioException catch (error) {
      print(error);
    }
    
    return null;
  }
}

enum _categoryPath {categories}
enum _productPath {products, categoryId}