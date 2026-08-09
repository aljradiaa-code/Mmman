package com.autoparts.inventory.core.domain.model

data class InventoryTransaction(
    val id: Long = 0,
    val productId: Long,
    val quantity: Int,
    val createdAt: Long = System.currentTimeMillis()
)
