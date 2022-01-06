class KaryawanModel
{
  final int id;
  final String nama;
  final String telp;
  final String email;
  final int department;
  final int jabatan;

  KaryawanModel({
    this.id,
    this.nama,
    this.telp,
    this.email,
    this.department,
    this.jabatan,
  });

  Map<String, dynamic> mapToDbClient(){
    return {
      "ID": this.id,
      "Nama": this.nama,
      "Telp": this.telp,
      "Email": this.telp,
      "Department": this.department,
      "Jabatan": this.jabatan
    };
  }

  factory KaryawanModel.fromMap(Map<String, dynamic> map) {
    final data = KaryawanModel(
      id: map["ID"],
      nama: map["Nama"],
      telp: map["Telp"],
      email: map["Email"],
      department: map["Department"],
      jabatan: map["Jabatan"]
    );
    return data;
  }

}
