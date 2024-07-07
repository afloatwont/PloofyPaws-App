package com.ploofypaws

import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

import io.radar.sdk.Radar

class Application : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {

  override fun onCreate() {
      super.onCreate()
      Radar.initialize(this, "prj_test_pk_44e2f013c8ef77e406660f4f6dcbf30878d94dab")
  }

  override fun registerWith(registry: PluginRegistry) {
      GeneratedPluginRegistrant.registerWith(FlutterEngine(this))
  }
}
