// ============================================================
// Animasi Dakwah: "Kecil Bukan Berarti Kalah" - Multi Scene
// ============================================================

// Global variables untuk scene management
int currentScene = 1;
int maxScenes = 5;
int sceneDuration = 840; // 6 detik per scene (60fps)
int sceneTimer = 0;

// Animation control
int animFrame = 0;
int animCount = 0;
int animDelay = 15;

// Character positions dan states
float denoX = 160, denoY;
float ustadX = 600, ustadY;
boolean ustadWalking = false;

// === TAMBAHAN UNTUK SCENE 1 ===
float teman1X, teman2X;
boolean temanSudahTiba = false;
// =============================


// Awan animation
float awanX1 = 100, awanX2 = 300, awanX3 = 600;
final float groundY = 500;

color[] flowerPalette; // === TAMBAHAN PALET WARNA BUNGA ===

int[] sceneDurations; // Kita akan menggunakan array untuk durasi

void setup() {
  size(800, 600);
  smooth();
  denoY = groundY - 0.625 * 75;
  ustadY = groundY - 0.625 * 80;

  // === TAMBAHAN DI SINI: Inisialisasi Palet Warna ===
  flowerPalette = new color[4];
  flowerPalette[0] = color(255, 69, 0);  // Oranye-Merah
  flowerPalette[1] = color(255, 215, 0); // Kuning Emas
  flowerPalette[2] = color(218, 112, 214); // Ungu Anggrek
  flowerPalette[3] = color(30, 144, 255); // Biru Langit
  
  // === TAMBAHAN DI SINI: Inisialisasi durasi per scene ===
  sceneDurations = new int[maxScenes];
  sceneDurations[0] = 840; // Scene 1: 14 detik
  sceneDurations[1] = 120; // Scene 2: 6 detik
  sceneDurations[2] = 120; // Scene 3: 6 detik
  sceneDurations[3] = 120; // Scene 4 (menyapu): 8 detik agar tidak terlalu cepat
  sceneDurations[4] = 120; // Scene 5: 6 detik
  // =======================================================
}

void draw() {
  sceneTimer++;
  switch(currentScene) {
    case 1: drawScene1(); break;
    case 2: drawScene2(); break;
    case 3: drawScene3(); break;
    case 4: drawScene4(); break;
    case 5: drawScene5(); break;
  }
  updateAnimations();
  if(sceneTimer >= sceneDurations[currentScene - 1]) {
    nextScene();
  }
  drawSceneInfo();
}

void updateAnimations() {
  animCount++;
  if(animCount >= animDelay) {
    animFrame = (animFrame + 1) % 4;
    animCount = 0;
  }
  awanX1 += 0.5;  awanX2 += 0.3;  awanX3 += 0.4;
  if (awanX1 > width) awanX1 = -120;
  if (awanX2 > width) awanX2 = -150;
  if (awanX3 > width) awanX3 = -130;
}

void nextScene() {
  currentScene++;
  if(currentScene > maxScenes) {
    currentScene = 1;
  }
  sceneTimer = 0;
  resetCharacterPositions();
}

void resetCharacterPositions() {
  switch(currentScene) {
    case 1: 
      // === ATUR POSISI AWAL BARU UNTUK SCENE 1 ===
      denoX = 300;                  // Deno mulai di kiri pintu
      teman1X = width + 50;         // Teman perempuan mulai dari luar layar kanan
      teman2X = width + 120;        // Teman laki-laki mulai dari luar layar kanan
      temanSudahTiba = false;       // Reset saklar animasi
      break;
    case 2: 
      denoX = 400; 
      break;
    case 3: 
      denoX = 300; 
      ustadX = 600; 
      ustadWalking = true; 
      break;
    case 4: 
      // Nilai ini tidak lagi digunakan karena Scene 4 dinamis
      break;
    case 5: 
      denoX = 400; 
      break;
  }
}

// ============================================================
// SCENE FUNCTIONS
// ============================================================

