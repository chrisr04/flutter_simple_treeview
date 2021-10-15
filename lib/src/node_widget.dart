// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';
import 'primitives/edge_line.dart';
import 'primitives/rect_line.dart';
import 'primitives/tree_controller.dart';
import 'primitives/tree_node.dart';
import 'primitives/tree_theme.dart';
import 'builder.dart';

/// Widget that displays one [TreeNode] and its children.
class NodeWidget extends StatefulWidget {
  final TreeNode? father;
  final TreeNode treeNode;
  final TreeController state;
  final bool isLastChild;
  final bool expandNodes;
  final double avatarRadius;
  final TreeTheme theme;

  const NodeWidget({
    Key? key,
    this.father,
    required this.treeNode,
    required this.state,
    required this.avatarRadius,
    required this.theme,
    this.isLastChild = false,
    this.expandNodes = true,
  }) : super(key: key);

  @override
  _NodeWidgetState createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late CurvedAnimation animation;
  late double indent;

  void _prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (_isExpanded && !_isLeaf) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  void _onExpandNode() {
    setState(() {
      widget.state.toggleNodeExpanded(widget.treeNode.key!);
      _runExpandCheck();
    });
  }

  bool get _isLeaf {
    return widget.treeNode.children == null ||
        widget.treeNode.children!.isEmpty;
  }

  bool get _isExpanded {
    return widget.state.isNodeExpanded(widget.treeNode.key!);
  }

  @override
  void initState() {
    super.initState();
    _prepareAnimations();
    _runExpandCheck();
  }

  @override
  void didUpdateWidget(NodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    indent = (widget.avatarRadius * 2) - 5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPaint(
          painter: EdgeLine(
            isExpanded: _isExpanded,
            indent: indent,
            lineType: widget.theme.lineType ?? LineType.curved,
            avatarRadius: widget.avatarRadius,
            isFirst: widget.father == null,
            isLast: widget.isLastChild,
            hasChildren: widget.treeNode.children != null &&
                widget.treeNode.children!.isNotEmpty,
            hasBrothers: widget.father != null &&
                widget.father!.children != null &&
                widget.father!.children!.length > 1,
            pathColor: widget.theme.lineColor,
            strokeWidth: widget.theme.lineWidth,
          ),
          child: Container(
            padding: EdgeInsets.only(left: (indent / 2) - 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.expandNodes && !_isLeaf ? _onExpandNode : null,
                  child: CircleAvatar(
                    backgroundColor: widget.theme.nodeColor ?? Colors.blue,
                    radius: widget.avatarRadius,
                    backgroundImage: widget.treeNode.avatarPhoto != null
                        ? NetworkImage(widget.treeNode.avatarPhoto!)
                        : null,
                  ),
                ),
                widget.treeNode.content,
              ],
            ),
          ),
        ),
        CustomPaint(
          painter: RectLine(
            isNephew: !widget.isLastChild &&
                widget.father != null &&
                widget.father!.children != null &&
                widget.father!.children!.length > 1,
            pathColor: widget.theme.lineColor,
            strokeWidth: widget.theme.lineWidth,
          ),
          child: SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Padding(
              padding: EdgeInsets.only(left: indent),
              child: buildNodes(
                widget.treeNode,
                widget.treeNode.children ?? [],
                widget.avatarRadius,
                widget.state,
                widget.theme,
                widget.expandNodes,
              ),
            ),
          ),
        )
      ],
    );
  }
}
