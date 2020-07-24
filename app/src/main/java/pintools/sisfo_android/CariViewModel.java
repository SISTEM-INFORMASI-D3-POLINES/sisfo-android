package pintools.sisfo_android;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import com.google.gson.annotations.SerializedName;

import org.w3c.dom.Text;

import java.time.Year;

public class CariViewModel extends ViewModel {

    private MutableLiveData<String> mText;


    public CariViewModel() {
        mText = new MutableLiveData<>();
        mText.setValue("This is cari fragment");
    }


    @SerializedName("id_tools")
    private String id_tools;
    @SerializedName("nama_tools")
    private String nama_tools;
    @SerializedName("merk")
    private String merk;
    @SerializedName("type")
    private String type;
    @SerializedName("bahan")
    private String bahan;
    @SerializedName("spesifikasi")
    private Text spesifikasi;
    @SerializedName("satuan")
    private String satuan;
    @SerializedName("stok_akhir")
    private int stok_akhir;
    @SerializedName("stok_awal")
    private int stok_awal;
    @SerializedName("thn_masuk")
    private Year thn_masuk;
    @SerializedName("desk_tools")
    private String desk_tools;
    @SerializedName("lokasi_tools")
    private String lokasi_tools;
    @SerializedName("image_tools")
    private String image_tools;

    public String getId_tools() {
        return id_tools;
    }

    public String getNama_tools() {
        return nama_tools;
    }

    public String getMerk() {
        return merk;
    }

    public String getType() {
        return type;
    }

    public String getBahan() {
        return bahan;
    }

    public Text getSpesifikasi() {
        return spesifikasi;
    }

    public String getSatuan() {
        return satuan;
    }

    public int getStok_akhir() {
        return stok_akhir;
    }

    public int getStok_awal() {
        return stok_awal;
    }

    public Year getThn_masuk() {
        return thn_masuk;
    }

    public String getDesk_tools() {
        return desk_tools;
    }

    public String getLokasi_tools() {
        return lokasi_tools;
    }

    public String getImage_tools() {
        return image_tools;
    }

    public void setId_tools(String id_tools) {
        this.id_tools = id_tools;
    }

    public void setNama_tools(String nama_tools) {
        this.nama_tools = nama_tools;
    }

    public void setMerk(String merk) {
        this.merk = merk;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setBahan(String bahan) {
        this.bahan = bahan;
    }

    public void setSpesifikasi(Text spesifikasi) {
        this.spesifikasi = spesifikasi;
    }

    public void setSatuan(String satuan) {
        this.satuan = satuan;
    }

    public void setStok_akhir(int stok_akhir) {
        this.stok_akhir = stok_akhir;
    }

    public void setStok_awal(int stok_awal) {
        this.stok_awal = stok_awal;
    }

    public void setThn_masuk(Year thn_masuk) {
        this.thn_masuk = thn_masuk;
    }

    public void setDesk_tools(String desk_tools) {
        this.desk_tools = desk_tools;
    }

    public void setLokasi_tools(String lokasi_tools) {
        this.lokasi_tools = lokasi_tools;
    }

    public void setImage_tools(String image_tools) {
        this.image_tools = image_tools;
    }



    public LiveData<String> getText() {
        return mText;
    }
}