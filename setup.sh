#!/bin/bash
# ============================================================
# Auto Parts Inventory - Complete Project Creator (GitHub Ready)
# ============================================================
set -e

PROJECT_NAME="auto-parts-inventory"
echo "🚀 Creating project: $PROJECT_NAME"

# Create project directory
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# ============================================================
# ROOT FILES
# ============================================================
cat > settings.gradle.kts << 'EOF'
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "AutoPartsInventory"
include(":app")
include(":core:common")
include(":core:database")
include(":core:domain")
include(":core:ui")
include(":engine:pdf")
include(":engine:inventory")
include(":engine:sales")
include(":engine:analytics")
include(":engine:forecast")
include(":engine:reorder")
include(":engine:audit")
include(":engine:export")
include(":feature:dashboard")
include(":feature:products")
include(":feature:import")
include(":feature:sales")
include(":feature:orders")
include(":feature:stock")
include(":feature:analytics")
include(":feature:settings")
include(":feature:setup")
EOF

cat > build.gradle.kts << 'EOF'
plugins {
    alias(libs.plugins.android.application) apply false
    alias(libs.plugins.android.library) apply false
    alias(libs.plugins.kotlin.android) apply false
    alias(libs.plugins.kotlin.compose) apply false
    alias(libs.plugins.hilt) apply false
    alias(libs.plugins.ksp) apply false
    alias(libs.plugins.kotlin.serialization) apply false
}
tasks.register("clean", Delete::class) {
    delete(rootProject.layout.buildDirectory)
}
EOF

cat > gradle.properties << 'EOF'
org.gradle.jvmargs=-Xmx4096m -Dfile.encoding=UTF-8
org.gradle.parallel=true
org.gradle.caching=true
android.useAndroidX=true
android.nonTransitiveRClass=true
kotlin.code.style=official
EOF

cat > .gitignore << 'EOF'
*.iml
.gradle
/local.properties
/.idea
.DS_Store
/build
/captures
.externalNativeBuild
.cxx
local.properties
*.apk
*.aab
*.ap_
*.dex
EOF

# ============================================================
# 🔴 CRITICAL: Gradle Wrapper Files
# ============================================================
echo "📦 Setting up Gradle Wrapper..."
mkdir -p gradle/wrapper

cat > gradle/wrapper/gradle-wrapper.properties << 'EOF'
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.9-bin.zip
networkTimeout=10000
validateDistributionUrl=true
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
EOF

# Download gradle-wrapper.jar from official source
echo "📥 Downloading gradle-wrapper.jar..."
curl -L -o gradle/wrapper/gradle-wrapper.jar \
  "https://github.com/gradle/gradle/raw/v8.9.0/gradle/wrapper/gradle-wrapper.jar"

if [ ! -f "gradle/wrapper/gradle-wrapper.jar" ] || [ ! -s "gradle/wrapper/gradle-wrapper.jar" ]; then
    echo "🔄 Trying alternative source..."
    curl -L -o gradle/wrapper/gradle-wrapper.jar \
      "https://raw.githubusercontent.com/gradle/gradle/v8.9.0/gradle/wrapper/gradle-wrapper.jar"
fi

# Create gradlew (Unix)
cat > gradlew << 'GRADLEW_EOF'
#!/bin/sh
APP_HOME="`pwd -P`"
CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar
if [ -n "$JAVA_HOME" ] ; then
    JAVACMD="$JAVA_HOME/bin/java"
else
    JAVACMD="java"
fi
exec "$JAVACMD" -Xmx64m -Xms64m -classpath "$CLASSPATH" org.gradle.wrapper.GradleWrapperMain "$@"
GRADLEW_EOF
chmod +x gradlew

