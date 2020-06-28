package pintools.sisfo_android;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.material.textfield.TextInputEditText;

import org.jetbrains.annotations.NotNull;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import pintools.sisfo_android.R;

public class LoginActivity extends AppCompatActivity {

    private TextInputEditText id, password;
    private Button btn_login;
    private TextView need_help, forgot_pass;
    private ProgressBar loading;
    private static String URL_LOGIN = "http://192.168.1.3/android_register_login/login.php";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        loading = findViewById(R.id.loading);
        id = findViewById(R.id.id);
        password = findViewById(R.id.password);
        btn_login = findViewById(R.id.btn_login);
        need_help = findViewById(R.id.need_help);
        forgot_pass = findViewById(R.id.forgot_pass);

        btn_login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String mId = id.getText().toString().trim();
                String mPass = password.getText().toString().trim();

                if (!mId.isEmpty() || !mPass.isEmpty()){
                    Login(mId, mPass);
                } else {
                    id.setError("Please insert your ID");
                    password.setError("Please insert your password");
                }
            }
        });
        need_help.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                startActivity(new Intent(LoginActivity.this, needHelpActivity.class));
                Toast.makeText(LoginActivity.this, "Need Help?", Toast.LENGTH_SHORT).show();
            }
        });
        forgot_pass.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                startActivity(new Intent(LoginActivity.this, forgotPassActivity.class));
                Toast.makeText(LoginActivity.this, "Forgot Password?", Toast.LENGTH_SHORT).show();
            }
        });
    }

    private void Login(final String id, final String password) {

        loading.setVisibility(View.VISIBLE);
        btn_login.setVisibility(View.GONE);

        StringRequest stringRequest = new StringRequest(Request.Method.POST, URL_LOGIN,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                            Log.d("JSONR", response);
                        try {
                        JSONObject jsonObject = new JSONObject(response);
                            System.out.println("JSON RESPONSE: " + jsonObject);
                        String success = jsonObject.getString("success");
                            JSONArray jsonArray = jsonObject.getJSONArray("login");
                            Toast.makeText(LoginActivity.this, "data"+response, Toast.LENGTH_SHORT).show();
                            if (success.equals("1")){

                                for (int i=0; i<jsonArray.length(); i++ ){
                                    JSONObject object = jsonArray.getJSONObject(i);

                                    String id = object.getString("id").trim();
                                    String level = object.getString("level").trim();

                                    Toast.makeText(LoginActivity.this,
                                            "Success Login. \nYour ID : "
                                                    +id+"\nYour level : "+
                                                    level, Toast.LENGTH_SHORT)
                                            .show();
                                    loading.setVisibility(View.GONE);

                                }
                            }

                        } catch (JSONException e) {
                            e.printStackTrace();
                            loading.setVisibility(View.GONE);
                            btn_login.setVisibility(View.VISIBLE);;
                            Toast.makeText(LoginActivity.this, "Error "+e.toString(), Toast.LENGTH_SHORT).show();
                        }
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        loading.setVisibility(View.GONE);
                        btn_login.setVisibility(View.VISIBLE);
                        Toast.makeText(LoginActivity.this, "Error " +error.toString(), Toast.LENGTH_SHORT).show();
                    }
                })
        {
            @NotNull
            @Override
            protected Map <String, String> getParams () throws AuthFailureError {
                Map <String, String> params = new HashMap <> ();
                params.put ("id", id);
                params.put ("password", password);
                return params;
            }
        };

        RequestQueue requestQueue = Volley.newRequestQueue(this);
        requestQueue.add(stringRequest);
    }
}
