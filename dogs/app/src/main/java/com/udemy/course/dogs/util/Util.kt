package com.udemy.course.dogs.util

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.widget.ImageView
import androidx.appcompat.app.AlertDialog
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.databinding.BindingAdapter
import androidx.swiperefreshlayout.widget.CircularProgressDrawable
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.udemy.course.dogs.R
import com.udemy.course.dogs.delegate.ApplicationDelegate

const val PERMISSION_SEND_SMS = 234

fun getProgressDrawable(context: Context): CircularProgressDrawable {
    return CircularProgressDrawable(context).apply {
        strokeWidth = 10f
        centerRadius = 50f
        start()
    }
}

fun ImageView.loadImage(uri: String?, progressDrawable: CircularProgressDrawable) {
    val options = RequestOptions()
        .placeholder(progressDrawable)
        .error(R.mipmap.ic_launcher)

    Glide.with(context)
        .setDefaultRequestOptions(options)
        .load(uri)
        .into(this)
}

@BindingAdapter(value = ["android:imageUrl"])
fun loadImage(view: ImageView, url: String?) {
    view.loadImage(uri = url, progressDrawable = getProgressDrawable(view.context))
}

fun Activity.checkSmsPermission(delegate: ApplicationDelegate.Permission) {
    if (ContextCompat.checkSelfPermission(this, Manifest.permission.SEND_SMS) != PackageManager.PERMISSION_GRANTED) {
        if (ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission.SEND_SMS)) {
            AlertDialog.Builder(this)
                .setTitle("Send SMS permission")
                .setMessage("This app requires access to send a SMS.")
                .setPositiveButton("Ask me") { _, _ ->
                    this.requestSmsPermission()
                }
                .setNegativeButton("No") { _, _ -> delegate.permissionGranted(false)}
                .show()
        } else {
            this.requestSmsPermission()
        }
    } else {
        delegate.permissionGranted(true)
    }
}

private fun Activity.requestSmsPermission() {
    ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.SEND_SMS), PERMISSION_SEND_SMS)
}