import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';

import '../../core/ui/core_ui.dart';
import 'products_controller.dart';
import 'widgets/product_item.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with Loader, Messages {
  final controller = Get.find<ProductsController>();
  final debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      switch (controller.status.value) {
        case ProductStateStatus.initial:
          break;
        case ProductStateStatus.loading:
          showLoader();
          break;
        case ProductStateStatus.loaded:
          hiderLoader();
          break;
        case ProductStateStatus.error:
          hiderLoader();
          showError('Erro ao buscar produtos');
          break;
        case ProductStateStatus.addOrUpdateProduct:
          hiderLoader();
          final productSelected = controller.productSelected;
          var uri = '/products/detail';

          uri += '?id=${productSelected.value!.id}';

          await Get.to(uri);
          controller.loadProducts();
          break;
      }
      controller.loadProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(
        children: [
          BaseHeader(
            title: 'ADMINISTRAR PRODUTOS',
            buttonLabel: 'ADICIONAR PRODUTO',
            buttonPressed: controller.addProduct,
            searchChange: (value) {
              debouncer.call(() {
                controller.filterByName(value);
              });
            },
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return GridView.builder(
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 280,
                    mainAxisSpacing: 20,
                    maxCrossAxisExtent: 280,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return const ProductItem();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
