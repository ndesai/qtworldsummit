package com.iktwo.qtworldsummit;

import java.io.IOException;

import android.app.Activity;
import android.app.FragmentManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.view.View;
import android.util.Log;
import android.graphics.Color;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Environment;
import android.os.Bundle;
import android.os.AsyncTask;
import android.net.Uri;
import android.util.Log;
import android.widget.Toast;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.gcm.GoogleCloudMessaging;

import com.iktwo.qtworldsummit.R;

public class QtWorldSummit extends org.qtproject.qt5.android.bindings.QtActivity {
    public static final String ACTION_MAIN = "MAIN";
    public static final String ACTION_SPONSOR = "SPONSOR";

    public static final String UPLOADED_ID = "uploaded_id";
    public static final String PROPERTY_REG_ID = "registration_id";
    
    private static QtWorldSummit m_instance;
    private static final String TAG = QtWorldSummit.class.getSimpleName();
    private static final String PROPERTY_APP_VERSION = "appVersion";
    private final static int PLAY_SERVICES_RESOLUTION_REQUEST = 9000;
    private static final String TAG_UPLOADER_FRAGMENT = "uploader_fragment";
    public static final String PUSH_NOTIFICATIONS_ID = "push_notifications_id";

    static boolean hasManagedAction = false;

    TokenUploaderFragment mTokenUploaderFragment;
    String regid;
    Context context;
    GoogleCloudMessaging gcm;

    @Override
    protected void onStart() {
        super.onStart();
        m_instance = this;
    }

    public static QtWorldSummit getInstance() {
        return m_instance;
    }

    public static boolean getNotificationsEnabled() {
        SharedPreferences prefs = m_instance.getSharedPreferences(QtWorldSummit.class.getSimpleName(), Context.MODE_PRIVATE);
        boolean result = prefs.getBoolean(PUSH_NOTIFICATIONS_ID, true);
        Log.d(TAG, "getNotificationsEnabled: " + Boolean.toString(result));
        return result;
    }

    public static void setNotificationsEnabled(boolean enabled) {
        Log.d(TAG, "setNotificationsEnabled: " + Boolean.toString(enabled));
        SharedPreferences prefs = m_instance.getSharedPreferences(QtWorldSummit.class.getSimpleName(), Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = prefs.edit();

        editor.putBoolean(PUSH_NOTIFICATIONS_ID, enabled);
        editor.commit();
    }

    public QtWorldSummit() {
        m_instance = this;
    }

    public static void setStatusBarColor(final int r, final int g, final int b) {
        if (m_instance != null)
        m_instance.runOnUiThread(new Runnable() {
                                    public void run() {
                                         if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP)
                                            m_instance.getWindow().setStatusBarColor(Color.rgb(r, g, b));
                                    }
                                });
    }

