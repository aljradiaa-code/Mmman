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
