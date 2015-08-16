package com.iktwo.qtworldsummit;

import android.app.Activity;
import android.content.Intent;
import android.view.View;
import android.util.Log;
import android.graphics.Color;
import android.os.Build;
import android.os.Build.VERSION;

public class QtWorldSummit extends org.qtproject.qt5.android.bindings.QtActivity {
    private static QtWorldSummit m_instance;

    @Override
    protected void onStart() {
        super.onStart();
        m_instance = this;
    }

    public static QtWorldSummit getInstance() {
        return m_instance;
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
}
