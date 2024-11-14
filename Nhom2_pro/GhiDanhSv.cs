using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Nhom2_pro
{
    public partial class GhiDanhSv : Form
    {
        SqlConnection conn;
        DataSet ds;
        SqlDataAdapter sqlda;
        public GhiDanhSv()
        {
            InitializeComponent();
        }
        public void ketnoi()
        {
            string ketnoi;
            ketnoi = "Data Source=DESKTOP-49O1M0L\\SQLEXPRESS;Initial Catalog=QuanLySinhVien;Integrated Security=True;";
            conn = new SqlConnection(ketnoi);
            conn.Open();
        }
        private void LoadSinhVienData(string maSV = "")
        {
            ketnoi();
            string sql = string.IsNullOrEmpty(maSV) ?
                "SELECT MaSV, Ho, Ten, SoDienThoai, GioiTinh, SoCMND FROM SinhVien WHERE DaXoa = 0" :
                "SELECT MaSV, Ho, Ten, SoDienThoai, GioiTinh, SoCMND FROM SinhVien WHERE MaSV = @MaSV AND DaXoa = 0";

            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                if (!string.IsNullOrEmpty(maSV))
                {
                    cmd.Parameters.AddWithValue("@MaSV", maSV);
                }
                sqlda = new SqlDataAdapter(cmd);
                ds = new DataSet();
                sqlda.Fill(ds, "SinhVien");
                dgvSinhVien.DataSource = ds.Tables["SinhVien"];
            }
            conn.Close();
        }
        private void LoadLopHocData(string maLop = "")
        {
            ketnoi();
            string sql = string.IsNullOrEmpty(maLop) ?
                "SELECT MaLop, TenLop FROM LopHoc WHERE DaXoa = 0" :
                "SELECT MaLop, TenLop FROM LopHoc WHERE MaLop = @MaLop AND DaXoa = 0";

            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                if (!string.IsNullOrEmpty(maLop))
                {
                    cmd.Parameters.AddWithValue("@MaLop", maLop);
                }
                sqlda = new SqlDataAdapter(cmd);
                ds = new DataSet();
                sqlda.Fill(ds, "LopHoc");
                dgvLopHoc.DataSource = ds.Tables["LopHoc"];
            }
            conn.Close();
        }
        private int LaySoSVToiDa()
        {
            ketnoi();
            SqlCommand cmd = new SqlCommand("SELECT SoSVToiDa FROM CauHinh", conn);
            int soSVToiDa = (int)cmd.ExecuteScalar();
            conn.Close();
            return soSVToiDa;
        }

        private int LaySoSVDaDangKy(string maLop)
        {
            ketnoi();
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM GhiDanh WHERE MaLop = @MaLop AND DaXoa = 0", conn);
            cmd.Parameters.AddWithValue("@MaLop", maLop);
            int soSVDaDangKy = (int)cmd.ExecuteScalar();
            conn.Close();
            return soSVDaDangKy;
        }
        private bool KiemTraGhiDanh(string maSV, string maLop)
        {
            ketnoi();
            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM GhiDanh WHERE MaSV = @MaSV AND MaLop = @MaLop", conn);
            cmd.Parameters.AddWithValue("@MaSV", maSV);
            cmd.Parameters.AddWithValue("@MaLop", maLop);
            bool exists = (int)cmd.ExecuteScalar() > 0;
            conn.Close();
            return exists;
        }

        private void btnthem_Click(object sender, EventArgs e)
        {
            try
            {
                // Kiểm tra kết nối
                ketnoi();

                // Chuẩn bị truy vấn để thêm dữ liệu vào bảng GhiDanh
                string query = "INSERT INTO GhiDanh (MaSV, MaLop, SoBuoiVang) VALUES (@MaSV, @MaLop, @SoBuoiVang)";

                // Thiết lập lệnh với các tham số
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MaSV", int.Parse(txtMaSV.Text));
                cmd.Parameters.AddWithValue("@MaLop", int.Parse(txtMaLop.Text));
                cmd.Parameters.AddWithValue("@SoBuoiVang", int.Parse(txtSoBuoiVang.Text));

                // Thực thi lệnh
                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    MessageBox.Show("Thêm sinh viên vào lớp thành công!");
                }
                else
                {
                    MessageBox.Show("Thêm sinh viên vào lớp thất bại.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
            finally
            {
                // Đóng kết nối sau khi hoàn thành
                conn.Close();
            }
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void GhiDanhSv_Load(object sender, EventArgs e)
        {
            LoadSinhVienData();
            LoadLopHocData();

        }

        private void cbLopHoc_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }
        

        private void cbSinhVien_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void dgvLopHoc_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = dgvLopHoc.Rows[e.RowIndex];
                txtMaLop.Text = row.Cells["MaLop"].Value.ToString();
                txtLopHoc.Text = row.Cells["TenLop"].Value.ToString();
            }
        }

        private void dgvSinhVien_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = dgvSinhVien.Rows[e.RowIndex];
                txtMaSV.Text = row.Cells["MaSV"].Value.ToString();
                txtSinhVien.Text = row.Cells["Ten"].Value.ToString();
            }
        }

        private void dgvSinhVien_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
