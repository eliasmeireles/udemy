package com.udemy.course.dogs.ui.view.fragment


import android.app.PendingIntent
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.telephony.SmsManager
import android.view.*
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.palette.graphics.Palette
import com.bumptech.glide.Glide
import com.bumptech.glide.request.target.CustomTarget
import com.bumptech.glide.request.transition.Transition
import com.udemy.course.dogs.R
import com.udemy.course.dogs.databinding.FragmentDetailBinding
import com.udemy.course.dogs.databinding.SendSmsDialogBinding
import com.udemy.course.dogs.delegate.ApplicationDelegate
import com.udemy.course.dogs.model.Dog
import com.udemy.course.dogs.model.DogPalette
import com.udemy.course.dogs.model.SmsInfo
import com.udemy.course.dogs.ui.view.activity.MainActivity
import com.udemy.course.dogs.ui.viewmodel.DetailViewModel
import com.udemy.course.dogs.util.PERMISSION_SEND_SMS

class DetailFragment : Fragment() {

    private val getUserPermission = SendSmsDelegate()
    private var currentDog: Dog? = null
    private var dogUuid = 0
    private lateinit var detailViewModel: DetailViewModel
    private lateinit var detailBinding: FragmentDetailBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        detailBinding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_detail,
            container,
            false
        )
        setHasOptionsMenu(true)
        return detailBinding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        arguments?.let {
            dogUuid = DetailFragmentArgs.fromBundle(it).dogUuid
        }

        detailViewModel = ViewModelProviders.of(this).get(DetailViewModel::class.java)
        detailViewModel.fetch(dogUuid)

        observerViewModel()
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        super.onCreateOptionsMenu(menu, inflater)
        inflater.inflate(R.menu.detail_menu, menu)
    }


    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
            R.id.action_send_sms -> {
                (activity as MainActivity).requestSmsPermission(getUserPermission)
            }
            R.id.action_share -> {
                val intent = Intent(Intent.ACTION_SEND)
                intent.type = "text/plain"
                intent.putExtra(Intent.EXTRA_SUBJECT, "Check out this dog breed")
                intent.putExtra(Intent.EXTRA_TEXT, "${currentDog?.dogBreed} bred for ${currentDog?.bredFor}")
                intent.putExtra(Intent.EXTRA_STREAM, currentDog?.imageUrl)
                startActivity(Intent.createChooser(intent, "Share with"))
            }
        }
        return super.onOptionsItemSelected(item)
    }

    private fun observerViewModel() {
        detailViewModel.dogs.observe(this, Observer { dog ->
            dog?.let {
                detailBinding.dog = dog
                currentDog = dog
                dog.imageUrl?.let {
                    setUpBackgroundColor(dog.imageUrl)
                }
            }
        })
    }

    private fun setUpBackgroundColor(url: String) {
        Glide.with(this)
            .asBitmap()
            .load(url)
            .into(object : CustomTarget<Bitmap>() {
                override fun onLoadCleared(placeholder: Drawable?) {

                }

                override fun onResourceReady(resource: Bitmap, transition: Transition<in Bitmap>?) {
                    Palette.from(resource)
                        .generate { palette ->
                            val vibrantColor = palette?.vibrantSwatch?.rgb ?: 0
                            val dogPalette = DogPalette(vibrantColor)
                            detailBinding.pallet = dogPalette
                        }
                }

            })
    }

    private inner class SendSmsDelegate : ApplicationDelegate.Permission {

        override fun permissionGranted(permissionGranted: Boolean) {
            if (!permissionGranted) Toast.makeText(
                context,
                "Permission was granted denied!",
                Toast.LENGTH_LONG
            ).show()
            else {
                context?.let {
                    val smsInfo = SmsInfo(
                        "",
                        "${currentDog?.dogBreed} bred for ${currentDog?.bredFor}",
                        currentDog?.imageUrl
                    )


                    val smsDialogBinding = DataBindingUtil.inflate<SendSmsDialogBinding>(
                        LayoutInflater.from(it),
                        R.layout.send_sms_dialog,
                        null,
                        false
                    )

                    AlertDialog.Builder(it)
                        .setView(smsDialogBinding.root)
                        .setPositiveButton("Send SMS") { _, _ ->
                            if (!smsDialogBinding.smsDestination.text.isNullOrEmpty()) {
                                smsInfo.to = smsDialogBinding.smsDestination.text.toString()
                                sendSms(smsInfo)
                            }
                        }.setNegativeButton("Cancel") { _, _ -> }
                        .show()

                    smsDialogBinding.smsInfo = smsInfo
                }
            }
        }

        override fun permissionCode(): Int {
            return PERMISSION_SEND_SMS
        }

        private fun sendSms(smsInfo: SmsInfo) {
            val intent = Intent(context, MainActivity::class.java)
            val pendingIntent = PendingIntent.getActivity(context, 0, intent, 0)
            val smsManager = SmsManager.getDefault()
            smsManager.sendTextMessage(smsInfo.to, null, smsInfo.text, pendingIntent, null)
        }
    }
}
