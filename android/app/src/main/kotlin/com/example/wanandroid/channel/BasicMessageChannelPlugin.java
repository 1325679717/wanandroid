package com.example.wanandroid.channel;

import android.app.Activity;

import io.flutter.embedding.android.FlutterView;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StringCodec;


//这里支持的数据类型为String。
public class BasicMessageChannelPlugin implements BasicMessageChannel.MessageHandler<String> {

    private BasicMessageChannel<String> messageChannel;

    public static BasicMessageChannelPlugin registerWith(BinaryMessenger messenger) {
        return new BasicMessageChannelPlugin(messenger);
    }

    private BasicMessageChannelPlugin(BinaryMessenger flutterView) {
        this.messageChannel = new BasicMessageChannel<String>(flutterView, "BasicMessageChannelPlugin", StringCodec.INSTANCE);
        messageChannel.setMessageHandler(this);
    }


    @Override
    public void onMessage(String s, BasicMessageChannel.Reply<String> reply) {
        reply.reply("BasicMessageChannelPlugin收到：" + s);

    }

    public void send(String str, BasicMessageChannel.Reply<String> reply) {
        messageChannel.send(str, reply);
    }
}
