Anggota Kelompok:
1. Akhtar Faizi Putra (2207411002)
2. Andi Rizki Mahesa (2207411004)
3. Okta Gabriel Sinsaku Sinaga (2207411017)
4. Haffidz Aimar Maulana (2207411023)
5. Daffa Ian Nabil (2207411029)

Deskripsi program:

Membuat game ular dengan menggunakan Processing melibatkan beberapa langkah. Pertama, kita perlu menginisialisasi variabel seperti panjang dan lebar layar, ukuran segmen ular, serta koordinat awal ular. Langkah selanjutnya adalah menentukan setup awal permainan, mengatur ukuran layar, dan menginisialisasi kondisi awal ular.

Selanjutnya, fungsi drawSnake() dapat digunakan untuk menggambar ular berdasarkan koordinat segmen-segmen yang telah diatur sebelumnya. Fungsi moveSnake() akan mengatur perpindahan ular sesuai arah gerak yang ditentukan. Interaksi dengan keyboard diimplementasikan melalui fungsi keyPressed(), di mana kita menanggapi input keyboard untuk mengubah arah gerak ular.

Untuk menghindari tabrakan, kita perlu memeriksa kondisi tertentu. Fungsi checkCollision() akan memeriksa apakah ular menabrak batas layar atau tubuhnya sendiri. Jika tabrakan terdeteksi, permainan dapat dihentikan atau diatur sesuai kebutuhan.

Selain itu, kita dapat membuat fungsi untuk menggambar makanan (drawFood()) pada posisi acak dan memeriksa apakah ular memakannya (checkFood()). Jika ular memakan makanan, kita dapat mengimplementasikan logika untuk menambah panjang ular atau menambah skor.

Semua langkah ini ditempatkan dalam draw loop, di mana permainan diperbarui dan digambar secara terus-menerus. Dengan menyusun langkah-langkah ini, kita dapat membuat game ular sederhana namun menyenangkan menggunakan platform Processing.
