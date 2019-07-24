package com.udemy.course.dogs.ui.view.activity

import android.content.pm.PackageManager
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.navigation.ui.NavigationUI
import com.udemy.course.dogs.R
import com.udemy.course.dogs.delegate.ApplicationDelegate
import com.udemy.course.dogs.util.checkSmsPermission

class MainActivity : AppCompatActivity() {

    private lateinit var navController: NavController
    private lateinit var delegate: ApplicationDelegate.Permission

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        navController = Navigation.findNavController(this, R.id.fragment)
        NavigationUI.setupActionBarWithNavController(this, navController)
    }

    override fun onSupportNavigateUp(): Boolean {
        return NavigationUI.navigateUp(navController, null)
    }

    fun requestSmsPermission(delegate: ApplicationDelegate.Permission) {
        this.delegate = delegate
        this.checkSmsPermission(delegate)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when (requestCode) {
            delegate.permissionCode() -> {
                if (permissions.isEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    delegate.permissionGranted(true)
                } else delegate.permissionGranted(false)
            }
        }
    }
}
