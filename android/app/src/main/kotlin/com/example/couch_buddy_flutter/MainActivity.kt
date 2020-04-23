package com.example.couch_buddy_flutter

import androidx.annotation.NonNull
import github.showang.flutter_google_cast_button.FlutterGoogleCastButtonPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    override fun onResume() {
        super.onResume()
        FlutterGoogleCastButtonPlugin.instance?.onResume()
    }
}
