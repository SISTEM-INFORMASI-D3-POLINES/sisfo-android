package pintools.sisfo_android;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;


import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProviders;

import com.google.gson.annotations.SerializedName;
import com.squareup.picasso.Picasso;

import org.w3c.dom.Text;

import java.time.Year;
import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import retrofit2.http.GET;


public class CariFragment extends Fragment {
    private static final String BASE_URL = "http://192.168.1.3";
    private static final String FULL_URL = BASE_URL+"/android_register_login/";

    interface MyAPIService {

        @GET("/PHP/cari_alat/tools")
        Call<List<CariViewModel>> getTools();
    }

    static class RetrofitClientInstance {
        private static Retrofit retrofit;

        public static Retrofit getRetrofitInstance() {
            if (retrofit == null) {
                retrofit = new Retrofit.Builder()
                        .baseUrl(BASE_URL)
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
            }
            return retrofit;
        }
    }

    class FilterHelper extends Filter {
        private List<CariViewModel> currentList;
        private ListViewAdapter adapter;
        private Context c;

        public FilterHelper(List<CariViewModel> currentList, ListViewAdapter adapter, Context c) {
            this.currentList = currentList;
            this.adapter = adapter;
            this.c=c;
        }

        //filtering

        @Override
        protected FilterResults performFiltering(CharSequence constraint) {
            FilterResults filterResults=new FilterResults();

            if(constraint != null && constraint.length()>0)
            {
                //CHANGE TO UPPER
                constraint=constraint.toString().toUpperCase();

                //HOLD FILTERS WE FIND
                ArrayList<CariViewModel> foundFilters=new ArrayList<>();

                CariViewModel tools=null;

                //ITERATE CURRENT LIST
                for (int i=0;i<currentList.size();i++)
                {
                    tools= currentList.get(i);

                    //SEARCH
                    if(tools.getNama_tools().toUpperCase().contains(constraint) )
                    {
                        //ADD IF FOUND
                        foundFilters.add(tools);
                    }
                }

                //SET RESULTS TO FILTER LIST
                filterResults.count=foundFilters.size();
                filterResults.values=foundFilters;
            }else
            {
                //NO ITEM FOUND.LIST REMAINS INTACT
                filterResults.count=currentList.size();
                filterResults.values=currentList;
            }

            //RETURN RESULTS
            return filterResults;
        }

        @Override
        protected void publishResults(CharSequence charSequence, FilterResults filterResults) {
            adapter.setTools((ArrayList<CariViewModel>) filterResults.values);
            adapter.refresh();

        }
    }
    class ListViewAdapter extends BaseAdapter implements Filterable {

        private List<CariViewModel> tools;
        private Context context;
        private List<CariViewModel> currentList;
        private FilterHelper filterHelper;

        public ListViewAdapter(Context context,List<CariViewModel> tools){
            this.context = context;
            this.tools = tools;
            this.currentList=tools;
        }



        @Override
        public int getCount() {
            return tools.size();
        }

        @Override
        public Object getItem(int pos) {
            return tools.get(pos);
        }

        @Override
        public long getItemId(int pos) {
            return pos;
        }

