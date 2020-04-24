import 'package:flutter/material.dart';

class ReadMore extends StatefulWidget {
  final String text;

  ReadMore(this.text, { Key key }) : super(key: key);

  @override
  _ReadMoreState createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  bool expanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState: expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Text(
            widget.text,
            textAlign: TextAlign.left,
          ),
          secondChild: Text(
            widget.text,
            maxLines: 3,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.end,
          buttonPadding: EdgeInsets.zero,
          children: <Widget>[
            FlatButton.icon(
              label: Text(
                expanded ? 'Less' : 'More',
                style: Theme.of(context).textTheme.caption,
              ),
              icon: Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
                color: Theme.of(context).textTheme.caption.color
              ),
              onPressed: () => setState(() => expanded = !expanded),
            )
          ],
        )
      ],
    );
  }
}
