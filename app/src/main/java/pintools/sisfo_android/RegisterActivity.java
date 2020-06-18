package pintools.sisfo_android;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;

import java.util.Map;

import poloan.sisfo_android.R;

public class RegisterActivity extends AppCompatActivity {

    private EditText name,email,pass,passConfirm;
    private Button btn_register;
    private ProgressBar loading;
    private static String URL_REGIST = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registry);

        loading = findViewById(R.id.loading);
        name = findViewById(R.id.name);
        email = findViewById(R.id.email);
        pass = findViewById(R.id.pass);
        passConfirm = findViewById(R.id.passConfirm);

        btn_register.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
    }

    private void Register(){
        loading.setVisibility(View.VISIBLE);
        btn_register.setVisibility(View.GONE);

        final String name = this.name.getText().toString().trim();
        final String email = this.email.getText().toString().trim();
        final String pass = this.pass.getText().toString().trim();

        StringRequest stringRequest = new StringRequest(Request.Method.POST, URL_REGIST,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {

                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {

                    }
                })
        {
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                return super.getParams();
            }
        };
    }
}
