import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/core_ui.dart';
import 'product_detail_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final int? productId;

  const ProductDetailPage({
    super.key,
    this.productId,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with Loader, Messages {
  final controller = Get.find<ProductDetailController>();
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _priceEC = TextEditingController();
  final _descriptionEC = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (controller.status.value) {
        case ProductDetailStateStatus.initial:
          break;
        case ProductDetailStateStatus.loading:
          showLoader();
          break;
        case ProductDetailStateStatus.loaded:
          // final model = controller.productModel!;
          // _nameEC.text = model.name;
          // _priceEC.text = model.price.currencyPTBR;
          // _descriptionEC.text = model.description;
          hiderLoader();
          break;
        case ProductDetailStateStatus.error:
          hiderLoader();
          showError('Error message!');
          break;
        case ProductDetailStateStatus.errorLoadProduct:
          hiderLoader();
          showError('Erro ao carregar o produto para alteração');
          Navigator.of(context).pop();
          break;
        case ProductDetailStateStatus.uploaded:
          hiderLoader();
          break;
        case ProductDetailStateStatus.deleted:
        case ProductDetailStateStatus.saved:
          hiderLoader();
          Navigator.pop(context);
          break;
      }
      // controller.loadProduct(widget.productId);
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _priceEC.dispose();
    _descriptionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthButtonAction = context.percentWidth(.4);
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(40),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.productId != null ? 'Alterar' : 'Adicionar'} Produtos',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Observer(
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              'assets/images/lanche.pnh',
                              width: 200,
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextButton(
                          onPressed: () {},
                          // onPressed: () => UploadHtmlHelper().startUpload(
                          //   controller.uploadImageProduct,
                          // ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.9),
                          ),
                          child: Obx(
                            () => Text(
                              '${controller.imagePath.value.isEmpty ? 'Adicionar' : 'Alterar'} Foto',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameEC,
                          decoration: const InputDecoration(
                            label: Text('Nome'),
                            hintText: 'Digite o titulo do produto',
                          ),
                          validator: Validatorless.required('Nome obrigatório'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _priceEC,
                          decoration: const InputDecoration(
                            label: Text('Preço'),
                            hintText: 'Digite o valor do produto',
                          ),
                          validator:
                              Validatorless.required('Preço obrigatório'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter(moeda: true),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _descriptionEC,
                minLines: 10,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  label: Text('Descrição'),
                  alignLabelWithHint: true,
                  hintText: 'Digite a descrição do produto',
                ),
                validator: Validatorless.required('Descrição obrigatória'),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: widthButtonAction,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: widthButtonAction / 2,
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        child: Visibility(
                          visible: widget.productId != null,
                          child: OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Deletar'),
                                  content: const Text(
                                    'Confirma deletar Name ?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Cancelar',
                                        style: context.textStyles.textBold
                                            .copyWith(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        controller.deleteProduct();
                                      },
                                      child: Text(
                                        'Confirmar',
                                        style: context.textStyles.textBold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                            ),
                            child: Text(
                              'Deletar',
                              style: context.textStyles.textBold
                                  .copyWith(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: widthButtonAction / 2,
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;
                            if (valid) {
                              if (controller.imagePath.isEmpty) {
                                showWarning(
                                  'Imagem obrigatória, por favor clieque em adicionar foto',
                                );
                                return;
                              }
                              // controller.save(
                              //   _nameEC.text,
                              //   UtilBrasilFields.converterMoedaParaDouble(
                              //     _priceEC.text,
                              //   ),
                              //   _descriptionEC.text,
                              // );
                            }
                          },
                          child: Text(
                            'Salvar',
                            style: context.textStyles.textBold
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
