package com.autoparts.inventory.core.common.util

object PartNumberNormalizer {
    fun normalize(raw: String): String = raw.trim().uppercase()
        .replace("\\s+".toRegex(), "")
        .replace("[^A-Z0-9\\-]".toRegex(), "")
        .replace("-{2,}".toRegex(), "-")
}
