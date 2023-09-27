import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';

@immutable
class CartMenu extends StatelessWidget {
  const CartMenu({
    super.key,
    required this.builder,
  });

  final PullDownMenuButtonBuilder builder;

  @override
  Widget build(BuildContext context) => PullDownButton(
        itemBuilder: (context) => [
          PullDownMenuItem(
            onTap: () {},
            title: 'Delete',
            isDestructive: true,
            icon: CupertinoIcons.delete,
          ),
        ],
        animationBuilder: null,
        position: PullDownMenuPosition.automatic,
        buttonBuilder: builder,
      );
}
