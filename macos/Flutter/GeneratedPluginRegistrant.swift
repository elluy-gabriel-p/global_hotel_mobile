//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation


import screen_brightness_macos

import geolocator_apple
import shared_preferences_foundation
import sqflite
import wakelock_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {

  ScreenBrightnessMacosPlugin.register(with: registry.registrar(forPlugin: "ScreenBrightnessMacosPlugin"))

  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))

  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
  WakelockMacosPlugin.register(with: registry.registrar(forPlugin: "WakelockMacosPlugin"))
}