void drawScene1() {
  // Gambar latar belakang dan awan
  drawMasjidKartun();
  drawAwan();
  
  float h = 75;
  float yPos = groundY - 0.625 * h;

  // Logika Animasi berdasarkan "saklar"
  if (!temanSudahTiba) {
    // Fase 1: Teman-teman berjalan dari KANAN ke KIRI
    
    // Target posisi teman-teman di sebelah kanan Deno
    float targetTeman1 = denoX + 80;
    float targetTeman2 = denoX + 150;
    
    // Gerakkan teman-teman ke kiri
    if (teman1X > targetTeman1) {
      teman1X -= 1.0;
    }
    if (teman2X > targetTeman2) {
      teman2X -= 1.2;
    }
    
    // Cek jika keduanya sudah sampai
    if (teman1X <= targetTeman1 && teman2X <= targetTeman2) {
      temanSudahTiba = true; // Balik saklar!
    }
    
  } else {
    // Fase 2: Deno berjalan menjauh ke KIRI
    float targetDeno = 160;
    if (denoX > targetDeno) {
      denoX -= 1.5;
    }
  }

  // --- Gambar semua karakter sesuai posisi mereka saat ini ---

  // Deno
  pushMatrix();
  translate(denoX, yPos);
  // Jika Deno sedang berjalan ke kiri, balik badannya
  if (temanSudahTiba && denoX > 160) {
     scale(-1, 1);
     translate(0, sin(frameCount * 0.2) * 2); // Gerakan naik-turun
  }
  drawFriendBoyNgajiKacamata(0, 0, h);
  popMatrix();
  
  // Teman Laki-laki
  pushMatrix();
  translate(teman2X, yPos);
  // Jika teman sedang berjalan ke kiri, balik badannya
  if (!temanSudahTiba) {
     scale(-1, 1);
     translate(0, sin(frameCount * 0.2) * 2); // Gerakan naik-turun
  }
  drawFriendBoyNgaji(0, 0, h);
  popMatrix();

  // Teman Perempuan
  pushMatrix();
  translate(teman1X, yPos);
  // Jika teman sedang berjalan ke kiri, balik badannya
  if (!temanSudahTiba) {
     scale(-1, 1);
     translate(0, sin(frameCount * 0.18) * 2); // Gerakan naik-turun
  }
  drawFriendGirlNgaji(0, 0, h);
  popMatrix();

  // Efek mood Deno (selalu mengikuti posisi Deno)
  fill(0, 0, 100, 30);
  ellipse(denoX, yPos, 120, 120);
}

void drawScene2() {
  // === LOGIKA ANIMASI ZOOM ===
  // Tentukan level zoom. Mulai dari 1.0 (normal) hingga 1.8 (diperbesar)
  // seiring berjalannya waktu scene.
  float zoomLevel = map(sceneTimer, 0, sceneDurations[1], 1.0, 1.8);

  // Tentukan titik pusat zoom, yaitu posisi Deno.
  // Posisi X Deno untuk Scene 2 diatur ke 400 di resetCharacterPositions().
  float h = 75;
  float zoomX = denoX;
  float zoomY = 520 - 0.3 * h;

  // Terapkan transformasi zoom ke seluruh scene
  pushMatrix();
  translate(zoomX, zoomY);
  scale(zoomLevel);
  translate(-zoomX, -zoomY);
  // ==========================

  // GAMBAR SEMUA ELEMEN SEPERTI BIASA
  // (Transformasi zoom akan mempengaruhi semua yang digambar setelah ini)

  drawKamarDeno();  // Background kamar
  
  // Deno duduk di lantai (bersila)
  pushMatrix();
  translate(denoX, 520 - 0.3 * h);  // Gunakan posisi yang sama dengan pusat zoom
  drawDenoTanpaQuran(0, 0, h);
  popMatrix();
  
  // Efek cahaya lembut dari lampu berkedip
  fill(255, 255, 150, 15 + sin(animFrame * 0.1) * 10);
  ellipse(width/2, 200, 300, 200);
  
  popMatrix(); // Mengakhiri blok transformasi zoom
}

void drawScene3() {
  drawRumputSaja();
  drawPohonBesar(60, groundY - 120);
  
  pushMatrix();
  translate(400, 0);
  drawMasjidSaja();
  popMatrix();
  
  drawAwan();

  float h = 75;
  // Deno duduk tanpa Quran
  pushMatrix();
  translate(300, groundY - 0.625 * h);  // Sesuaikan posisi agar proporsional
  drawDenoTanpaQuran(0, 0, h);
  popMatrix();

  // Ustad berjalan menghampiri
  if(ustadWalking) {
    ustadX -= 2;
    if(ustadX <= 380) {
      ustadWalking = false;
    }
  }
  pushMatrix();
  translate(ustadX, ustadY);
  if(ustadWalking) {
    translate(0, sin(animFrame * 0.5) * 3);
  }
  drawUstadRian(0, 0, 80);
  popMatrix();

}

void drawScene4() {
  // Latar belakang interior masjid
  drawInteriorMasjid();
  
  float h = 75;
  float yPos = groundY - 0.625 * h;

  // === LOGIKA BARU UNTUK GERAKAN KANAN-KIRI ===
  float patrolCenter = width / 2; // Titik tengah area pembersihan
  // Jarak dari tengah ke tepi (misal: dari x=150 ke x=650)
  float patrolAmplitude = (width / 2) - 150; 
  float patrolSpeed = 0.03; // Kecepatan gerakan bolak-balik

  // Hitung posisi X Deno saat ini menggunakan fungsi sinus berdasarkan waktu scene
  float denoX_scene4 = patrolCenter + sin(sceneTimer * patrolSpeed) * patrolAmplitude;

  // Tentukan arah hadap karakter (kiri atau kanan) dengan memeriksa pergerakan sinus
  float facingDirection = cos(sceneTimer * patrolSpeed);
  // ===========================================

  // Animasi Deno menyapu
  pushMatrix();
  translate(denoX_scene4, yPos); // Gunakan posisi X yang dinamis

  // Balik gambar karakter jika bergerak ke kiri (nilai cosinus negatif)
  if (facingDirection < 0) {
    scale(-1, 1);
  }

  // Gerakan mengayun sapu (tetap ada)
  rotate(sin(frameCount * 0.1) * 0.08); 
  
  // Gambar karakter Deno dengan sapu
  drawDenoMenyapu(0, 0, h); 
  popMatrix();
  
  // Efek debu/kilau yang sekarang mengikuti posisi Deno
  for (int i = 0; i < 7; i++) {
    fill(255, 255, 150, 100);
    // Posisikan debu di sekitar Deno
    float sparkX = denoX_scene4 + sin(frameCount * 0.15 + i) * 80;
    float sparkY = yPos + 40 + cos(frameCount * 0.15 + i) * 15;
    if (sin(frameCount * 0.1) > 0) { // Hanya muncul saat sapu mengayun ke satu sisi
      ellipse(sparkX, sparkY, 4, 4);
    }
  }
}

