package com.example.wanandroid

import android.os.Bundle
import android.os.Handler
import android.util.Log
import android.view.ViewGroup
import android.widget.Button
import com.example.wanandroid.channel.BasicMessageChannelPlugin
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
    private val TAG = "MainActivity"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val messenger = flutterEngine?.dartExecutor
        val basicMessageChannelPlugin = BasicMessageChannelPlugin.registerWith(messenger)

        Handler().postDelayed({
            basicMessageChannelPlugin.send("来自Android") {
                Log.d(TAG,"来自flutter 返回$it")
            }
        },3000)
    }
}
