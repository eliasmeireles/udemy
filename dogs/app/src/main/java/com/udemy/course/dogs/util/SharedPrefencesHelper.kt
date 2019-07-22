package com.udemy.course.dogs.util

import android.content.Context
import android.content.SharedPreferences
import androidx.core.content.edit
import androidx.preference.PreferenceManager

class SharedPrefencesHelper {

    companion object {
        private const val PREF_TIME = "Pref_time"
        private var prefs: SharedPreferences? = null

        @Volatile private var instance: SharedPrefencesHelper ? = null
        private val LOCK = Any()
        operator fun invoke(context: Context): SharedPrefencesHelper = instance ?: synchronized(LOCK) {
            instance?: buildHelper(context).also {
                instance = it
            }
        }

        private fun buildHelper(context: Context) : SharedPrefencesHelper {
            prefs = PreferenceManager.getDefaultSharedPreferences(context)
            return SharedPrefencesHelper()
        }
    }

    fun saveUpdateTime(prefTime: Long) {
        prefs?.edit(commit = true) {putLong(PREF_TIME, prefTime)}
    }

    fun getUpdateTime() = prefs?.getLong(PREF_TIME, 0)
}