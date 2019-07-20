package com.udemy.course.dogs.ui.adapter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.udemy.course.dogs.R
import com.udemy.course.dogs.model.Dog
import com.udemy.course.dogs.ui.view.fragment.ListFragmentDirections
import kotlinx.android.synthetic.main.item_dog.view.*

class DogAdapter(val dogList: ArrayList<Dog>) : RecyclerView.Adapter<DogAdapter.DogViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DogViewHolder {
        val itemView = LayoutInflater.from(parent.context).inflate(R.layout.item_dog, parent, false)
        return DogViewHolder(itemView)
    }

    override fun getItemCount() = dogList.size

    fun updateDogList(dogList: List<Dog>) {
        this.dogList.clear()
        this.dogList.addAll(dogList)
        notifyDataSetChanged()
    }
    override fun onBindViewHolder(holder: DogViewHolder, position: Int) {
        holder.itemView.dogName.text = dogList[position].dogBreed
        holder.itemView.lifespan.text = dogList[position].lifeSpan

        holder.itemView.setOnClickListener {
            Navigation.findNavController(it).navigate(ListFragmentDirections.actionDetailFragment())
        }
    }


    class DogViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

    }
}