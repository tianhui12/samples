package io.flutter.plugins;

import android.app.Application;

import com.growingio.android.analytics.firebase.FirebaseAnalyticsLibraryModule;
import com.growingio.android.flutter.FlutterLibraryGioModule;
import com.growingio.android.sdk.autotrack.CdpAutotrackConfiguration;
import com.growingio.android.sdk.autotrack.GrowingAutotracker;

public class MyApplication extends Application {
  @Override
  public void onCreate() {
    super.onCreate();

    CdpAutotrackConfiguration sConfiguration = new CdpAutotrackConfiguration("bc675c65b3b0290e", "growing.ff8a70351000af43")
      // .setDataCollectionServerHost("http://117.50.84.75:8080")
      .setDataSourceId("a29a3efe62384045")
      .setDebugEnabled(true)
//      .setDataCollectionEnabled(false) //合规场景使用，用户同意采集后开启
      .addPreloadComponent(new FirebaseAnalyticsLibraryModule())
      .addPreloadComponent(new FlutterLibraryGioModule())
      ;
    GrowingAutotracker.startWithConfiguration(this,sConfiguration);

  }

}
