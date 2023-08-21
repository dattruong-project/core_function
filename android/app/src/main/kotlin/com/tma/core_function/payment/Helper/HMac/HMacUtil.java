package com.tma.core_function.payment.Helper.HMac;

import android.util.Log;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

public class HMacUtil {
    public final static String HMACSHA256 = "HmacSHA256";
    public final static String TAG = "HMacUtil";

    private static byte[] HMacEncode(final String algorithm, final String key, final String data) {
        Mac macGenerator = null;
        try {
            macGenerator = Mac.getInstance(algorithm);
            SecretKeySpec signingKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), algorithm);
            macGenerator.init(signingKey);
        } catch (Exception ex) {
            Log.d(TAG,"Can not generate Mac Generator");
        }

        if (macGenerator == null) {
            return null;
        }

        byte[] dataByte;
        dataByte = data.getBytes(StandardCharsets.UTF_8);

        return macGenerator.doFinal(dataByte);
    }

    public static String HMacHexStringEncode(final String algorithm, final String key, final String data) {
        byte[] hmacEncodeBytes = HMacEncode(algorithm, key, data);
        if (hmacEncodeBytes == null) {
            return null;
        }
        return HexStringUtil.byteArrayToHexString(hmacEncodeBytes);
    }
}
