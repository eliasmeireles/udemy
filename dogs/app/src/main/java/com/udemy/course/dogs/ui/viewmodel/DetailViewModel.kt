package com.udemy.course.dogs.ui.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.udemy.course.dogs.model.Dog

class DetailViewModel : ViewModel() {

    val dogs = MutableLiveData<Dog>()
    fun fetch() {
        val dog = Dog(
                breedId = "1",
                dogBreed = "Corgi",
                bredFor = "BredFor",
                imageUrl = "imageUrl",
                breedGroup = "BredGroup",
                lifeSpan = "15 years",
                temperament = "temperament"
        )
        dogs.value = dog
    }
}