# Create gradlew.bat (Windows)
cat > gradlew.bat << 'GRADLEW_BAT_EOF'
@echo off
set APP_HOME=%~dp0
set CLASSPATH=%APP_HOME%\gradle\wrapper\gradle-wrapper.jar
"%JAVA_HOME%\bin\java.exe" -Xmx64m -Xms64m -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %*
GRADLEW_BAT_EOF

echo "✅ Gradle Wrapper setup complete!"

# ============================================================
# libs.versions.toml
# ============================================================
mkdir -p gradle
cat > gradle/libs.versions.toml << 'EOF'
[versions]
kotlin = "2.0.21"
agp = "8.7.3"
coreKtx = "1.15.0"
lifecycleRuntimeKtx = "2.8.7"
activityCompose = "1.9.3"
composeBom = "2024.12.01"
navigationCompose = "2.8.5"
hiltNavigationCompose = "1.2.0"
room = "2.6.1"
hilt = "2.53.1"
ksp = "2.0.21-1.0.28"
coroutines = "1.9.0"
workManager = "2.10.0"
pdfbox = "2.0.31.0"
serialization = "1.7.3"
datastore = "1.1.1"
vico = "2.0.0-alpha.19"
junit = "4.13.2"
junitExt = "1.2.1"
espresso = "3.6.1"
mockk = "1.13.13"
turbine = "1.2.0"

[libraries]
androidx-core-ktx = { group = "androidx.core", name = "core-ktx", version.ref = "coreKtx" }
androidx-lifecycle-runtime-ktx = { group = "androidx.lifecycle", name = "lifecycle-runtime-ktx", version.ref = "lifecycleRuntimeKtx" }
androidx-lifecycle-runtime-compose = { group = "androidx.lifecycle", name = "lifecycle-runtime-compose", version.ref = "lifecycleRuntimeKtx" }
androidx-lifecycle-viewmodel-compose = { group = "androidx.lifecycle", name = "lifecycle-viewmodel-compose", version.ref = "lifecycleRuntimeKtx" }
androidx-activity-compose = { group = "androidx.activity", name = "activity-compose", version.ref = "activityCompose" }
androidx-compose-bom = { group = "androidx.compose", name = "compose-bom", version.ref = "composeBom" }
androidx-compose-ui = { group = "androidx.compose.ui", name = "ui" }
androidx-compose-ui-graphics = { group = "androidx.compose.ui", name = "ui-graphics" }
androidx-compose-ui-tooling = { group = "androidx.compose.ui", name = "ui-tooling" }
androidx-compose-ui-tooling-preview = { group = "androidx.compose.ui", name = "ui-tooling-preview" }
androidx-compose-material3 = { group = "androidx.compose.material3", name = "material3" }
androidx-compose-material-icons = { group = "androidx.compose.material", name = "material-icons-extended" }
androidx-navigation-compose = { group = "androidx.navigation", name = "navigation-compose", version.ref = "navigationCompose" }
hilt-android = { group = "com.google.dagger", name = "hilt-android", version.ref = "hilt" }
hilt-compiler = { group = "com.google.dagger", name = "hilt-compiler", version.ref = "hilt" }
hilt-navigation-compose = { group = "androidx.hilt", name = "hilt-navigation-compose", version.ref = "hiltNavigationCompose" }
room-runtime = { group = "androidx.room", name = "room-runtime", version.ref = "room" }
room-ktx = { group = "androidx.room", name = "room-ktx", version.ref = "room" }
room-compiler = { group = "androidx.room", name = "room-compiler", version.ref = "room" }
room-testing = { group = "androidx.room", name = "room-testing", version.ref = "room" }
coroutines-core = { group = "org.jetbrains.kotlinx", name = "kotlinx-coroutines-core", version.ref = "coroutines" }
coroutines-android = { group = "org.jetbrains.kotlinx", name = "kotlinx-coroutines-android", version.ref = "coroutines" }
coroutines-test = { group = "org.jetbrains.kotlinx", name = "kotlinx-coroutines-test", version.ref = "coroutines" }
work-runtime = { group = "androidx.work", name = "work-runtime-ktx", version.ref = "workManager" }
pdfbox-android = { group = "com.tom-roush", name = "pdfbox-android", version.ref = "pdfbox" }
kotlinx-serialization-json = { group = "org.jetbrains.kotlinx", name = "kotlinx-serialization-json", version.ref = "serialization" }
datastore-preferences = { group = "androidx.datastore", name = "datastore-preferences", version.ref = "datastore" }
vico-compose-m3 = { group = "com.patrykandpatrick.vico", name = "compose-m3", version.ref = "vico" }
junit = { group = "junit", name = "junit", version.ref = "junit" }
androidx-junit = { group = "androidx.test.ext", name = "junit", version.ref = "junitExt" }
androidx-espresso-core = { group = "androidx.test.espresso", name = "espresso-core", version.ref = "espresso" }
androidx-compose-ui-test-junit4 = { group = "androidx.compose.ui", name = "ui-test-junit4" }
androidx-compose-ui-test-manifest = { group = "androidx.compose.ui", name = "ui-test-manifest" }
mockk = { group = "io.mockk", name = "mockk", version.ref = "mockk" }
turbine = { group = "app.cash.turbine", name = "turbine", version.ref = "turbine" }

