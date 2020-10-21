<?php
$koneksi=mysqli_connect("localhost", "root", "", "projectapi");
if (mysqli_connect_errno()) {
	echo "koneksi database tidak berhasil : " .mysqli_connect_error();
}
?>