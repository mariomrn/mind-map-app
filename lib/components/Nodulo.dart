import 'package:flutter/material.dart';

import 'nodes/ruleNode.dart';
import 'nodes/defNode.dart';
import 'nodes/tableNode.dart';
import 'NodeOptions.dart';

class Nodulo extends StatefulWidget {
  String? title;
  int? nodeId;
  ValueNotifier<int> selectedNode;
  final Function setSelectedNode;
  final createSon;
  final createBro;
  final controller;

  Nodulo(this.nodeId, this.title, this.selectedNode, this.setSelectedNode,
      this.createSon, this.createBro, this.controller);

  @override
  State<Nodulo> createState() => _NoduloState(nodeId, title, selectedNode,
      setSelectedNode, createSon, createBro, controller);
}

class _NoduloState extends State<Nodulo> {
  bool isActive = false;
  bool isMaximized = false;
  var isSelected = false;
  late FocusNode myFocusNode = new FocusNode();

  void handleFocus(value) {
    if (value == this.nodeId && isSelected == false) {
      isSelected = true;
    } else {
      isSelected = false;
    }
  }

  int? nodeId;
  String? title;
  ValueNotifier<int> selectedNode;
  final Function setSelectedNode;
  final createSon;
  final createBro;
  final controller;
  _NoduloState(this.nodeId, this.title, this.selectedNode, this.setSelectedNode,
      this.createSon, this.createBro, this.controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () {
        setState(() {
          if(isActive) {
            // if node is active switch between max and min option
            isMaximized ? isMaximized = false : isMaximized = true;
          } else {
            // if node is not active -> activate node
            isActive = true;
            // TODO: add all dependent nodes to the net
            //neue Söhne
            createSon();
          }
        });
      },

      child: ValueListenableBuilder(
        valueListenable: selectedNode,
        builder: (context, value, child) {
          handleFocus(value);
          return Row(children: [
            if (widget.nodeId! < 200)
                RuleNode(isActive, isMaximized, selectedNode, setSelectedNode,
                nodeId, myFocusNode),
          if (widget.nodeId! < 300 && widget.nodeId! > 199)
            DefNode(isSelected, selectedNode, setSelectedNode,
                nodeId, myFocusNode),
          if (widget.nodeId! > 300 )
            TableNode(isSelected, selectedNode, setSelectedNode,
                nodeId, myFocusNode),
            isSelected?
            NodeOptions(createSon, createBro, false)
                : Column(),
          ]);

        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setSelectedNode(nodeId);
    myFocusNode.requestFocus();
    //controller.value = Matrix4.identity();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }
}