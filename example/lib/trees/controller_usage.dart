// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

/// Demonstrates how to change state of the tree in external event handlers,
/// like button taps.
class ControllerUsage extends StatefulWidget {
  @override
  _ControllerUsageState createState() => _ControllerUsageState();
}

class _ControllerUsageState extends State<ControllerUsage> {
  final Key _key = ValueKey(22);
  final TreeController _controller = TreeController(allNodesExpanded: true);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            ElevatedButton(
              child: Text("Expand All"),
              onPressed: () => setState(() {
                _controller.expandAll();
              }),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              child: Text("Collapse All"),
              onPressed: () => setState(() {
                _controller.collapseAll();
              }),
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
              child: Text("Expand node 2.2"),
              onPressed: () => setState(() {
                _controller.expandNode(_key);
              }),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              child: Text("Collapse node 2.2"),
              onPressed: () => setState(() {
                _controller.collapseNode(_key);
              }),
            ),
          ],
        ),
        SizedBox(
          child: buildTree(),
        ),
      ],
    );
  }

  Widget buildTree() {
    return TreeView(
      treeController: _controller,
      expandNodes: true,
      theme: TreeTheme(
        lineWidth: 2.0,
        lineType: LineType.curved,
        lineColor: Colors.green,
        nodeColor: Colors.red,
      ),
      avatarRadius: 20.0,
      nodes: [
        TreeNode(
          content: Container(
            padding: EdgeInsets.only(
              left: 5,
              top: 10,
              bottom: 20,
            ),
            child: Text("node 1"),
          ),
        ),
        TreeNode(
          content: Container(
            padding: EdgeInsets.only(
              left: 5,
              top: 10,
              bottom: 20,
            ),
            child: Text("node 2"),
          ),
          children: [
            TreeNode(
              content: Container(
                constraints: BoxConstraints(maxWidth: 500),
                padding: EdgeInsets.only(
                  left: 5,
                  top: 10,
                  bottom: 20,
                ),
                child: Text(
                  "node 2.1",
                ),
              ),
              children: [
                TreeNode(
                  content: Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 10,
                      bottom: 20,
                    ),
                    child: Text("node 2.1.1"),
                  ),
                )
              ],
            ),
            TreeNode(
              content: Container(
                padding: EdgeInsets.only(
                  left: 5,
                  top: 10,
                  bottom: 20,
                ),
                child: Text("node 2.2"),
              ),
              key: _key,
              children: [
                TreeNode(
                  content: Container(
                    constraints: BoxConstraints(maxWidth: 500),
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 10,
                      bottom: 20,
                    ),
                    child: Text(
                      "node 2.2.1",
                    ),
                  ),
                ),
                TreeNode(
                  content: Container(
                    constraints: BoxConstraints(maxWidth: 500),
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 10,
                      bottom: 20,
                    ),
                    child: Text(
                      "node 2.2.2",
                    ),
                  ),
                  children: [
                    TreeNode(
                      content: Container(
                        padding: EdgeInsets.only(
                          left: 5,
                          top: 10,
                          bottom: 20,
                        ),
                        child: Text("node 2.2.2.1"),
                      ),
                      children: [
                        TreeNode(
                          content: Container(
                            padding: EdgeInsets.only(
                              left: 5,
                              top: 10,
                              bottom: 20,
                            ),
                            child: Text("node 2.2.2.1.1"),
                          ),
                        ),
                      ],
                    ),
                    TreeNode(
                      content: Container(
                        padding: EdgeInsets.only(
                          left: 5,
                          top: 10,
                          bottom: 20,
                        ),
                        child: Text("node 2.2.2.3"),
                      ),
                      children: [
                        TreeNode(
                          content: Container(
                            padding: EdgeInsets.only(
                              left: 5,
                              top: 10,
                              bottom: 20,
                            ),
                            child: Text("node 2.2.2.3.1"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            TreeNode(
              content: Container(
                padding: EdgeInsets.only(
                  left: 5,
                  top: 10,
                  bottom: 20,
                ),
                child: Text("node 3"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
