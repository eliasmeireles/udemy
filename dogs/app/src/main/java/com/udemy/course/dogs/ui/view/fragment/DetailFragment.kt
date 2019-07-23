package com.udemy.course.dogs.ui.view.fragment


import android.graphics.Bitmap
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
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
import com.udemy.course.dogs.model.DogPalette
import com.udemy.course.dogs.ui.viewmodel.DetailViewModel

class DetailFragment : Fragment() {

    private var dogUuid = 0
    private lateinit var detailViewModel: DetailViewModel
    private lateinit var detailBinding: FragmentDetailBinding

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        detailBinding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_detail,
            container,
            false
        )

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

    private fun observerViewModel() {
        detailViewModel.dogs.observe(this, Observer { dog ->
            dog?.let {
                detailBinding.dog = dog

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
                        .generate{palette ->  
                            val  vibranteColor = palette?.vibrantSwatch?.rgb ?: 0
                            val dogPalette = DogPalette(vibranteColor)
                            detailBinding.pallet = dogPalette
                        }
                }

            })
    }
}
