package com.autoparts.inventory.core.domain.error

sealed class AppError(override val message: String) : Exception(message) {
    data class PdfReadError(val file: String) : AppError("Failed to read PDF: $file")
    data class InsufficientStockError(val productId: Long) : AppError("Insufficient stock")
}
