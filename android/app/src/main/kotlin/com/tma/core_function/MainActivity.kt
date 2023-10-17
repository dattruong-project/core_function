package com.tma.core_function

import android.content.Intent
import com.tma.core_function.utils.AppUtils
import com.tma.core_function.payment.Api.PaymentByZl
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import vn.zalopay.sdk.Environment
import vn.zalopay.sdk.ZaloPayError
import vn.zalopay.sdk.ZaloPaySDK
import vn.zalopay.sdk.listeners.PayOrderListener


class MainActivity : FlutterActivity() {

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        ZaloPaySDK.getInstance().onResult(intent)
    }

    private var methodChannelResult: MethodChannel.Result? = null

    private val urlScheme = "payment://core"

    private fun getEnvironment(env: String): Environment {
        return if (env == "sandbox") {
            Environment.SANDBOX
        } else Environment.PRODUCTION
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            AppUtils.payment_events
        ).setMethodCallHandler { call, result ->
            kotlin.run {
                call.argument<Int>(AppUtils.zaloParamsAppId).let {
                    PaymentByZl.setAppId(it!!)
                }
                call.argument<String>(AppUtils.zaloParamsEnv).let {
                    PaymentByZl.setEnvironment(getEnvironment(it!!))
                }
                call.argument<String>(AppUtils.zaloParamsMackey).let{
                    PaymentByZl.setMackey(it!!)
                }
            }
            methodChannelResult = result
            when (call.method) {
                AppUtils.zaloPayMethod -> {
                    val orderInfo: JSONObject = PaymentByZl.getInstance().createOrder(call.argument(AppUtils.amount))

                    val token = orderInfo.getString("zp_trans_token")
                    ZaloPaySDK.getInstance()
                        .payOrder(this, token, urlScheme, object : PayOrderListener {
                            override fun onPaymentSucceeded(p0: String?, p1: String?, p2: String?) {
                                result.success(1)
                            }

                            override fun onPaymentCanceled(p0: String?, p1: String?) {
                                result.success(0)
                            }

                            override fun onPaymentError(
                                err: ZaloPayError?,
                                p1: String?,
                                p2: String?
                            ) {
                                err?.let {
                                    ZaloPaySDK.getInstance()
                                        .navigateToZaloPayOnStore(context);
                                } ?: run {
                                    result.success(0)
                                }
                            }

                        })
                }

            }
        }
    }


}
