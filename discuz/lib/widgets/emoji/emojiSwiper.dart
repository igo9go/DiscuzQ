import 'package:cached_network_image/cached_network_image.dart';
import 'package:discuzq/models/emojiModel.dart';
import 'package:discuzq/widgets/emoji/emojiSync.dart';
import 'package:flutter/material.dart';

class EmojiSwiper extends StatefulWidget {
  ///
  /// 请求插入表情
  /// onInsert(EmojiModel emoji) => null
  final Function onInsert;

  EmojiSwiper({this.onInsert});
  @override
  _EmojiSwiperState createState() => _EmojiSwiperState();
}

class _EmojiSwiperState extends State<EmojiSwiper> {
  ///
  /// states
  /// Emoji list
  List<EmojiModel> _emojis = [];

  @override
  void setState(fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) async {
      List<EmojiModel> emojis = await EmojiSync.getEmojis(
        context: context,
      );

      if (emojis.length > 0) {
        setState(() {
          _emojis = emojis;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Wrap(
              children: _emojis
                  .map((e) => IconButton(
                        icon: CachedNetworkImage(
                          imageUrl: e.attributes.url,
                        ),
                        onPressed: () {
                          if(widget.onInsert == null){
                            return;
                          }

                          widget.onInsert(e);
                        },
                      ))
                  .toList(),
            ),
          ),
        ));
  }
}