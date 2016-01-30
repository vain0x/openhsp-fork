package tv.hsp;

import android.app.NativeActivity;
import android.app.Activity;
import android.app.AlertDialog;

import android.content.pm.ActivityInfo;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.content.DialogInterface;
import android.content.ComponentName;

import android.net.Uri;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Paint.FontMetrics;
import android.graphics.Paint.Style;
import android.graphics.Typeface;

import android.os.AsyncTask;
import android.os.Vibrator;
import android.os.Bundle;
import android.util.Log;
import android.view.Display;
import android.view.Surface;
import android.view.WindowManager;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.view.ViewGroup.MarginLayoutParams;
import android.view.Gravity;
import android.view.View.OnClickListener;

import android.widget.Toast;
import android.widget.PopupWindow;
import android.widget.LinearLayout;
import android.widget.Button;
import android.widget.TextView;

import java.util.List;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Random;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.HttpVersion;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.util.EntityUtils;


public class HspActivity extends NativeActivity {

  // string code
  // public static final String CHAR_CODE = "Shift-JIS";
  public static final String CHAR_CODE = "UTF8";

  public String hello() {
    return "JNITest";
  }
  public String getInfo_Device() {
    return android.os.Build.DEVICE;
  }
  public String getInfo_Version() {
    return android.os.Build.VERSION.RELEASE;
  }
  public String getInfo_Locale() {
    return Locale.getDefault().getISO3Language();
  }
  public String getInfo_FilesDir() {
    File f=this.getApplicationContext().getFilesDir();
    String path=f.toString();
    return path;
  }

  // Nativeへの通知
  public native void nativepoke(int val, int val2);

  public int callVibrator( int val ) {
    Vibrator vibrator = (Vibrator)getSystemService(VIBRATOR_SERVICE);
    if (vibrator != null) vibrator.vibrate(val);
    return 0;
  }

  public int callNamedActivity( String msg1, String msg2, int mode ) {

    Intent shareIntent = new Intent(Intent.ACTION_SEND);
    shareIntent.setType("text/plain");
    shareIntent.putExtra(Intent.EXTRA_TEXT, msg2 );
    String appName = msg1; //"twitter";
    int res = -1;

    PackageManager pm = getPackageManager();
    List<?> activityList = pm.queryIntentActivities(shareIntent, 0);
    int len = activityList.size();
    for (int i = 0; i < len; i++) {
	ResolveInfo app = (ResolveInfo) activityList.get(i);
	if ((app.activityInfo.name.contains(appName))) {
		if ( mode > 0 ) {
			ActivityInfo activity = app.activityInfo;
			ComponentName name = new ComponentName(activity.applicationInfo.packageName, activity.name);
			shareIntent.setComponent(name);
			startActivity(shareIntent);
		}
		res = 0;
		break;
	}
    }
    return res;
  }


  public int callActivity( String msg1, String msg2, int type ) {
    if ( type == 16 ) {
    	Uri uri = Uri.parse( msg1 );
	Intent i = new Intent();
	i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
	i.setAction(Intent.ACTION_VIEW);
	i.setData(uri);
   	startActivity(i);
   	return 0;
    }

    if ( type == 48 ) {
	return callNamedActivity( msg1, msg2, 1 );
    }

    Intent intent = new Intent();
    intent.setClassName( msg1, msg2 );
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    startActivity(intent);
    return 0;
  }

    public int ui_dispDialog( String msg1, String msg2, int type ) {
	//	OKダイアログ
	final int addtype;
	final String s_msg1;
	final String s_msg2;
	final HspActivity myActivity;

	addtype = type;
	myActivity = this;
	s_msg1 = msg1;
	s_msg2 = msg2;

	this.runOnUiThread( new Runnable()
		{
	        @Override
	        public void run()
	        {
			AlertDialog.Builder alert = new AlertDialog.Builder(myActivity);
			// ダイアログ外で閉じた場合
			alert.setOnCancelListener(new DialogInterface.OnCancelListener()
			{
			@Override
			public void onCancel(DialogInterface dialog)
			{
				nativepoke( 0, 0 );
			}
			});

			alert.setMessage( s_msg1 );
			alert.setTitle( s_msg2 );
			if (( addtype & 1 ) > 0 ) {
				alert.setIcon(android.R.drawable.ic_dialog_alert);
			} else {
				alert.setIcon(android.R.drawable.ic_dialog_info);
			}
	        	alert.setPositiveButton( "OK", new DialogInterface.OnClickListener()
	        	{
			@Override
			public void onClick(DialogInterface dialog, int which)
			{
				nativepoke( 0, 1 );
			}
		    });
	        	alert.create().show();
	        }
	    } );

   	return 0;
    }

    public int ui_dispDialogYN( String msg1, String msg2, int type ) {
	//	YES/NOダイアログ
	final int addtype;
	final String s_msg1;
	final String s_msg2;
	final HspActivity myActivity;

	addtype = type;
	myActivity = this;
	s_msg1 = msg1;
	s_msg2 = msg2;

	this.runOnUiThread( new Runnable()
		{
	        @Override
	        public void run()
	        {
			AlertDialog.Builder alert = new AlertDialog.Builder(myActivity);
			// ダイアログ外で閉じた場合
			alert.setOnCancelListener(new DialogInterface.OnCancelListener()
			{
			@Override
			public void onCancel(DialogInterface dialog)
			{
				nativepoke( 0, 0 );
			}
			});

			alert.setMessage( s_msg1 );
			alert.setTitle( s_msg2 );
			if (( addtype & 1 ) > 0 ) {
				alert.setIcon(android.R.drawable.ic_dialog_alert);
			} else {
				alert.setIcon(android.R.drawable.ic_dialog_info);
			}
	        	alert.setPositiveButton( "Yes", new DialogInterface.OnClickListener()
	        	{
			@Override
			public void onClick(DialogInterface dialog, int which)
			{
				nativepoke( 0, 6 );
			}
		    });
	        	alert.setNegativeButton( "No", new DialogInterface.OnClickListener()
	        	{
	                @Override
	                public void onClick(DialogInterface dialog, int which)
	                {
	                	nativepoke( 0, 7 );
	                }
	            });

	        	alert.create().show();
	        }
	    } );

   	return 0;
    }

