package com.example.salons_app

import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity(){
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("95ba4d19-7582-41a3-9bc5-7eb560daf083")
        MapKitFactory.setLocale("ru_RU")
        super.configureFlutterEngine(flutterEngine)
    }
}
