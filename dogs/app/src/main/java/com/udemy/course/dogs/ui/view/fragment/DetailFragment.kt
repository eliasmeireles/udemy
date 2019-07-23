package com.udemy.course.dogs.ui.view.fragment


import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import com.udemy.course.dogs.R
import com.udemy.course.dogs.databinding.FragmentDetailBinding
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
            }
        })
    }
}
