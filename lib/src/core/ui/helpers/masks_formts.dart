import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MasksFormts {
  MasksFormts._();
  static MaskTextInputFormatter maskFormatterCPF = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );
}
