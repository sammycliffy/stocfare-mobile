package com.stockfare;
import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
import com.facebook.FacebookSdk;



public class MyApplication extends FlutterApplication implements PluginRegistrantCallback {
    
    public void onCreate() {
        super.onCreate();
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    
    public void registerWith(PluginRegistry registry) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
        
   
    }
}
