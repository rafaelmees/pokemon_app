part of 'theme.dart';

class _AppColor {
  static ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0XFF333333),
    brightness: Brightness.dark,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  );

  static const Map<String, Color> colorsByTypes = <String, Color>{
    'bug': Color(0xFFC3D26C),
    'dark': Color(0xFFA89489),
    'dragon': Color(0xFFB17FFC),
    'electric': Color(0xFFFED85F),
    'fairy': Color(0xFFFEB2C1),
    'fighting': Color(0xFFEC7A76),
    'fire': Color(0xFFFEAD79),
    'flying': Color(0xFFCEB8F6),
    'ghost': Color(0xFFAA92BE),
    'grass': Color(0xFF92D991),
    'ground': Color(0xFFEDC776),
    'ice': Color(0xFFACE4E3),
    'normal': Color(0xFFA0A3A0),
    'poison': Color(0xFFD586C2),
    'psychic': Color(0xFFFE93B5),
    'rock': Color(0xFFD7C17E),
    'steel': Color(0xFF2896A2),
    'water': Color(0xFF95BAF1),
  };
}