[plugins]
android-application = { id = "com.android.application", version.ref = "agp" }
android-library = { id = "com.android.library", version.ref = "agp" }
kotlin-android = { id = "org.jetbrains.kotlin.android", version.ref = "kotlin" }
kotlin-compose = { id = "org.jetbrains.kotlin.plugin.compose", version.ref = "kotlin" }
hilt = { id = "com.google.dagger.hilt.android", version.ref = "hilt" }
ksp = { id = "com.google.devtools.ksp", version.ref = "ksp" }
kotlin-serialization = { id = "org.jetbrains.kotlin.plugin.serialization", version.ref = "kotlin" }
EOF

# ============================================================
# GITHUB ACTIONS
# ============================================================
mkdir -p .github/workflows
cat > .github/workflows/build.yml << 'EOF'
name: Build & Test
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Set up JDK 17
      uses: actions/setup-java@v4
      with:
        java-version: '17'
        distribution: 'temurin'
        cache: gradle
    - name: Grant execute permission for gradlew
      run: chmod +x gradlew
    - name: Build Debug APK
      run: ./gradlew assembleDebug --stacktrace
    - name: Upload Debug APK
      uses: actions/upload-artifact@v4
      with:
        name: app-debug
        path: app/build/outputs/apk/debug/app-debug.apk
EOF

# ============================================================
# APP MODULE
# ============================================================
mkdir -p app/src/main/java/com/autoparts/inventory
mkdir -p app/src/main/res/values

cat > app/build.gradle.kts << 'EOF'
plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.kotlin.compose)
    alias(libs.plugins.hilt)
    alias(libs.plugins.ksp)
}
android {
    namespace = "com.autoparts.inventory"
    compileSdk = 35
    defaultConfig {
        applicationId = "com.autoparts.inventory"
        minSdk = 26
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
    buildFeatures { compose = true }
}
dependencies {
    implementation(project(":core:common"))
    implementation(project(":core:database"))
    implementation(project(":core:domain"))
    implementation(project(":core:ui"))
    implementation(project(":engine:pdf"))
    implementation(project(":engine:inventory"))
    implementation(project(":engine:sales"))
    implementation(project(":engine:analytics"))
    implementation(project(":engine:forecast"))
    implementation(project(":engine:reorder"))
    implementation(project(":engine:audit"))
    implementation(project(":engine:export"))
    implementation(project(":feature:dashboard"))
    implementation(project(":feature:products"))
    implementation(project(":feature:import"))
    implementation(project(":feature:sales"))
    implementation(project(":feature:orders"))
    implementation(project(":feature:stock"))
    implementation(project(":feature:analytics"))
    implementation(project(":feature:settings"))
    implementation(project(":feature:setup"))
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.lifecycle.runtime.ktx)
    implementation(libs.androidx.activity.compose)
    implementation(platform(libs.androidx.compose.bom))
    implementation(libs.androidx.compose.ui)
    implementation(libs.androidx.compose.ui.graphics)
    implementation(libs.androidx.compose.ui.tooling.preview)
    implementation(libs.androidx.compose.material3)
    implementation(libs.androidx.navigation.compose)
    implementation(libs.hilt.android)
    ksp(libs.hilt.compiler)
    implementation(libs.hilt.navigation.compose)
    implementation(libs.work.runtime)
    debugImplementation(libs.androidx.compose.ui.tooling)
}
EOF

