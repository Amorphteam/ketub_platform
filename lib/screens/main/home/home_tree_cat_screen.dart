import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTreeCatScreen extends StatelessWidget {
  // Define the tree structure
  final List<TreeNode> tree = [
    TreeNode("المحاضرات", [
      TreeNode("البحث الخارج", [
        TreeNode("الدراسات النقلية", [
          TreeNode("الفقه", [
            TreeNode("الأمر بالمعروف والنهي عن المنكر", []),
            TreeNode("بحوث في فقه الأقليات الدينية", []),
          ]),
        ]),
      ]),
      TreeNode("تاريخ العلوم", []),
    ]),
    TreeNode("المقالات", []),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tree.length,
      itemBuilder: (context, index) {
        return buildTreeNode(tree[index], 0, context);
      },
    );
  }

  Widget buildTreeNode(TreeNode node, int level, BuildContext context) {
    const maxLevel = 5;
    const minFontSize = 10.0;
    const maxFontSize = 18.0;
    const minPadding = 0.0;
    const maxPadding = 40.0;
    final padding = level == 0 ? 8.0 : maxPadding - ((maxPadding - minPadding) / maxLevel) * level; // Calculate padding
    final fontSize = maxFontSize - ((maxFontSize - minFontSize) / maxLevel) * level; // Calculate font size

    return Padding(
      padding: EdgeInsets.only(right: padding), // Adjust the spacing here
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent), // Hide the divider
        child: ExpansionTile(
          title: Text(
            node.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: fontSize.toDouble()), // Use the desired text style
          ),
          children: node.children.map((child) {
            return buildTreeNode(child, level + 1, context); // Increase the indentation level
          }).toList(),
        ),
      ),
    );
  }
}



class TreeNode {
  final String title;
  final List<TreeNode> children;

  TreeNode(this.title, this.children);
}