import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/ui/core_ui.dart';
import 'menu_button.dart';
import 'menu_enum.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({super.key});

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> with HistoryBackListner {
  final selectedMenu = Rx<Menu?>(null);
  var colapsed = false.obs;

  @override
  void onHistoryBack(Event event) {
    setState(() {
      selectedMenu.value = Menu.findByPath(Get.currentRoute);
    });
  }

  @override
  void initState() {
    selectedMenu.value = Menu.findByPath(Get.currentRoute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: colapsed.value ? 90 : context.percentWidth(.18),
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment:
                  colapsed.value ? Alignment.center : Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    colapsed.value = !colapsed.value;
                  });
                },
                icon: Icon(
                  colapsed.value
                      ? Icons.keyboard_double_arrow_right
                      : Icons.keyboard_double_arrow_left,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: Menu.values.length,
              itemBuilder: (context, index) {
                final menu = Menu.values[index];
                return MenuButton(
                  menu: menu,
                  menuSelected: selectedMenu.value,
                  onPressed: (Menu menu) {
                    selectedMenu.value = menu;
                    Get.to(menu.route);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