cat > app/proguard-rules.pro << 'EOF'
-keep class com.autoparts.inventory.core.database.entity.** { *; }
-keep class com.autoparts.inventory.core.domain.model.** { *; }
EOF

cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <application
        android:name=".AutoPartsApp"
        android:allowBackup="true"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/Theme.AutoPartsInventory">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:theme="@style/Theme.AutoPartsInventory">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

cat > app/src/main/res/values/strings.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">إدارة قطع الغيار</string>
</resources>
EOF

cat > app/src/main/res/values/themes.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="Theme.AutoPartsInventory" parent="android:Theme.Material.Light.NoActionBar" />
</resources>
EOF

cat > app/src/main/java/com/autoparts/inventory/AutoPartsApp.kt << 'EOF'
package com.autoparts.inventory

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class AutoPartsApp : Application()
EOF

cat > app/src/main/java/com/autoparts/inventory/MainActivity.kt << 'EOF'
package com.autoparts.inventory

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.ui.Modifier
import com.autoparts.inventory.core.ui.theme.AutoPartsTheme
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AutoPartsTheme {
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
                    Text("🚀 Auto Parts Inventory - Ready!")
                }
            }
        }
    }
}
EOF

echo "✅ App module created"

# ============================================================
# CORE MODULES (Helper Function)
# ============================================================
create_lib_module() {
    local module_path=$1
    local namespace=$2
    local extra_deps=$3
    
    mkdir -p "$module_path/src/main/java/${namespace//.//}"
    
    cat > "$module_path/build.gradle.kts" << EOF
plugins {
    alias(libs.plugins.android.library)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.hilt)
    alias(libs.plugins.ksp)
}
android {
    namespace = "$namespace"
    compileSdk = 35
    defaultConfig { minSdk = 26 }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
}
dependencies {
    implementation(libs.hilt.android)
    ksp(libs.hilt.compiler)
    implementation(libs.coroutines.core)
    $extra_deps
    testImplementation(libs.junit)
}
EOF
}

# ============================================================
# CORE: COMMON
# ============================================================
create_lib_module "core/common" "com.autoparts.inventory.core.common" ""
mkdir -p core/common/src/main/java/com/autoparts/inventory/core/common/util

cat > core/common/src/main/java/com/autoparts/inventory/core/common/util/PartNumberNormalizer.kt << 'EOF'
package com.autoparts.inventory.core.common.util

object PartNumberNormalizer {
    fun normalize(raw: String): String = raw.trim().uppercase()
        .replace("\\s+".toRegex(), "")
        .replace("[^A-Z0-9\\-]".toRegex(), "")
        .replace("-{2,}".toRegex(), "-")
}
EOF

cat > core/common/src/main/java/com/autoparts/inventory/core/common/util/FileHashGenerator.kt << 'EOF'
package com.autoparts.inventory.core.common.util

import java.io.InputStream
import java.security.MessageDigest

