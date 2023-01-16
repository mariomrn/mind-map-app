import 'package:flutter/material.dart';

class RuleNode extends StatelessWidget {
  bool isActive = false;
  bool isMaximized = false;
  ValueNotifier<int?> selectedNode;
  Function setSelectedNode;
  int? nodeId;
  var myFocusNode;

  RuleNode(this.isActive, this.isMaximized, this.selectedNode,
      this.setSelectedNode, this.nodeId, this.myFocusNode);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      width: isMaximized ? 300 : 450,
      decoration: BoxDecoration(
          color: Colors.red.shade800,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(60),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              width: 20,
              height: 20,
              margin: EdgeInsets.only(right: 10),
              child: Center(
                child: Text('${this.nodeId}'),
              ),
            ),
          ),
          isActive
              ? Expanded(
                  flex: 5,
                  child: isMaximized
                      ? Text('Mensagem de boas-vindas')
                      : Text('min'))
              : const Expanded(flex: 5, child: Text('Not active')),
        ],
      ),
    );
  }
}
