package com.udemy.course.dogs.ui.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.udemy.course.dogs.R
import com.udemy.course.dogs.databinding.ItemDogBinding
import com.udemy.course.dogs.model.Dog
import com.udemy.course.dogs.ui.view.fragment.ListFragmentDirections
import com.udemy.course.dogs.ui.view.listener.DogClickListener
import com.udemy.course.dogs.util.getProgressDrawable
import com.udemy.course.dogs.util.loadImage
import kotlinx.android.synthetic.main.item_dog.view.*

class DogAdapter(val dogList: ArrayList<Dog>) : RecyclerView.Adapter<DogAdapter.DogViewHolder>(), DogClickListener {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DogViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        val itemView =
            DataBindingUtil.inflate<ItemDogBinding>(inflater, R.layout.item_dog, parent, false)
        return DogViewHolder(itemView)
    }

    override fun getItemCount() = dogList.size

    fun updateDogList(dogList: List<Dog>) {
        this.dogList.clear()
        this.dogList.addAll(dogList)
        notifyDataSetChanged()
    }

    override fun onBindViewHolder(holder: DogViewHolder, position: Int) {
        holder.view.dog = dogList[position]
        holder.view.listener = this
    }


    override fun onDogClicked(view: View) {
        val actionDetailFragment = ListFragmentDirections.actionDetailFragment()
            actionDetailFragment.dogUuid = view.dogId.text.toString().toInt()
            Navigation.findNavController(view).navigate(actionDetailFragment)
    }

    class DogViewHolder(var view: ItemDogBinding) : RecyclerView.ViewHolder(view.root)
}