object FileHashGenerator {
    fun generateSHA256(inputStream: InputStream): String {
        val digest = MessageDigest.getInstance("SHA-256")
        val buffer = ByteArray(8192)
        var bytesRead: Int
        while (inputStream.read(buffer).also { bytesRead = it } != -1) {
            digest.update(buffer, 0, bytesRead)
        }
        return digest.digest().joinToString("") { "%02x".format(it) }
    }
}
EOF

# ============================================================
# CORE: DOMAIN
# ============================================================
create_lib_module "core/domain" "com.autoparts.inventory.core.domain" ""
mkdir -p core/domain/src/main/java/com/autoparts/inventory/core/domain/model
mkdir -p core/domain/src/main/java/com/autoparts/inventory/core/domain/error

cat > core/domain/src/main/java/com/autoparts/inventory/core/domain/model/Product.kt << 'EOF'
package com.autoparts.inventory.core.domain.model

data class Product(
    val id: Long = 0,
    val partNumber: String,
    val partNumberNormalized: String,
    val description: String?,
    val isActive: Boolean = true
)
EOF

cat > core/domain/src/main/java/com/autoparts/inventory/core/domain/model/InventoryTransaction.kt << 'EOF'
package com.autoparts.inventory.core.domain.model

data class InventoryTransaction(
    val id: Long = 0,
    val productId: Long,
    val quantity: Int,
    val createdAt: Long = System.currentTimeMillis()
)
EOF

cat > core/domain/src/main/java/com/autoparts/inventory/core/domain/error/AppError.kt << 'EOF'
package com.autoparts.inventory.core.domain.error

sealed class AppError(override val message: String) : Exception(message) {
    data class PdfReadError(val file: String) : AppError("Failed to read PDF: $file")
    data class InsufficientStockError(val productId: Long) : AppError("Insufficient stock")
}
EOF

# ============================================================
# CORE: DATABASE
# ============================================================
create_lib_module "core/database" "com.autoparts.inventory.core.database" "
    implementation(libs.room.runtime)
    implementation(libs.room.ktx)
    ksp(libs.room.compiler)
"

mkdir -p core/database/src/main/java/com/autoparts/inventory/core/database/entity
mkdir -p core/database/src/main/java/com/autoparts/inventory/core/database/dao

cat > core/database/src/main/java/com/autoparts/inventory/core/database/AppDatabase.kt << 'EOF'
package com.autoparts.inventory.core.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.autoparts.inventory.core.database.entity.ProductEntity

@Database(entities = [ProductEntity::class], version = 1, exportSchema = false)
abstract class AppDatabase : RoomDatabase() {
    abstract fun productsDao(): com.autoparts.inventory.core.database.dao.ProductsDao
}
EOF

cat > core/database/src/main/java/com/autoparts/inventory/core/database/DatabaseModule.kt << 'EOF'
package com.autoparts.inventory.core.database

import android.content.Context
import androidx.room.Room
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object DatabaseModule {
    @Provides @Singleton
    fun provideDatabase(@ApplicationContext context: Context): AppDatabase =
        Room.databaseBuilder(context, AppDatabase::class.java, "auto_parts_inventory.db")
            .fallbackToDestructiveMigration().build()

    @Provides
    fun provideProductsDao(db: AppDatabase) = db.productsDao()
}
EOF

cat > core/database/src/main/java/com/autoparts/inventory/core/database/entity/ProductEntity.kt << 'EOF'
package com.autoparts.inventory.core.database.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "products")
data class ProductEntity(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    val partNumber: String,
    val partNumberNormalized: String,
    val description: String?,
    val isActive: Boolean = true
)
EOF

cat > core/database/src/main/java/com/autoparts/inventory/core/database/dao/ProductsDao.kt << 'EOF'
package com.autoparts.inventory.core.database.dao

import androidx.room.*
import com.autoparts.inventory.core.database.entity.ProductEntity
import kotlinx.coroutines.flow.Flow

@Dao
interface ProductsDao {
    @Query("SELECT * FROM products WHERE isActive = 1")
    fun getAllProducts(): Flow<List<ProductEntity>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(product: ProductEntity): Long
}
EOF