    public int dispDialog( String msg1, String msg2, int type ) {
	if ( type >= 4 ) return -1;
	if (( type & 2 ) > 0 ) {
		return ui_dispDialogYN( msg1, msg2, type );
	}
	return ui_dispDialog( msg1, msg2, type );
    }
    
    public int addWindowFlag( int type ) {
	final int addtype;
	if ( type == 1 ) {
		addtype = WindowManager.LayoutParams.FLAG_FULLSCREEN;
	} else {
		addtype = WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON;
	}
        this.runOnUiThread( new Runnable() {
    		public void run() 
                {
			getWindow().addFlags( addtype );
                }
        } );
   	return 0;
    }
    
    public int clearWindowFlag( int type ) {
	final int clrtype;
	if ( type == 1 ) {
		clrtype = WindowManager.LayoutParams.FLAG_FULLSCREEN;
	} else {
		clrtype = WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON;
	}
        this.runOnUiThread( new Runnable() {
	    	public void run() {
	        	getWindow().clearFlags( clrtype );
                }
        } );
   	return 0;
    }


	//	conversion ByteText->String
	public String ByteTextToString( byte[] byteText )
	{
		try {
			if( byteText == null ) return "";
			return new String(byteText, CHAR_CODE);
		}
		catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "";
		}
	}
	

	//	retrieve font text by bitmap data
	public Bitmap getFontBitmap( byte[] byteText, int fontsize, boolean bBold )
	{
		String text = ByteTextToString( byteText );

	        Paint paint = new Paint();
	        paint.setStyle(Paint.Style.FILL);
	        paint.setColor(Color.WHITE);
	        paint.setTextSize(fontsize);
	        paint.setAntiAlias(true);
	        paint.setSubpixelText(true);
	        paint.setTypeface( Typeface.create( Typeface.SANS_SERIF, ( bBold ) ? Typeface.BOLD : Typeface.NORMAL ) );

	        FontMetrics fontMetrics = paint.getFontMetrics();

	        int width = (int)Math.round(paint.measureText(text));
	        if (width <= 0) {
			width = (int)Math.round(paint.measureText("0"));
	       	}

	        int offsetY = (int)Math.ceil(-fontMetrics.top);
	        int height = offsetY + (int)(Math.ceil(fontMetrics.bottom));
	        Bitmap bitmap = Bitmap.createBitmap(width,height,Bitmap.Config.ALPHA_8);
	        Canvas canvas = new Canvas(bitmap);
	        canvas.drawText(text,0, offsetY,paint);
	        return bitmap;
	}

    //		http network task
    private String _httpResult;
    private ArrayList <NameValuePair> _httpParams;

    public String getHttpResult() {
	return _httpResult;
    }

    public int httpParamSet( String prm1, String prm2, int type ) {
	if ( type < 0 ) {
		return -1;
	}
	if ( type == 0 ) {
		_httpParams = new ArrayList <NameValuePair>();
		return 0;
	}
	_httpParams.add( new BasicNameValuePair( prm1, prm2 ) );
	return 0;
    }

    public int httpRequestGET( String url, String optstr, int type ) {

	DefaultHttpClient httpClient = new DefaultHttpClient();
	HttpParams params = httpClient.getParams();
	HttpConnectionParams.setConnectionTimeout( params, 5000 );
	HttpConnectionParams.setSoTimeout( params, 3000 );

	StringBuilder uri = new StringBuilder( url );
	HttpGet request = new HttpGet(uri.toString());
	HttpResponse httpResponse;
	_httpResult = "";
	try {
		httpResponse = httpClient.execute(request);
	} catch (Exception e) {
		return -1;
	}

	int status = httpResponse.getStatusLine().getStatusCode();
	try {
		_httpResult = EntityUtils.toString( httpResponse.getEntity(), "UTF-8" );
	} catch (Exception e) {
		return -1;
	}

	httpClient.getConnectionManager().shutdown();
	if ( status != HttpStatus.SC_OK ) {
		return status;
	}
	return 0;
    }

    public int httpRequestPOST( String url, String optstr, int type ) {

	DefaultHttpClient httpClient = new DefaultHttpClient();
	HttpParams params = httpClient.getParams();
	HttpConnectionParams.setConnectionTimeout( params, 5000 );
	HttpConnectionParams.setSoTimeout( params, 3000 );

	StringBuilder uri = new StringBuilder( url );
	HttpPost request = new HttpPost(uri.toString());
	HttpResponse httpResponse;
	_httpResult = "";
	try {
		request.setEntity( new UrlEncodedFormEntity( _httpParams, "UTF-8" ) );
		httpResponse = httpClient.execute(request);
	} catch (Exception e) {
		return -1;
	}

	int status = httpResponse.getStatusLine().getStatusCode();
	try {
		//_httpResult = EntityUtils.toString( httpResponse.getEntity(), "SHIFT-JIS" );
		_httpResult = EntityUtils.toString( httpResponse.getEntity(), "UTF-8" );
	} catch (Exception e) {
		return -1;
	}

	httpClient.getConnectionManager().shutdown();
	if ( status != HttpStatus.SC_OK ) {
		return status;
	}
	return 0;
    }


}

