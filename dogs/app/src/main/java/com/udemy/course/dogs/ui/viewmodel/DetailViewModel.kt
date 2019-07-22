package com.udemy.course.dogs.ui.viewmodel

import android.app.Application
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.udemy.course.dogs.dao.DogDatabase
import com.udemy.course.dogs.model.Dog
import kotlinx.coroutines.launch

class DetailViewModel(application: Application) : BaseViewModel(application) {

    val dogs = MutableLiveData<Dog>()
    fun fetch(uuid: Int) {
        launch {
            val dog = DogDatabase(getApplication()).dogDao().getDog(uuid)
            dogs.value = dog
        }
    }
}