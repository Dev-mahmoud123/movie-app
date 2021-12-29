import 'package:flutter/material.dart';
import 'navigation_sub_list_items.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final  Function(dynamic param) onPressed;
  final List<String> children;

  const NavigationExpandedListItem(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 4.0),
        ],
      ),
      child: ExpansionTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          children: [
            for (var i = 0; i < children.length; i++)
              NavigationSubListItems(
                title: children[i],
                onPressed: ()=>onPressed(i),
              )
          ]),
    );
  }
}
