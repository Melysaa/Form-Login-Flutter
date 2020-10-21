<?php
include 'koneksi.php';

$nama=$_POST['nama'];
$sandi=$_POST['sandi'];

$data=mysqli_query($koneksi,"select * from pengguna where nama='$nama' AND sandi='$sandi'");
$cek=mysqli_num_rows($data);
if($cek>0){
	$response="login berhasil";
	echo json_encode($response);
}else{
	$response="login gagal";
	echo json_encode($response);
}