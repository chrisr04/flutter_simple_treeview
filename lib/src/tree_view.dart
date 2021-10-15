// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/src/primitives/tree_theme.dart';

import 'builder.dart';
import 'copy_tree_nodes.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';

/// Tree view with collapsible and expandable nodes.
class TreeView extends StatefulWidget {
  /// List of root level tree nodes.
  final List<TreeNode> nodes;

  /// Tree controller to manage the tree state.
  final TreeController? treeController;

  /// Theme of widget
  final TreeTheme theme;

  /// Circle radius of avatar widget
  final double avatarRadius;

  /// allow expand all nodes of tree. if is [false] none node could be expanded
  final bool expandNodes;

  TreeView({
    Key? key,
    required List<TreeNode> nodes,
    this.treeController,
    this.expandNodes = true,
    this.theme = const TreeTheme(),
    double avatarRadius = 20.0,
  })  : nodes = copyTreeNodes(nodes),
        avatarRadius = (avatarRadius < 10.0) ? 10.0 : avatarRadius,
        super(key: key);

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  TreeController? _controller;

  @override
  void initState() {
    _controller = widget.treeController ?? TreeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildNodes(
      null,
      widget.nodes,
      widget.avatarRadius,
      _controller!,
      widget.theme,
      widget.expandNodes,
    );
  }
}
