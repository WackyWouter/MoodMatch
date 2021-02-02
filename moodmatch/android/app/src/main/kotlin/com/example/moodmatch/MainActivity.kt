package com.example.moodmatch

import android.app.Notification
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.app.NotificationManager;
import android.app.NotificationChannel;
import android.net.Uri;
import android.media.AudioAttributes;
import android.content.ContentResolver;
import android.graphics.BitmapFactory
import android.graphics.Color
import android.graphics.drawable.BitmapDrawable
import android.opengl.Visibility
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat


class MainActivity: FlutterActivity() {
    private val CHANNEL = "moodnotifications.com/channel_test" //The channel name you set in your main.dart file

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->

            if (call.method == "createNotificationChannel"){
                val argData = call.arguments as java.util.HashMap<String, String>
                val completed = createNotificationChannel(argData)
                if (completed == true){
                    result.success(completed)
                }
                else{
                    result.error("Error Code", "Error Message", null)
                }
            } else {
                result.notImplemented()
            }
        }

    }

    // https://developer.android.com/reference/android/app/NotificationChannel#setImportance(int)
    // https://developer.android.com/reference/android/app/NotificationChannel
    // https://rechor.medium.com/creating-notification-channels-in-flutter-android-e81e26b33bec
    // https://itnext.io/android-notification-channel-as-deep-as-possible-1a5b08538c87
    private fun createNotificationChannel(mapData: HashMap<String,String>): Boolean {
        val completed: Boolean
        if (VERSION.SDK_INT >= VERSION_CODES.O) {
            // Create the NotificationChannel
            val id = mapData["id"]
            val name = mapData["name"]
            val descriptionText = mapData["description"]
            val sound = mapData["soundname"]
            val importance = NotificationManager.IMPORTANCE_HIGH
            val mChannel = NotificationChannel(id, name, importance)
            mChannel.description = descriptionText

            val soundUri = Uri.parse(ContentResolver.SCHEME_ANDROID_RESOURCE + "://"+ getApplicationContext().getPackageName() + "/raw/"+mapData["soundname"]);
            val att = AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .setContentType(AudioAttributes.CONTENT_TYPE_SPEECH)
                    .build();

            mChannel.setSound(soundUri, att)
            mChannel.lightColor = Color.rgb(99,55,255);
            mChannel.enableLights(true);
            mChannel.vibrationPattern = longArrayOf(500L, 1000L);
            mChannel.enableVibration(true);
            mChannel.importance = NotificationManager.IMPORTANCE_HIGH;
            mChannel.shouldShowLights();
            mChannel.shouldVibrate();
            mChannel.lockscreenVisibility = Notification.VISIBILITY_PUBLIC;
            // Register the channel with the system; you can't change the importance
            // or other notification behaviors after this
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(mChannel)

            // TODO fix app icon
            // https://stackoverflow.com/questions/54056662/firebase-notification-is-grey-flutter
            // https://stackoverflow.com/questions/39828704/firebase-notification-always-shows-blank-icon
            // https://stackoverflow.com/questions/46676014/how-to-change-the-android-notification-icon-status-bar-icon-for-push-notificatio
//           https://stackoverflow.com/questions/28387602/notification-bar-icon-turns-white-in-android-5-lollipop
//            val builder = Notification.Builder(this, mapData["id"]).also {
//                it.setLargeIcon(BitmapFactory.decodeResource(resources,R.drawable.appicon36));
//                it.setSmallIcon(R.drawable.appicon36);
//
//            }
//            val notification = builder.build();
//            val notificationId = 0;
//
//            //notificationManager.notify(notificationId, notification);
            completed = true
        }
        else{
            completed = false
        }
        return completed
    }
}
