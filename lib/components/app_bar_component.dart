import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:on_health_app/main.dart';
import 'package:on_health_app/providers/auth_provider.dart';
import 'package:on_health_app/utils/capitalize.dart';
import 'package:on_health_app/utils/cpf_format.dart';
import 'package:provider/provider.dart';

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  const AppBarComponent({super.key, required this.scaffoldKey});

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        saveImg(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _image = prefs.getString('profileImg') == null
        ? null
        : File(prefs.getString('profileImg')!);
  }

  saveImg(path) async {
    await prefs.setString('profileImg', path);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    final userInfo = provider.userData;

    return AppBar(
      toolbarHeight: 80,
      leading: IconButton(
        icon: const Icon(Icons.menu, size: 30),
        onPressed: () => widget.scaffoldKey.currentState!.openDrawer(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${userInfo['nome']!}'.capitalizeByWord(),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              'CPF: ${CPF.format(userInfo['cpf']!)}',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      actions: [
        _image == null
            ? InkWell(
                onTap: getImage,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 25,
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                ),
              )
            : InkWell(
                onTap: getImage,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: FileImage(_image!),
                  ),
                ),
              ),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      elevation: 0,
    );
  }
}
