import 'package:dars47/models/product.dart';
import 'package:dars47/viewmodels/products_viewmodel.dart';
import 'package:flutter/material.dart';

class ManageProductsScreen extends StatefulWidget {
  final Product? product;
  final ProductsViewmodel productsViewModel;
  const ManageProductsScreen({
    super.key,
    this.product,
    required this.productsViewModel,
  });

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final formKey = GlobalKey<FormState>();
  String? title;
  double? price;
  int? amount;
  String? image;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      title = widget.product!.title;
      price = widget.product!.price;
      amount = widget.product!.amount;
      image = widget.product!.image;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      // Mahsulotlarni qo'shamiz!
      setState(() {
        isLoading = true;
      });
      if (widget.product == null) {
        widget.productsViewModel
            .addProduct(
          title!,
          price!,
          amount!,
          image!,
        )
            .then((_) {
          Navigator.pop(context, true);
        });
      } else {
        widget.productsViewModel
            .editProduct(
          widget.product!.id,
          title!,
          price!,
          amount!,
          image!,
        )
            .then((_) {
          Navigator.pop(context, true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null
              ? "Mahsulot qo'shish"
              : "Mahsulotni tahrirlash",
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              initialValue: title,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mahsulot nomi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot nomini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                title = newValue!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: price?.toString(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mahsulot narxi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot narxini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                price = double.parse(newValue!);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: amount?.toString(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mahsulot miqdori",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot miqdorini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                amount = int.parse(newValue!);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: image,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mahsulot rasmi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot rasmini kiriting";
                } else if (!value.startsWith("http") &&
                    (!value.endsWith("png") ||
                        !value.endsWith("jpg") ||
                        !value.endsWith("jpeg"))) {
                  return "Iltimos to'g'ri rasm havolasini kiriting";
                }
                return null;
              },
              onSaved: (newValue) {
                image = newValue!;
              },
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
                : FilledButton.icon(
                    onPressed: submit,
                    label:
                        Text(widget.product == null ? "SAQLASH" : "YANGILASH"),
                    icon: const Icon(Icons.check),
                  ),
          ],
        ),
      ),
    );
  }
}
