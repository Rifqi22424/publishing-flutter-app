import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// RILIS langkah 4 (tanda tangan): baca android/key.properties.
// File ini TIDAK di-commit (sudah ada di android/.gitignore).
// Contoh isinya: android/key.properties.example
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "id.ac.nusaputra.nusajantung"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // RILIS langkah 1 (identitas): ID unik aplikasi di Play Store.
        // Tidak bisa diubah lagi setelah aplikasi diunggah.
        applicationId = "id.ac.nusaputra.nusajantung"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Diambil dari pubspec.yaml -> version: 1.0.0+1
        versionCode = flutter.versionCode // 1
        versionName = flutter.versionName // 1.0.0
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }

    buildTypes {
        release {
            // Pakai kunci upload jika key.properties ada.
            // Jika belum ada (misalnya baru clone), pakai kunci debug
            // supaya `flutter run --release` tetap bisa dicoba.
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}
