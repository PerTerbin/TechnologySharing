package com.didichuxing.doraemonkit.kit.gpsmock;

import android.annotation.SuppressLint;
import android.content.Context;
import android.location.Location;
import android.location.LocationManager;
import android.os.IBinder;

import com.didichuxing.doraemonkit.util.LogHelper;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.util.Map;

/**
 * Created by wanglikun on 2018/12/18.
 */

public class GpsHookManager {
    private static final String TAG = "GpsHookManager";

    private Location mLocation;

    private boolean isMockEnable;
    private boolean isMocking;

    public Location getLocation() {
        return mLocation;
    }

    private static class Holder {
        private static GpsHookManager INSTANCE = new GpsHookManager();
    }

    public static GpsHookManager getInstance() {
        return Holder.INSTANCE;
    }

    private GpsHookManager() {
        mLocation = new Location(LocationManager.GPS_PROVIDER);
    }

    public void mockLocation(double latitude, double longitude) {
        mLocation.setLatitude(latitude);
        mLocation.setLongitude(longitude);
    }

    @SuppressLint("PrivateApi")
    @SuppressWarnings("unchecked")
    public void init() {
        try {
            Class serviceManager = Class.forName("android.os.ServiceManager");
            Method getService = serviceManager.getDeclaredMethod("getService", String.class);
            IBinder binder = (IBinder) getService.invoke(null, Context.LOCATION_SERVICE);

            ClassLoader classLoader = binder.getClass().getClassLoader();
            Class[] interfaces = {IBinder.class};
            BinderHookHandler handler = new BinderHookHandler(binder);
            IBinder proxy = (IBinder) Proxy.newProxyInstance(classLoader, interfaces, handler);

            Field sCache = serviceManager.getDeclaredField("sCache");
            sCache.setAccessible(true);
            Map<String, IBinder> cache = (Map<String, IBinder>) sCache.get(null);

            cache.put(Context.LOCATION_SERVICE, proxy);
            sCache.setAccessible(false);
            isMockEnable = true;
        } catch (Exception e) {
            LogHelper.e(TAG, e.toString());
            isMockEnable = false;
        }
    }


    public void startMock() {
        this.isMocking = true;
    }

    public void stopMock() {
        this.isMocking = false;
    }

    public boolean isMocking() {
        return isMocking;
    }

    public boolean isMockEnable() {
        return isMockEnable;
    }
}