void drawScene5() {
  drawSunsetMasjid();
  drawAwan();
  float h = 75;
  // Deno bahagia (bouncing) dengan Quran
  pushMatrix();
  translate(denoX, groundY - 0.625 * h + sin(animFrame * 0.4) * 5);
  drawFriendBoyNgajiKacamataHappy(0, 0, h);
  popMatrix();
  // Efek cahaya hangat
  for(int i = 0; i < 12; i++) {
    fill(255, 255, 0, 80);
    float lightX = denoX + sin(animFrame * 0.1 + i) * 60;
    float lightY = denoY + cos(animFrame * 0.1 + i) * 60;
    ellipse(lightX, lightY, 8, 8);
  }
  // Ending text
  fill(255, 255, 255, 230);
  stroke(0);
  strokeWeight(2);
  rect(width/2 - 180, height - 100, 360, 70, 10);
  noStroke();
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(14);
  text("Kecil bukan berarti kalah", width/2, height - 80);
  textSize(11);
  text("Nilai seseorang dari ketulusan hati dan amal", width/2, height - 60);
}

// ============================================================
// BACKGROUND FUNCTIONS
// ============================================================

void drawMasjidKartun() {
  rectMode(CORNER);
  background(#F0C88C);
  fill(#78C878);
  rect(0, groundY, width, 100);

  // Menggunakan loop dan palet warna yang sama dengan Scene 3
  for (int i = 0; i < 800; i += 50) {
    int flowerIndex = (i / 50) % flowerPalette.length;
    fill(flowerPalette[flowerIndex]);
    ellipse(i+10, 540, 15, 15);
    fill(0,100,0);
    rect(i+7, 550, 4, 15);
  }
  
  // Gambar Masjid
  fill(#8CC8FF);
  rect(80,200,80,300);
  rect(640,200,80,300);
  fill(#005AE6);
  arc(120,200,80,80,PI,TWO_PI);
  arc(680,200,80,80,PI,TWO_PI);
  fill(#78B4FF);
  rect(200,300,400,200);
  fill(#14285A);
  rect(350,340,100,160,10);
  fill(#64A0FF);
  triangle(300,300,500,300,400,240);
  fill(#0064FF);
  arc(400,300,200,140,PI,TWO_PI);
  fill(#8CC8FF);
  rect(160,340,40,160);
  rect(600,340,40,160);
}

void drawKamarDeno() {
  background(245, 225, 215);

  // Karpet kotak lantai
  for (int y = 500; y < height; y += 40) {
    for (int x = 0; x < width; x += 40) {
      fill(((x + y) / 40) % 2 == 0 ? color(240, 200, 170) : color(255, 215, 185));
      rect(x, y, 40, 40);
    }
  }

  // === KARPET OVAL (turun ke kotak kedua) ===
  fill(160, 120, 80);
  ellipse(width / 2, 560, 280, 60);  // dari 535 → 560

  // === POT TANAMAN KIRI BAWAH ===
  fill(100, 60, 40);
  rect(50, 500, 30, 40, 5);  // pot
  stroke(80, 50, 30);
  strokeWeight(4);
  line(65, 500, 65, 460);  // batang
  noStroke();
  fill(60, 150, 60);
  ellipse(60, 470, 20, 12);
  ellipse(70, 470, 20, 12);
  ellipse(65, 460, 22, 14);

  // === STANDING LAMP (turun ke kotak kedua) ===
  stroke(90);
  strokeWeight(3);
  line(730, 500, 730, 420);  // tiang diturunkan
  noStroke();
  fill(255, 250, 200);
  ellipse(730, 410, 30, 20);  // kepala lampu turun
  fill(255, 250, 200, 60);
  ellipse(730, 410, 80, 30);
  stroke(90);
  strokeWeight(2);
  line(730, 500, 715, 540);  // kaki tripod di kotak kedua
  line(730, 500, 745, 540);
  line(730, 500, 730, 540);
  noStroke();

  // === DEKORASI DINDING & JENDELA ===
  fill(200, 200, 210); rect(520, 140, 220, 160, 6);
  fill(25, 45, 85);     rect(530, 150, 200, 140);
  fill(255, 255, 210);  ellipse(610, 200, 50, 50);
  fill(25, 45, 85);     ellipse(595, 190, 45, 45);
  fill(255, 255, 230);
  for (int i = 0; i < 25; i++) {
    ellipse(random(540, 720), random(60, 80), 2, 2);
  }

  fill(220, 180, 200);
  rect(500, 140, 20, 160);
  rect(740, 140, 20, 160);

  fill(255, 240, 200); ellipse(width / 2, 80, 80, 40);
  fill(255, 240, 200, 110); ellipse(width / 2, 80, 400, 220);


  // Rak buku
  fill(120, 80, 50);
  rect(50, 280, 120, 20);
  rect(50, 310, 120, 20);
  rect(50, 340, 120, 20);

  fill(200,100,100); rect(55,275,12,20); fill(100,150,200); rect(70,275,12,20);
  fill(150,200,100); rect(85,275,12,20); fill(200,150,100); rect(100,275,12,20);
  fill(100,200,100); rect(115,275,12,20); fill(200,100,200); rect(130,275,12,20);
  fill(100,100,200); rect(145,275,12,20);

  fill(100,200,150); rect(55,305,12,20); fill(200,200,100); rect(70,305,12,20);
  fill(150,100,200); rect(85,305,12,20); fill(200,150,50); rect(100,305,12,20);
  fill(50,200,200); rect(115,305,12,20); fill(200,50,150); rect(130,305,12,20);

  fill(150,150,200); rect(55,335,12,20); fill(200,150,150); rect(70,335,12,20);
  fill(150,200,150); rect(85,335,12,20); fill(100,150,150); rect(100,335,12,20);
  fill(200,100,50);  rect(115,335,12,20);

  fill(160, 120, 80); rect(75, 200, 60, 45);
  fill(100, 150, 200); rect(80, 205, 50, 35);

  fill(100); ellipse(width/2, 200, 40, 40);
  fill(255); ellipse(width/2, 200, 35, 35);
  stroke(0); strokeWeight(1);
  line(width/2, 200, width/2 - 12, 200 + 8);
  line(width/2, 200, width/2, 200 - 15);
  noStroke();
}




void drawRumputSaja() {
  background(#F0C88C);
  fill(#78C878);
  rect(0, groundY, width, 100);

  // Menggunakan palet warna tetap yang sama, bukan random
  for (int i = 0; i < 800; i += 50) {
    int flowerIndex = (i / 50) % flowerPalette.length; // 0, 1, 2, 3, 0, 1, ...
    fill(flowerPalette[flowerIndex]);
    ellipse(i+10, 540, 15, 15);
    fill(0,100,0);
    rect(i+7, 550, 4, 15);
  }
}

void drawMasjidSaja() {
  rectMode(CORNER);
  fill(#8CC8FF);
  rect(80,200,80,300);
  rect(640,200,80,300);
  fill(#005AE6);
  arc(120,200,80,80,PI,TWO_PI);
  arc(680,200,80,80,PI,TWO_PI);
  fill(#78B4FF);
  rect(200,300,400,200);
  fill(#14285A);
  rect(350,340,100,160,10);
  fill(#0064FF);
  arc(400,300,200,140,PI,TWO_PI);
  fill(#8CC8FF);
  rect(160,340,40,160);
  rect(600,340,40,160);
}

void drawPohonBesar(float x, float y) {
  pushMatrix();
  translate(x, y);
  fill(#8B4513);
  rect(-15, 0, 30, 120);
  fill(#228B22);
  ellipse(0, -20, 80, 80);
  ellipse(-25, -35, 60, 60);
  ellipse(25, -35, 60, 60);
  ellipse(-15, -50, 50, 50);
  ellipse(15, -50, 50, 50);
  ellipse(0, -60, 70, 70);
  fill(#32CD32);
  ellipse(-8, -35, 25, 25);
  ellipse(12, -45, 20, 20);
  ellipse(0, -55, 30, 30);
  popMatrix();
}

void drawSunsetMasjid() {
  for(int i = 0; i < height; i++) {
    float t = map(i, 0, height, 0, 1);
    color c = lerpColor(color(255, 200, 100), color(255, 120, 120), t);
    stroke(c);
    line(0, i, width, i);
  }
  noStroke();
  fill(255, 255, 150);
  ellipse(width - 120, 120, 60, 60);
  
  // Masjid kiri & kanan
  fill(#8CC8FF);
  rect(80, 200, 80, 300);
  rect(640, 200, 80, 300);
  fill(#005AE6);
  arc(120, 200, 80, 80, PI, TWO_PI);
  arc(680, 200, 80, 80, PI, TWO_PI);
  
  fill(#78B4FF);
  rect(200, 300, 400, 200);
  
  fill(#14285A);
  rect(350, 340, 100, 160, 10);
  
  fill(#64A0FF);
  triangle(300, 300, 500, 300, 400, 240);
  
  fill(#0064FF);
  arc(400, 300, 200, 140, PI, TWO_PI);
  
  fill(#8CC8FF);
  rect(160, 340, 40, 160);
  rect(600, 340, 40, 160);
  
  fill(#78C878);
  rect(0, groundY, width, 100);
}



// ============================================================
// CHARACTER FUNCTIONS
// ============================================================

void drawUstadRian(float x, float y, float h) {
  pushMatrix();
  translate(x, y);
  pushStyle();
  rectMode(CENTER);
  color kulit = #FFDEB5;
  color rambut = #2A2A2A;
  color baju = #8FBC8F;
  color peci = #2F2F2F;
  fill(#654321);
  rect(-h*0.15, h*0.35, h*0.12, h*0.20, 4);
  rect(h*0.15, h*0.35, h*0.12, h*0.20, 4);
  fill(#8B4513);
  ellipse(-h*0.15, h*0.5, h*0.25, h*0.15);
  ellipse(h*0.15, h*0.5, h*0.25, h*0.15);
  fill(baju);
  rect(0, h*0.3, h*0.8, h*0.9, 10);
  rect(-h*0.45, h*0.2, h*0.15, h*0.4, 5);
  rect(h*0.45, h*0.2, h*0.15, h*0.4, 5);
  fill(kulit);
  ellipse(0, 0, h*1.1, h*1.1);
  fill(rambut);
  arc(0, -h*0.1, h*1.1, h*0.9, PI, TWO_PI);
  fill(peci);
  rect(0, -h*0.55, h*0.9, h*0.2, 4);
  fill(0);
  ellipse(-h*0.2, -h*0.05, h*0.1, h*0.12);
  ellipse(h*0.2, -h*0.05, h*0.1, h*0.12);
  // Hanya satu mulut senyuman seperti Deno
  stroke(150, 30, 30);
  strokeWeight(2);
  noFill();
  arc(0, h*0.15, h*0.3, h*0.15, 0, PI);
  noStroke();
  popStyle();
  popMatrix();
}

void drawFriendBoyNgajiKacamataHappy(float x, float y, float h) {
  pushMatrix();
  translate(x,y);
  pushStyle();
  rectMode(CENTER);
  color kulit=#FFDEB5,rambut=#2A2A2A,baju=#9BD8B2,peci=#2F2F2F;
  fill(#3E6F55);
  rect(-h*0.15,h*0.35,h*0.12,h*0.20,4);
  rect( h*0.03,h*0.35,h*0.12,h*0.20,4);
  fill(#4A7E64);
  ellipse(-h*0.25,h*0.5,h*0.6,h*0.25);
  ellipse( h*0.25,h*0.5,h*0.6,h*0.25);
  fill(baju);
  rect(0,h*0.3,h*0.75,h*0.85,10);
  rect(-h*0.4,h*0.2,h*0.12,h*0.4,5);
  rect( h*0.3,h*0.2,h*0.12,h*0.4,5);
  fill(kulit);
  ellipse(0,0,h,h);
  fill(rambut);
  arc(0,-h*0.1,h,h*0.85,PI,TWO_PI);
  fill(peci);
  rect(0,-h*0.5,h*0.84,h*0.2,4);
  fill(0);
  ellipse(-h*0.18,0,h*0.12,h*0.14);
  ellipse(h*0.18,0,h*0.12,h*0.14);
  stroke(0);
  strokeWeight(2);
  noFill();
  float r = h * 0.22;
  ellipse(-h*0.18,0,r,r);
  ellipse( h*0.18,0,r,r);
  line(-h*0.11,0,h*0.11,0);
  noStroke();
  stroke(150,30,30);
  strokeWeight(2);
  noFill();
  arc(0,h*0.2,h*0.3,h*0.15,0,PI);
  noStroke();
  fill(#FFF4DA);
  rect(0,h*0.45,h*0.8,h*0.13,5);
  stroke(#A56A3F);
  strokeWeight(6);
  line(-h*0.35,h*0.5,0,h*0.68);
  line(h*0.35,h*0.5,0,h*0.68);
  popStyle();
  popMatrix();
}

// Deno tanpa Quran (untuk scene 2 & 3)
void drawDenoTanpaQuran(float x, float y, float h) {
  pushMatrix();
  translate(x, y);
  pushStyle();
  rectMode(CENTER);
  color kulit = #FFDEB5, rambut = #2A2A2A, baju = #9BD8B2, peci = #2F2F2F;
  fill(#3E6F55);
  rect(-h*0.15, h*0.35, h*0.12, h*0.20, 4);
  rect(h*0.03, h*0.35, h*0.12, h*0.20, 4);
  fill(#4A7E64);
  ellipse(-h*0.25, h*0.5, h*0.6, h*0.25);
  ellipse(h*0.25, h*0.5, h*0.6, h*0.25);
  fill(baju);
  rect(0, h*0.3, h*0.75, h*0.85, 10);
  rect(-h*0.4, h*0.2, h*0.12, h*0.4, 5);
  rect(h*0.3, h*0.2, h*0.12, h*0.4, 5);
  fill(kulit);
  ellipse(0, 0, h, h);
  fill(rambut);
  arc(0, -h*0.1, h, h*0.85, PI, TWO_PI);
  fill(peci);
  rect(0, -h*0.5, h*0.84, h*0.2, 4);
  fill(0);
  ellipse(-h*0.18, 0, h*0.12, h*0.14);
  ellipse(h*0.18, 0, h*0.12, h*0.14);
  stroke(0);
  strokeWeight(2);
  noFill();
  float r = h * 0.22;
  ellipse(-h*0.18, 0, r, r);
  ellipse(h*0.18, 0, r, r);
  line(-h*0.11, 0, h*0.11, 0);
  noStroke();
  stroke(150, 30, 30);
  strokeWeight(2);
  noFill();
  // Mulut sedih - arc terbalik dari PI ke TWO_PI (melengkung ke bawah)
  arc(0, h*0.25, h*0.3, h*0.15, PI, TWO_PI);
  noStroke();
  popStyle();
  popMatrix();
}

void drawFriendBoyNgaji(float x, float y, float h) {
  pushMatrix();
  translate(x,y);
  pushStyle();
  rectMode(CENTER);
  color kulit=#FFDEB5,rambut=#2A2A2A,baju=#9BD8B2,peci=#2F2F2F;
  fill(#3E6F55);
  rect(-h*0.15,h*0.35,h*0.12,h*0.20,4);
  rect( h*0.03,h*0.35,h*0.12,h*0.20,4);
  fill(#4A7E64);
  ellipse(-h*0.25,h*0.5,h*0.6,h*0.25);
  ellipse( h*0.25,h*0.5,h*0.6,h*0.25);
  fill(baju);
  rect(0,h*0.3,h*0.75,h*0.85,10);
  rect(-h*0.4,h*0.2,h*0.12,h*0.4,5);
  rect( h*0.3,h*0.2,h*0.12,h*0.4,5);
  fill(kulit);
  ellipse(0,0,h,h);
  fill(rambut);
  arc(0,-h*0.1,h,h*0.85,PI,TWO_PI);
  fill(peci);
  rect(0,-h*0.5,h*0.84,h*0.2,4);
  fill(0);
  ellipse(-h*0.18,0,h*0.12,h*0.14);
  ellipse(h*0.18,0,h*0.12,h*0.14);
  stroke(150,30,30);
  strokeWeight(2);
  noFill();
  arc(0,h*0.2,h*0.25,h*0.12,0,PI);
  noStroke();
  fill(#FFF4DA);
  rect(0,h*0.45,h*0.8,h*0.13,5);
  stroke(#A56A3F);
  strokeWeight(6);
  line(-h*0.35,h*0.5,0,h*0.68);
  line(h*0.35,h*0.5,0,h*0.68);
  popStyle();
  popMatrix();
}

void drawFriendGirlNgaji(float x, float y, float h) {
  pushMatrix();
  translate(x,y);
  pushStyle();
  rectMode(CENTER);
  color kulit=#FFE9C5,hijab=#D1AEE4,gamis=#FBE3A8;
  fill(#3E6F55);
  rect(-h*0.15,h*0.35,h*0.12,h*0.20,4);
  rect( h*0.03,h*0.35,h*0.12,h*0.20,4);
  fill(#4F746C);
  ellipse(-h*0.25,h*0.5,h*0.6,h*0.25);
  ellipse( h*0.25,h*0.5,h*0.6,h*0.25);
  fill(gamis);
  rect(0,h*0.3,h*0.85,h*0.85,14);
  rect(-h*0.45,h*0.15,h*0.15,h*0.4,6);
  rect( h*0.30,h*0.15,h*0.15,h*0.4,6);
  fill(hijab);
  ellipse(0,0,h*1.2,h*1.2);
  fill(kulit);
  ellipse(0,0,h,h);
  fill(hijab);
  arc(0,-h*0.1,h*1.05,h*0.85,PI,TWO_PI);
  fill(0);
  ellipse(-h*0.18,0,h*0.12,h*0.13);
  ellipse(h*0.18,0,h*0.12,h*0.13);
  stroke(150,30,30);
  strokeWeight(2);
  noFill();
  arc(0,h*0.2,h*0.25,h*0.12,0,PI);
  noStroke();
  fill(#FFB2B2,180);
  ellipse(-h*0.34,h*0.08,h*0.14,h*0.14);
  ellipse(h*0.34,h*0.08,h*0.14,h*0.14);
  fill(#FFF4DA);
  rect(0,h*0.45,h*0.8,h*0.13,5);
  stroke(#A56A3F);
  strokeWeight(6);
  line(-h*0.35,h*0.5,0,h*0.68);
  line(h*0.35,h*0.5,0,h*0.68);
  popStyle();
  popMatrix();
}

void drawFriendBoyNgajiKacamata(float x, float y, float h) {
  pushMatrix();
  translate(x,y);
  pushStyle();
  rectMode(CENTER);
  color kulit=#FFDEB5,rambut=#2A2A2A,baju=#9BD8B2,peci=#2F2F2F;
  fill(#3E6F55);
  rect(-h*0.15,h*0.35,h*0.12,h*0.20,4);
  rect( h*0.03,h*0.35,h*0.12,h*0.20,4);
  fill(#4A7E64);
  ellipse(-h*0.25,h*0.5,h*0.6,h*0.25);
  ellipse( h*0.25,h*0.5,h*0.6,h*0.25);
  fill(baju);
  rect(0,h*0.3,h*0.75,h*0.85,10);
  rect(-h*0.4,h*0.2,h*0.12,h*0.4,5);
  rect( h*0.3,h*0.2,h*0.12,h*0.4,5);
  fill(kulit);
  ellipse(0,0,h,h);
  fill(rambut);
  arc(0,-h*0.1,h,h*0.85,PI,TWO_PI);
  fill(peci);
  rect(0,-h*0.5,h*0.84,h*0.2,4);
  fill(0);
  ellipse(-h*0.18,0,h*0.12,h*0.14);
  ellipse(h*0.18,0,h*0.12,h*0.14);
  stroke(0);
  strokeWeight(2);
  noFill();
  float r = h * 0.22;
  ellipse(-h*0.18,0,r,r);
  ellipse( h*0.18,0,r,r);
  line(-h*0.11,0,h*0.11,0);
  noStroke();
  stroke(150,30,30);
  strokeWeight(2);
  noFill();
  arc(0,h*0.25,h*0.25,h*0.12,PI,TWO_PI);
  noStroke();
  fill(#FFF4DA);
  rect(0,h*0.45,h*0.8,h*0.13,5);
  stroke(#A56A3F);
  strokeWeight(6);
  line(-h*0.35,h*0.5,0,h*0.68);
  line(h*0.35,h*0.5,0,h*0.68);
  popStyle();
  popMatrix();
}

void drawInteriorMasjid() {
  // Lantai masjid (karpet hijau)
  rectMode(CORNER);
  for (int i = 0; i < height; i++) {
    float t = map(i, 350, height, 0, 1);
    color c = lerpColor(color(10, 140, 90), color(25, 160, 115), t);
    stroke(c);
    line(0, i, width, i);
  }
  noStroke();

  // Pola Garis Shaf di Karpet
  stroke(10, 100, 70, 180);
  strokeWeight(3);
  for (int y = 390; y < height; y += 45) {
    line(0, y, width, y);
  }
  noStroke();

  // Dinding belakang
  fill(230, 220, 200);
  rect(0, 0, width, 350);

  // === PERUBAHAN 1: Kaligrafi diubah menjadi Jam Dinding ===
  pushMatrix();
  translate(200, 180); // Posisikan di dinding kiri
  // Bingkai jam
  fill(139, 69, 19); // Warna Coklat Kayu
  ellipse(0, 0, 100, 100);
  // Muka jam
  fill(250, 245, 230); // Warna Krem
  ellipse(0, 0, 85, 85);
  // Jarum jam (statis menunjuk sekitar jam 03:00)
  stroke(0);
  strokeWeight(5);
  line(0, 0, 25, 0); // Jarum pendek (jam)
  strokeWeight(3);
  line(0, 0, 0, -35); // Jarum panjang (menit)
  noStroke();
  popMatrix();
  
  // Pintu Persegi Panjang (tidak berubah)
  rectMode(CENTER);
  fill(173, 216, 230);
  rect(width / 2, 215, 120, 270);
  noFill();
  stroke(188, 143, 143);
  strokeWeight(15);
  rect(width / 2, 215, 120, 270);
  strokeWeight(1);
  noStroke();
  rectMode(CORNER);

  // Pilar di sisi kanan
  fill(210, 190, 170);
  rect(width - 120, 0, 60, 500);
  
  // === PERUBAHAN 2: Menambahkan lebih banyak buku di rak ===
  pushMatrix();
  translate(width - 230, 180); // Posisikan di dekat pilar kanan
  fill(139, 69, 19); // Warna kayu rak
  rect(0, 0, 90, 12);
  rect(0, 45, 90, 12); // Rak bawah sedikit diturunkan
  
  // Buku-buku di rak ATAS
  fill(0, 100, 0); rect(8, -25, 12, 25);
  fill(180, 0, 0); rect(25, -25, 12, 25);
  fill(0, 0, 128); rect(42, -25, 12, 25);
  fill(218, 165, 32); rect(59, -25, 12, 25); // Buku tambahan
  
  // Buku-buku di rak BAWAH
  fill(128, 128, 0); rect(12, 20, 12, 25);
  fill(0, 128, 128); rect(29, 20, 12, 25);
  fill(128, 0, 128); rect(46, 20, 12, 25);
  fill(40, 40, 40); rect(63, 20, 12, 25);
  popMatrix();
}

void drawDenoMenyapu(float x, float y, float h) {
  pushMatrix();
  translate(x, y);

  // GAMBAR SAPU (digambar di belakang karakter)
  pushMatrix();
  translate(h * 0.05, h * 0.2);
  rotate(0.15);
  fill(160, 120, 80); // Gagang sapu
  rectMode(CENTER);
  rect(0, -h * 0.6, 10, h * 1.5, 3);
  fill(222, 184, 135); // Ijuk sapu
  triangle(-25, h * 0.15, 25, h * 0.15, 0, h * 0.5);
  rectMode(CORNER); // Kembalikan rectMode
  popMatrix();

  // GAMBAR KARAKTER DENO (tanpa Al-Quran)
  pushStyle();
  rectMode(CENTER);
  color kulit = #FFDEB5, rambut = #2A2A2A, baju = #9BD8B2, peci = #2F2F2F;

  fill(#3E6F55);
  rect(-h * 0.15, h * 0.35, h * 0.12, h * 0.20, 4);
  rect(h * 0.03, h * 0.35, h * 0.12, h * 0.20, 4);
  fill(#4A7E64);
  ellipse(-h * 0.25, h * 0.5, h * 0.6, h * 0.25);
  ellipse(h * 0.25, h * 0.5, h * 0.6, h * 0.25);
  fill(baju);
  rect(0, h * 0.3, h * 0.75, h * 0.85, 10);
  rect(-h * 0.4, h * 0.2, h * 0.12, h * 0.4, 5);
  rect(h * 0.3, h * 0.2, h * 0.12, h * 0.4, 5);
  fill(kulit);
  ellipse(0, 0, h, h);
  fill(rambut);
  arc(0, -h * 0.1, h, h * 0.85, PI, TWO_PI);
  fill(peci);
  rect(0, -h * 0.5, h * 0.84, h * 0.2, 4);
  fill(0);
  ellipse(-h * 0.18, 0, h * 0.12, h * 0.14);
  ellipse(h * 0.18, 0, h * 0.12, h * 0.14);
  stroke(0);
  strokeWeight(2);
  noFill();
  float r = h * 0.22;
  ellipse(-h * 0.18, 0, r, r);
  ellipse(h * 0.18, 0, r, r);
  line(-h * 0.11, 0, h * 0.11, 0);
  noStroke();
  stroke(150, 30, 30);
  strokeWeight(2);
  noFill();
  arc(0, h * 0.2, h * 0.3, h * 0.15, 0, PI);
  noStroke();
  popStyle();

  popMatrix();
}

// ============================================================
// UI & UTILITY
// ============================================================

void drawSceneText(String text) {
  fill(0, 0, 0, 150);
  rect(20, height - 50, width - 40, 40, 5);
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(12);
  text(text, 30, height - 30);
}

void drawSceneInfo() {
  fill(255, 255, 255, 200);
  rect(width - 140, 10, 130, 50, 5);
  fill(0);
  textAlign(LEFT, TOP);
  textSize(10);
  text("Scene: " + currentScene + "/" + maxScenes, width - 135, 25);
  text("Timer: " + (sceneDurations[currentScene - 1] - sceneTimer)/60 + "s", width - 135, 40);
}

// Gantikan fungsi drawAwan() Anda dengan yang ini
void drawAwan() {
  // Panggil bentuk awan yang konsisten untuk setiap awan
  // Kita bisa sedikit variasikan skalanya untuk memberi kesan jarak
  drawCloudShape(awanX1, 100, 1.0);  // Awan terdekat, ukuran normal
  drawCloudShape(awanX2, 130, 0.85); // Awan tengah, sedikit lebih kecil
  drawCloudShape(awanX3, 70, 0.9);   // Awan terjauh, ukuran medium
}

// Tambahkan fungsi BARU ini di mana saja di luar fungsi lain
// (Misalnya, tepat di bawah fungsi drawAwan)
void drawCloudShape(float x, float y, float scale) {
  pushMatrix();
  translate(x, y);
  scale(scale); // Terapkan skala ukuran
  
  noStroke();
  fill(255); // Warna putih pekat

  // Bentuk dasar awan yang ikonik
  // Terdiri dari 3 elips untuk bagian atas yang menggumpal
  ellipse(0, 0, 80, 80);       // Gumpalan tengah
  ellipse(-35, 10, 60, 60);    // Gumpalan kiri
  ellipse(35, 10, 70, 70);     // Gumpalan kanan
  
  // Dasar yang rata menggunakan persegi panjang dengan sudut bulat
  rectMode(CENTER);
  rect(0, 25, 100, 40, 20); 
  
  // Kembalikan mode gambar ke default jika diperlukan di bagian lain
  rectMode(CORNER); 
  popMatrix();
}

// ============================================================
// KEYBOARD CONTROLS
// ============================================================

void keyPressed() {
  if (key == ' ') {
    nextScene();
  } else if (key >= '1' && key <= '5') {
    currentScene = key - '0';
    sceneTimer = 0;
    resetCharacterPositions();
  }
}
