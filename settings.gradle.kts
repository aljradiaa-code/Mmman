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
