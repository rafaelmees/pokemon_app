// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/modules/app/core/presentation/config/theme/theme.dart';

class TypeChip extends StatelessWidget {
  const TypeChip({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.showIcon = true,
    this.showText = true,
    required this.type,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool showIcon;
  final bool showText;
  final String type;

  @override
  Widget build(BuildContext context) {
    assert(showIcon || showText, 'At least one of showIcon or showText must be true');

    Color _backgroundColor = backgroundColor ?? AppTheme.colorForType(type);
    Color _foregroundColor = foregroundColor ?? (_backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white);

    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: Chip(
        labelPadding: showText ? null : EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        avatar: showIcon ? SvgPicture.asset(
          'assets/types/${type.toLowerCase()}.svg',
          colorFilter: ColorFilter.mode(
            _foregroundColor,
            BlendMode.modulate,
          ),
        ) : null,
        label: showText ? Text(
          type,
          style: TextStyle(
            color: _foregroundColor,
          ),
        ) : SizedBox.shrink(),
        backgroundColor: _backgroundColor,
        // color: WidgetStateColor.resolveWith(
        //   (Set<WidgetState> states) {
        //     return backgroundColor;
        //   },
        // ),
      ),
    );
  }
}