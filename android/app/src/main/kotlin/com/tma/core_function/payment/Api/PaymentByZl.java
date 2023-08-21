package com.tma.core_function.payment.Api;

import com.tma.core_function.payment.Helper.Helpers;
import com.tma.core_function.utils.AppUtils;

import org.json.JSONObject;

import java.util.Date;

import okhttp3.FormBody;
import okhttp3.RequestBody;
import vn.zalopay.sdk.Environment;
import vn.zalopay.sdk.ZaloPaySDK;

public class PaymentByZl {
    private static PaymentByZl instance;

    private static int appId;

    public static void setAppId(int appId) {
        PaymentByZl.appId = appId;
    }

    private static Environment environment;

    public static void setEnvironment(Environment environment) {
        PaymentByZl.environment = environment;
    }

    public static String mackey;


    public static void setMackey(String mackey) {
        PaymentByZl.mackey = mackey;
    }

    private static class ZlData {
        String AppId;
        String AppUser;
        String AppTime;
        String Amount;
        String AppTransId;
        String EmbedData;
        String Items;
        String BankCode;
        String Description;
        String Mac;

        private ZlData(String amount) throws Exception {
            long appTime = new Date().getTime();

            AppId = String.valueOf(appId);
            AppUser = "Android_Demo";
            AppTime = String.valueOf(appTime);
            Amount = amount;
            AppTransId = Helpers.getAppTransId();
            EmbedData = "{}";
            Items = "[]";
            BankCode = "sbi";
            Description = "Merchant pay for order #" + Helpers.getAppTransId();
            String inputHMac = String.format("%s|%s|%s|%s|%s|%s|%s",
                    this.AppId,
                    this.AppTransId,
                    this.AppUser,
                    this.Amount,
                    this.AppTime,
                    this.EmbedData,
                    this.Items);

            Mac = Helpers.getMac(mackey, inputHMac);
        }
    }


    public JSONObject createOrder(String amount) throws Exception {

        ZlData input = new ZlData(amount);

        RequestBody formBody = new FormBody.Builder()
                .add("app_id", input.AppId)
                .add("app_user", input.AppUser)
                .add("app_time", input.AppTime)
                .add("amount", input.Amount)
                .add("app_trans_id", input.AppTransId)
                .add("embed_data", input.EmbedData)
                .add("item", input.Items)
                .add("bank_code", input.BankCode)
                .add("description", input.Description)
                .add("mac", input.Mac)
                .build();


        JSONObject data = HttpProvider.getInstance().sendPost(getOrderLink(), formBody);
        return data;
    }

    private String getOrderLink() {
        if (environment == Environment.PRODUCTION) {
            return AppUtils.productionZaloCreateOrder;
        }
        return AppUtils.sbZaloCreateOrder;
    }

    public static PaymentByZl getInstance() {
        if (instance == null) {
            ZaloPaySDK.init(appId, environment);
            instance = new PaymentByZl();
        }
        return instance;
    }

}