# ============================================================
# CORE: UI
# ============================================================
mkdir -p core/ui/src/main/java/com/autoparts/inventory/core/ui/theme

cat > core/ui/build.gradle.kts << 'EOF'
plugins {
    alias(libs.plugins.android.library)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.kotlin.compose)
}
android {
    namespace = "com.autoparts.inventory.core.ui"
    compileSdk = 35
    defaultConfig { minSdk = 26 }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
    buildFeatures { compose = true }
}
dependencies {
    implementation(platform(libs.androidx.compose.bom))
    implementation(libs.androidx.compose.ui)
    implementation(libs.androidx.compose.material3)
    debugImplementation(libs.androidx.compose.ui.tooling)
}
EOF

cat > core/ui/src/main/java/com/autoparts/inventory/core/ui/theme/Theme.kt << 'EOF'
package com.autoparts.inventory.core.ui.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.*
import androidx.compose.runtime.Composable

private val DarkColorScheme = darkColorScheme()
private val LightColorScheme = lightColorScheme()

@Composable
fun AutoPartsTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colorScheme = if (darkTheme) DarkColorScheme else LightColorScheme
    MaterialTheme(colorScheme = colorScheme, content = content)
}
EOF

# ============================================================
# ENGINE MODULES (Placeholders)
# ============================================================
echo "📝 Creating engine modules..."
for engine in pdf inventory sales analytics forecast reorder audit export; do
    create_lib_module "engine/$engine" "com.autoparts.inventory.engine.$engine" ""
    mkdir -p "engine/$engine/src/main/java/com/autoparts/inventory/engine/$engine"
    cat > "engine/$engine/src/main/java/com/autoparts/inventory/engine/$engine/${engine^}Engine.kt" << EOF
package com.autoparts.inventory.engine.$engine

class ${engine^}Engine {
    // Implementation coming soon
}
EOF
done

# ============================================================
# FEATURE MODULES (Placeholders)
# ============================================================
echo "📝 Creating feature modules..."
for feature in dashboard products import sales orders stock analytics settings setup; do
    mkdir -p "feature/$feature/src/main/java/com/autoparts/inventory/feature/$feature"
    
    cat > "feature/$feature/build.gradle.kts" << EOF
plugins {
    alias(libs.plugins.android.library)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.kotlin.compose)
    alias(libs.plugins.hilt)
    alias(libs.plugins.ksp)
}
android {
    namespace = "com.autoparts.inventory.feature.$feature"
    compileSdk = 35
    defaultConfig { minSdk = 26 }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
    buildFeatures { compose = true }
}
dependencies {
    implementation(project(":core:ui"))
    implementation(project(":core:domain"))
    implementation(platform(libs.androidx.compose.bom))
    implementation(libs.androidx.compose.ui)
    implementation(libs.androidx.compose.material3)
    implementation(libs.hilt.android)
    ksp(libs.hilt.compiler)
}
EOF

    # Capitalize first letter
    FeatureName="$(echo ${feature:0:1} | tr '[:lower:]' '[:upper:]')${feature:1}"
    
    cat > "feature/$feature/src/main/java/com/autoparts/inventory/feature/$feature/${FeatureName}Screen.kt" << EOF
package com.autoparts.inventory.feature.$feature

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier

@Composable
fun ${FeatureName}Screen() {
    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Text("$FeatureName Screen - Coming Soon")
    }
}
EOF
done

echo "✅ All modules created!"

# ============================================================
# Initialize Git
# ============================================================
echo "🔧 Initializing Git..."
git init
git config user.email "github-actions@github.com"
git config user.name "GitHub Actions"
git add .
git commit -m "Initial commit: Auto Parts Inventory System" || echo "Nothing to commit"

echo ""
echo "🎉 Project created successfully!"
echo "📁 Location: $(pwd)"
