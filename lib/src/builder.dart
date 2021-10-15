// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/src/primitives/tree_theme.dart';

import 'node_widget.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';

/// Builds set of [nodes] respecting [state], [indent] and [iconSize].
Widget buildNodes(
  TreeNode? father,
  Iterable<TreeNode> nodes,
  double avatarRadius,
  TreeController state,
  TreeTheme theme,
  bool expandNodes,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var node in nodes)
        NodeWidget(
          father: father,
          treeNode: node,
          state: state,
          avatarRadius: avatarRadius,
          isLastChild: nodes.last == node,
          theme: theme,
          expandNodes: expandNodes,
        )
    ],
  );
}
