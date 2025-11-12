package com.rafaelmees.pokemon_app

import android.os.Bundle
import android.os.PersistableBundle
import android.os.Build
import android.os.Parcelable
import android.os.Bundle as AndroidBundle
import androidx.annotation.NonNull
import com.google.firebase.FirebaseApp
import com.google.firebase.analytics.FirebaseAnalytics
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle as BundleAlias

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.rafaelmees.pokemon_app/analytics"
    private var firebaseAnalytics: FirebaseAnalytics? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        FirebaseApp.initializeApp(this)
        firebaseAnalytics = FirebaseAnalytics.getInstance(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "logEvent" -> {
                    try {
                        val args = call.arguments as? Map<*, *>
                        val name = args?.get("name") as? String
                        val params = args?.get("params") as? Map<*, *>
                        if (name == null) {
                            result.error("INVALID_ARGUMENT", "Event name is null", null)
                            return@setMethodCallHandler
                        }
                        logFirebaseEvent(name, params)
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("NATIVE_ERROR", e.localizedMessage, null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun logFirebaseEvent(name: String, params: Map<*, *>?) {
        val bundle = android.os.Bundle()
        params?.forEach { (key, value) ->
            if (key !is String) return@forEach
            when (value) {
                is String -> bundle.putString(key, value)
                is Int -> bundle.putInt(key, value)
                is Long -> bundle.putLong(key, value)
                is Double -> bundle.putDouble(key, value)
                is Float -> bundle.putFloat(key, value)
                is Boolean -> bundle.putBoolean(key, value)
                else -> {
                    // fallback: convert to string
                    bundle.putString(key, value?.toString())
                }
            }
        }
        firebaseAnalytics?.logEvent(name, bundle)
    }
}