        @Override
        public View getView(int position, View view, ViewGroup viewGroup) {
            if(view==null)
            {
                view= LayoutInflater.from(context).inflate(R.layout.cari_list_row,viewGroup,false);
            }

            TextView nameTxt = view.findViewById(R.id.tools_name);
            TextView txtjumlahTools = view.findViewById(R.id.jumlah_tools);
            TextView txtLokasi = view.findViewById(R.id.lokasi_tools);
            ImageView spacecraftImageView = view.findViewById(R.id.image_tools);

            final CariViewModel thisTools= tools.get(position);

            nameTxt.setText(thisTools.getNama_tools());
            txtjumlahTools.setText(thisTools.getStok_awal()+"/"+thisTools.getStok_akhir());
            txtLokasi.setText(thisTools.getLokasi_tools());


            if(thisTools.getImage_tools() != null && thisTools.getImage_tools().length()>0)
            {
                Picasso.get().load(FULL_URL+"/images/"+thisTools.getImage_tools()).placeholder(R.drawable.placeholder).into(spacecraftImageView);
            }else {
                Toast.makeText(context, "Empty Image URL", Toast.LENGTH_LONG).show();
                Picasso.get().load(R.drawable.placeholder).into(spacecraftImageView);
            }

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Toast.makeText(context, thisTools.getNama_tools(), Toast.LENGTH_SHORT).show();
                    String techExists="";

                    String[] tools = {
                            thisTools.getNama_tools(),
                            String.valueOf(thisTools.getStok_akhir()),
                            thisTools.getLokasi_tools(),
                            FULL_URL+"/images/"+thisTools.getImage_tools()
                    };
                    openDetailActivity(tools);
                }
            });

            return view;
        }
        private void openDetailActivity(String[] data) {
            Intent intent = new Intent(getActivity(), DetailCariViewModelActivity.class);
            intent.putExtra("NAME_TOOLS", data[1]);
            intent.putExtra("MERK", data[2]);
            intent.putExtra("TYPE", data[3]);
            intent.putExtra("BAHAN", data[4]);
            intent.putExtra("SPESIFIKASI", data[
                    5]);
            intent.putExtra("SATUAN", data[6]);
            intent.putExtra("STOK_AWAL", data[7]);
            intent.putExtra("STOK_AKHIR", data[8]);
            intent.putExtra("THN_MASUK", data[9]);
            intent.putExtra("KONDISI", data[10]);
            intent.putExtra("LOKASI_TOOLS", data[11]);
            intent.putExtra("IMAGE_TOOLS", data[12]);
            startActivity(intent);
        }

        public void setTools(ArrayList<CariViewModel> filteredTools)
        {
            this.tools=filteredTools;
        }
        @Override
        public Filter getFilter() {
            if(filterHelper==null)
            {
                filterHelper=new FilterHelper(currentList,this,context);
            }
            return filterHelper;
        }
        public void refresh(){
            notifyDataSetChanged();
        }
    }

    private ListViewAdapter adapter;
    private ListView mListView;
    private ProgressBar mProgressBar;
    private SearchView mSearchView;



    private void populateListView(List<CariViewModel> toolsList) {
        adapter = new ListViewAdapter(getActivity(), toolsList);
        mListView.setAdapter(adapter);
    }


    private CariViewModel cariViewModel;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        cariViewModel =
                ViewModelProviders.of(this).get(CariViewModel.class);

        View root = inflater.inflate(R.layout.fragment_cari, container, false);


        mListView = mListView.findViewById(R.id.Cari_ListView);
        mProgressBar= mProgressBar.findViewById(R.id.mProgressBar);
        mProgressBar.setIndeterminate(true);
        mProgressBar.setVisibility(View.VISIBLE);
        mSearchView= mSearchView.findViewById(R.id.AlatSearch);
        mSearchView.setIconified(true);

        MyAPIService myAPIService = RetrofitClientInstance.getRetrofitInstance().create(MyAPIService.class);

        Call<List<CariViewModel>> call = myAPIService.getTools();
        call.enqueue(new Callback<List<CariViewModel>>() {

            @Override
            public void onResponse(Call<List<CariViewModel>> call, Response<List<CariViewModel>> response) {
                mProgressBar.setVisibility(View.GONE);
                populateListView(response.body());
            }
            @Override
            public void onFailure(Call<List<CariViewModel>> call, Throwable throwable) {
                mProgressBar.setVisibility(View.GONE);
                Toast.makeText(getActivity(), "Fail because"+throwable.getMessage(), Toast.LENGTH_LONG).show();
            }
        });

        mSearchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String s) {
                adapter.getFilter().filter(s);
                return false;
            }
            @Override
            public boolean onQueryTextChange(String query) {
                adapter.getFilter().filter(query);
                return false;
            }
        });

        return root;
    }
}