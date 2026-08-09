package com.autoparts.inventory.core.database

import androidx.room.Database
import androidx.room.RoomDatabase
import com.autoparts.inventory.core.database.entity.ProductEntity

@Database(entities = [ProductEntity::class], version = 1, exportSchema = false)
abstract class AppDatabase : RoomDatabase() {
    abstract fun productsDao(): com.autoparts.inventory.core.database.dao.ProductsDao
}
