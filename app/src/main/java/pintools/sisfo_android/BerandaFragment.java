package pintools.sisfo_android;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

public class BerandaFragment extends Fragment {

    private BerandaViewModel berandaViewModel;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        berandaViewModel =
                ViewModelProviders.of(this).get(BerandaViewModel.class);
        View root = inflater.inflate(R.layout.fragment_beranda, container, false);
        final TextView textView = root.findViewById(R.id.name_user);
        berandaViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                textView.setText(s);
            }
        });
        return root;
    }
}