    private static int getAppVersion(Context context) {
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
            return packageInfo.versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            // should never happen
            throw new RuntimeException("Could not get package name: " + e);
        }
    }

    public static void toast(final String message) {
        m_instance.runOnUiThread(new Runnable() {
            public void run() {
                Toast.makeText(m_instance.getApplicationContext(), message, Toast.LENGTH_SHORT).show();
            }
        });
    }

    private boolean checkPlayServices() {
        int resultCode = GooglePlayServicesUtil.isGooglePlayServicesAvailable(this);
        if (resultCode != ConnectionResult.SUCCESS) {
            if (GooglePlayServicesUtil.isUserRecoverableError(resultCode)) {
                GooglePlayServicesUtil.getErrorDialog(resultCode, this,
                        PLAY_SERVICES_RESOLUTION_REQUEST).show();
            } else {
                Log.i(TAG, "This device is not supported.");
                finish();
            }
            return false;
        }
        return true;
    }

    private String getRegistrationId(Context context) {
        final SharedPreferences prefs = getGCMPreferences(context);
        String registrationId = prefs.getString(PROPERTY_REG_ID, "");

        if (registrationId.isEmpty()) {
            Log.i(TAG, "Registration not found.");
            return "";
        }

        // Check if app was updated; if so, it must clear the registration ID
        // since the existing regID is not guaranteed to work with the new
        // app version.
        int registeredVersion = prefs.getInt(PROPERTY_APP_VERSION, Integer.MIN_VALUE);
        int currentVersion = getAppVersion(context);

        if (registeredVersion != currentVersion) {
             SharedPreferences settingsPrefs = getSharedPreferences(QtWorldSummit.class.getSimpleName(), Context.MODE_PRIVATE);
             SharedPreferences.Editor editor = settingsPrefs.edit();
             editor.putBoolean(QtWorldSummit.UPLOADED_ID, false);
             editor.commit();

            Log.i(TAG, "App version changed.");
            return "";
        }
            return registrationId;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (getIntent().getAction() != null && getIntent().getAction().equals(ACTION_SPONSOR) && !hasManagedAction) {
          /// TODO: display ad
          hasManagedAction = true;
        }

        FragmentManager fm = getFragmentManager();

        mTokenUploaderFragment = (TokenUploaderFragment) fm.findFragmentByTag(TAG_UPLOADER_FRAGMENT);
        if (mTokenUploaderFragment == null) {
            mTokenUploaderFragment = new TokenUploaderFragment();
            fm.beginTransaction().add(mTokenUploaderFragment, TAG_UPLOADER_FRAGMENT).commit();
        }

        context = getApplicationContext();

        if (checkPlayServices()) {
            gcm = GoogleCloudMessaging.getInstance(this);
            regid = getRegistrationId(context);

            if (regid.isEmpty()) {
                registerInBackground();
            } else {
                 SharedPreferences prefs = getSharedPreferences(QtWorldSummit.class.getSimpleName(), Context.MODE_PRIVATE);
                 boolean uploaded = prefs.getBoolean(QtWorldSummit.UPLOADED_ID, false);

                 if (!uploaded)
                    sendRegistrationIdToBackend();
            }
        } else {
            Log.d(TAG, "Google Services is needed to show notifications");
            /// TODO show toast, finish app
        }
    }

    @Override
    protected void onNewIntent(Intent intent) {
      super.onNewIntent(intent);

      String action = intent.getAction();

      FragmentManager fragmentManager = getFragmentManager();

      if (action.equals(ACTION_MAIN)) {

      } else if (action.equals(ACTION_SPONSOR)) {
          /// TODO: display ad
      }
    }

    private void registerInBackground() {
        new AsyncTask<Void, Void, String>() {
            @Override
            protected String doInBackground(Void... params) {
                String msg = "";
                try {
                    if (gcm == null) {
                        gcm = GoogleCloudMessaging.getInstance(context);
                    }

                    regid = gcm.register(URLs.SENDER_ID);
                    msg = "Device registered, registration ID=" + regid;

                    // You should send the registration ID to your server over HTTP,
                    // so it can use GCM/HTTP or CCS to send messages to your app.
                    // The request to your server should be authenticated if your app
                    // is using accounts.
                    sendRegistrationIdToBackend();

                    // For this demo: we don't need to send it because the device
                    // will send upstream messages to a server that echo back the
                    // message using the 'from' address in the message.

                    // Persist the regID - no need to register again.
                    storeRegistrationId(context, regid);
                } catch (IOException ex) {
                    msg = "Error: " + ex.getMessage();
                    // If there is an error, don't just keep trying to register.
                    // Require the user to click a button again, or perform
                    // exponential back-off.
                }
                    return msg;
                }

                @Override
                protected void onPostExecute(String msg) {
                    Log.d(TAG, msg);
                    // mDisplay.append(msg + "\n");
                }
            }.execute(null, null, null);
    }

    private void sendRegistrationIdToBackend() {
        mTokenUploaderFragment.uploadToken(regid);
    }

    private SharedPreferences getGCMPreferences(Context context) {
        // This sample app persists the registration ID in shared preferences, but
        // how you store the regID in your app is up to you.
        return getSharedPreferences(QtWorldSummit.class.getSimpleName(), Context.MODE_PRIVATE);
    }

    private void storeRegistrationId(Context context, String regId) {
        final SharedPreferences prefs = getGCMPreferences(context);
        int appVersion = getAppVersion(context);
        Log.i(TAG, "Saving regId on app version " + appVersion);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString(PROPERTY_REG_ID, regId);
        editor.putInt(PROPERTY_APP_VERSION, appVersion);
        editor.commit();
    }
}
