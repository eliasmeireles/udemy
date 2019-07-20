package com.udemy.course.dogs.ui.view.fragment


import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.navigation.Navigation
import com.udemy.course.dogs.R
import kotlinx.android.synthetic.main.fragment_detail.*

class DetailFragment : Fragment() {

    private var dogUuid = 0

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?,
                              savedInstanceState: Bundle?): View? {
        return inflater.inflate(R.layout.fragment_detail, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        arguments?.let {
            dogUuid = DetailFragmentArgs.fromBundle(it).dogUuid
            Toast.makeText(view.context, "$dogUuid", Toast.LENGTH_LONG).show()
        }

        floatingActionButtonList.setOnClickListener {
            val actionDetailFragment = DetailFragmentDirections.actionListFragment()
            Navigation.findNavController(it).navigate(actionDetailFragment)
        }
    }
}
