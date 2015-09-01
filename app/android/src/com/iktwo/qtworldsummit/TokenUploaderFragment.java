package com.iktwo.qtworldsummit;

import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;

import org.mindrot.jbcrypt.BCrypt;

import java.util.ArrayList;

public class TokenUploaderFragment extends Fragment implements HttpAsyncRequest.AsyncResponse {
    private static final String TAG = TokenUploaderFragment.class.getSimpleName();
    private String mToken;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setRetainInstance(true);
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
    }

    public void uploadToken(String token) {
        mToken = token;
        new HashTask(this).execute(token);
    }

    public void hashFinish(String output) {
        Log.d(TAG, "hash finish " + output);
        if (mToken != null) {
            String url = URLs.SERVER_URL + "/adduser?id=" + mToken + "&hash=" + output;
            new HttpAsyncRequest(this).execute(url);
        }
    }

    @Override
    public void processFinish(ArrayList<String> output) {
        /// TODO: check output, if ok, set that token was uploaded properly, otherwise try again next time
        if (output != null && output.size() == 2) {
            Log.d(TAG, "1 - " + output.get(0));
            Log.d(TAG, "2 - " + output.get(1));

            if (output.get(1).equals("id registered")) {
                Log.d(TAG, "token uploaded :D");

                SharedPreferences prefs = getActivity().getSharedPreferences(QtWorldSummit.class.getSimpleName(), Context.MODE_PRIVATE);
                SharedPreferences.Editor editor = prefs.edit();
                editor.putBoolean(QtWorldSummit.UPLOADED_ID, true);
                editor.commit();
            }
        } else {
            /// Assume error in here
        }
    }

    private class HashTask extends AsyncTask<String, String, String> {
        private static final String TAG = "HashTask";
        TokenUploaderFragment requester = null;

        public HashTask(TokenUploaderFragment requester) {
            this.requester = requester;
        }

        @Override
        protected String doInBackground(String... params) {
            return BCrypt.hashpw(params[0] + "xdf8", BCrypt.gensalt(10));
        }

        @Override
        protected void onPostExecute(String reply) {
            requester.hashFinish(reply);
        }
    }
}
