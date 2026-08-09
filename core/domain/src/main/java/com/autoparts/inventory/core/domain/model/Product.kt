package com.autoparts.inventory.core.domain.model

data class Product(
    val id: Long = 0,
    val partNumber: String,
    val partNumberNormalized: String,
    val description: String?,
    val isActive: Boolean = true
)
