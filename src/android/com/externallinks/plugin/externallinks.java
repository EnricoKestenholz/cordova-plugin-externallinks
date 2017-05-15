package com.externallinks.plugin;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import android.content.Context;
import android.widget.Toast;

public class externallinks extends CordovaPlugin {
		@Override
		public WebResourceResponse shouldInterceptRequest(WebView view, String url) {
		try {
		    // Check the against the white-list.
		    if ((url.startsWith("http:") || url.startsWith("https:")) && !Config.isUrlWhiteListed(url)) {
		        LOG.w(TAG, "URL blocked by whitelist: " + url);
		        // Results in a 404.
		        return new WebResourceResponse("text/plain", "UTF-8", null);
		    }

		    CordovaResourceApi resourceApi = appView.getResourceApi();
		    Uri origUri = Uri.parse(url);
		    // Allow plugins to intercept WebView requests.
		    Uri remappedUri = resourceApi.remapUri(origUri);
		    if (!origUri.equals(remappedUri) || needsSpecialsInAssetUrlFix(origUri)) {
		        OpenForReadResult result = resourceApi.openForRead(remappedUri, true);
		        return new WebResourceResponse(result.mimeType, "UTF-8", result.inputStream);
		    }
		    // If we don't need to special-case the request, let the browser load it.
		    return null;
		} catch (IOException e) {
		    if (!(e instanceof FileNotFoundException)) {
		        LOG.e("IceCreamCordovaWebViewClient", "Error occurred while loading a file (returning a 404).", e);
		    }
		    // Results in a 404.
		    return new WebResourceResponse("text/plain", "UTF-8", null);
		}
		}


}