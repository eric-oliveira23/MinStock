import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minstock/features/inventory/add_product/add_product_provider.dart';

class ShowCameraBottomSheet extends StatelessWidget {
  const ShowCameraBottomSheet({
    super.key,
    required this.addProductProvider,
  });

  final AddProductProvider addProductProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        0,
        0,
        MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text("Selecione o modo de foto."),
          ),
          const SizedBox(height: 15),
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text("Galeria"),
                onTap: () {
                  Navigator.pop(context);
                  addProductProvider.getImage(context, ImageSource.gallery);
                },
                tileColor: Colors.transparent,
              ),
              ListTile(
                title: const Text("Tirar foto"),
                onTap: () {
                  Navigator.pop(context);
                  addProductProvider.getImage(context, ImageSource.camera);
                },
                tileColor: Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
