import 'package:flutter/material.dart';
import 'package:podtop/src/models/podcast_search_result.dart';

class ViewSearchItem extends StatefulWidget {
  final bool initialState;
  final Result result;
  final VoidCallback onSubscribePressed;

  const ViewSearchItem({
    Key key,
    @required this.initialState,
    @required this.result,
    @required this.onSubscribePressed,
  }) : super(key: key);

  @override
  _ViewSearchItemState createState() => _ViewSearchItemState();
}

class _ViewSearchItemState extends State<ViewSearchItem> {
  bool isSubscribed;

  @override
  void initState() {
    super.initState();
    isSubscribed = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(widget.result.artworkUrl60),
      ),
      trailing: IconButton(
        icon: Icon(Icons.bookmark_border),
        onPressed: () {
          setState(() => isSubscribed = !isSubscribed);
          widget.onSubscribePressed();
        },
      ),
      title: Text(widget.result.artistName ?? ""),
      subtitle: Text(widget.result.artistViewUrl ?? ""),
    );
  }
}
