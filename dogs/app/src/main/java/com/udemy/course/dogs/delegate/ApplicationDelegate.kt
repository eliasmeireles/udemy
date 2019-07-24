package com.udemy.course.dogs.delegate

interface ApplicationDelegate {
    interface Permission {
        fun permissionGranted(permissionGranted: Boolean)
        fun permissionCode(): Int
    }
}