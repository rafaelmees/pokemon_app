import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/modules/pokemon/presentation/pages/list/list_page.dart';

class AppSplashPage extends StatefulWidget {
  const AppSplashPage({
    super.key,
  });

  @override
  State<AppSplashPage> createState() => _AppSplashPageState();
}

class _AppSplashPageState extends State<AppSplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const PokemonListPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/images/pokeball_icon.svg',
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
