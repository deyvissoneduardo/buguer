import 'package:flutter/material.dart';

import '../core/ui/core_ui.dart';
import 'menu/menu_bar.dart' as menu;

class BaseLayout extends StatelessWidget {
  final Widget body;

  const BaseLayout({
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final shortestSide = context.screenShortestSide;
    return Scaffold(
      body: SizedBox(
        height: context.screenHeight,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              color: Colors.black,
              constraints: BoxConstraints(
                minWidth: screenWidth,
                maxHeight: shortestSide * .15,
                minHeight: shortestSide * .15,
              ),
              child: Container(
                width: shortestSide * .13,
                margin: const EdgeInsets.only(left: 60),
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(
                right: 60.0,
                top: shortestSide / 25,
              ),
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(
                        'Deseja sair ?',
                        style: context.textStyles.textButtonLabel,
                        textAlign: TextAlign.center,
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
                          onPressed: () {},
                          child: Text(
                            'Confirmar',
                            style: context.textStyles.textBold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'SAIR',
                  style: context.textStyles.textRegular
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned.fill(
              top: shortestSide * .13,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                    right: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    const menu.MenuBar(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: Colors.grey[50]!,
                        child: Container(
                          color: Colors.grey[50],
                          padding: const EdgeInsets.only(
                            left: 40,
                            top: 40,
                            right: 40,
                          ),
                          child: body,
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
    );
  }
}
