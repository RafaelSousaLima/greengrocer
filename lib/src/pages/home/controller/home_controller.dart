import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/repository/home_repository.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/utils_services.dart';

const int itensPerPage = 6;

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  final UtilsServices utilsServices = UtilsServices();

  bool isCategoryLoading = false;
  bool isProductLoading = true;
  List<CategoryModel> allcategories = [];
  CategoryModel? currentCategory;

  List<ItemModel> get allProducts => currentCategory!.items ?? [];

  bool get isLastPage {
    if (currentCategory!.items.length < itensPerPage) {
      return true;
    }
    return currentCategory!.pagination * itensPerPage > allProducts.length;
  }

  @override
  void onInit() {
    super.onInit();
    getAllCategory();
  }

  setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }
    update();
  }

  void selectCategory(CategoryModel categoryModel) {
    currentCategory = categoryModel;
    update();
    if (currentCategory!.items.isNotEmpty) {
      return;
    }
    getAllProducts();
  }

  Future<void> getAllCategory() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await _homeRepository.getAllCategories();

    homeResult.when(success: (success) {
      allcategories.assignAll(success);
      if (allcategories.isEmpty) {
        return;
      }
      selectCategory(allcategories.first);
    }, error: (messageError) {
      utilsServices.showToast(message: messageError, isError: true);
    });

    setLoading(false);
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getAllProducts(canLoad: false);
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itensPerPage,
    };

    HomeResult<ItemModel> result = await _homeRepository.getAllProducts(body);

    result.when(success: (data) {
      currentCategory!.items.addAll(data);
    }, error: (messageErro) {
      utilsServices.showToast(message: messageErro, isError: true);
    });

    setLoading(false, isProduct: true);
  }
}
