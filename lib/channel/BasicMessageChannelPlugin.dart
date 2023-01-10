import 'package:flutter/services.dart';

class BasicMessageChannelPlugin{

  final BasicMessageChannel<String> _basicMessageChannel =
  const BasicMessageChannel("BasicMessageChannelPlugin", StringCodec());

}