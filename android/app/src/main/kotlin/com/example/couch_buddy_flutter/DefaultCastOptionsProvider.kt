package com.example.couch_buddy_flutter

import android.content.Context
import com.google.android.gms.cast.CastMediaControlIntent
import com.google.android.gms.cast.MediaMetadata
import com.google.android.gms.cast.framework.CastOptions
import com.google.android.gms.cast.framework.OptionsProvider
import com.google.android.gms.cast.framework.SessionProvider
import com.google.android.gms.cast.framework.media.CastMediaOptions
import com.google.android.gms.cast.framework.media.ImagePicker
import com.google.android.gms.cast.framework.media.MediaIntentReceiver
import com.google.android.gms.cast.framework.media.NotificationOptions
import com.google.android.gms.common.images.WebImage

import com.example.couch_buddy_flutter.MainActivity

class DefaultCastOptionsProvider : OptionsProvider {
    override fun getCastOptions(context: Context): CastOptions {
        // Example showing 4 buttons: "rewind", "play/pause", "forward" and "stop
        // casting".
        val buttonActions = ArrayList<String>()
        buttonActions.add(MediaIntentReceiver.ACTION_REWIND)
        buttonActions.add(MediaIntentReceiver.ACTION_TOGGLE_PLAYBACK)
        buttonActions.add(MediaIntentReceiver.ACTION_FORWARD)
        buttonActions.add(MediaIntentReceiver.ACTION_STOP_CASTING)
        // Showing "play/pause" and "stop casting" in the compat view of the notification.
        val compatButtonActionsIndices: IntArray = intArrayOf(0, 1)
        // Builds a notification with the above actions. Each tap on the "rewind" and
        // "forward" buttons skips 30 seconds.
        // Tapping on the notification opens an Activity with class VideoBrowserActivity.
        val notificationOptions: NotificationOptions = NotificationOptions.Builder()
            .setActions(buttonActions, compatButtonActionsIndices)
            .setSkipStepMs(30 * 1000)
            .setTargetActivityClassName(MainActivity::class.java.name)
            .build()

        val mediaOptions: CastMediaOptions = CastMediaOptions.Builder()
            .setImagePicker(ImagePickerImpl())
            .setNotificationOptions(notificationOptions)
            .setExpandedControllerActivityClassName(MainActivity::class.java.name)
            .build()

        return CastOptions.Builder()
            .setReceiverApplicationId(CastMediaControlIntent.DEFAULT_MEDIA_RECEIVER_APPLICATION_ID)
            .setCastMediaOptions(mediaOptions)
            .build()
    }

    override fun getAdditionalSessionProviders(context: Context): List<SessionProvider>? {
        return null
    }

    private class ImagePickerImpl() : ImagePicker() {

        override fun onPickImage(mediaMetadata: MediaMetadata, type: Int) : WebImage? {
            if ((mediaMetadata == null) || !mediaMetadata.hasImages()) {
                return null
            }

            val images: List<WebImage> = mediaMetadata.getImages()

            if (images.size == 1) {
                return images.get(0)
            } else {
                if (type == ImagePicker.IMAGE_TYPE_MEDIA_ROUTE_CONTROLLER_DIALOG_BACKGROUND) {
                    return images.get(0)
                } else {
                    return images.get(1)
                }
            }
        }
    }
}