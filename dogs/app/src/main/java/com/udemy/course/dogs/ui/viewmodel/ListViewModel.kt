package com.udemy.course.dogs.ui.viewmodel

import android.app.Application
import androidx.lifecycle.MutableLiveData
import com.udemy.course.dogs.dao.DogDatabase
import com.udemy.course.dogs.model.Dog
import com.udemy.course.dogs.service.DogsApiService
import com.udemy.course.dogs.util.NotificationsHelper
import com.udemy.course.dogs.util.SharedPrefencesHelper
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.observers.DisposableSingleObserver
import io.reactivex.schedulers.Schedulers
import kotlinx.coroutines.launch
import java.lang.NumberFormatException

class ListViewModel(application: Application) : BaseViewModel(application = application) {

    private var refreshTime = 5 * 60 * 1000 * 1000 * 1000L
    private val prefHelper = SharedPrefencesHelper(getApplication())
    private val dogsService = DogsApiService()
    private val disposable = CompositeDisposable()

    val dogsLiveData = MutableLiveData<List<Dog>>()
    val loadError = MutableLiveData<Boolean>()
    val loading = MutableLiveData<Boolean>()

    fun refresh() {
        checkCacheDuration()
        val updateTime = prefHelper.getUpdateTime()
        if (updateTime != null && updateTime != 0L && System.nanoTime() - updateTime < refreshTime)
            fetchFromDatabase()
        else requestDogList()
    }

    private fun checkCacheDuration() {
        val cacheDuration = prefHelper.getCacheDuration()
        try {
            val cacheDurationInt = cacheDuration?.toInt() ?: 5 * 60
            refreshTime = cacheDurationInt.times( 1000 * 1000 * 1000L)
        } catch (e: NumberFormatException) {
            e.printStackTrace()
        }
    }

    fun refreshByPassCache() = requestDogList()

    private fun fetchFromDatabase() {
        loading.value = true
        launch {
            val allDogs = DogDatabase(getApplication()).dogDao().getAll()
            dogRetrieved(allDogs)
        }
    }

    private fun requestDogList() {
        loading.value = true
        disposable.add(
            dogsService.getDogs()
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeWith(object : DisposableSingleObserver<List<Dog>>() {
                    override fun onSuccess(dogs: List<Dog>) {
                        storeDogsLocally(dogs)
                        NotificationsHelper(getApplication()).createNotification()
                    }

                    override fun onError(e: Throwable) {
                        loading.value = false
                        loadError.value = true
                        e.printStackTrace()
                    }
                })
        )
    }

    private fun dogRetrieved(dogs: List<Dog>) {
        loading.value = false
        loadError.value = false
        dogsLiveData.value = dogs
    }

    private fun storeDogsLocally(dogs: List<Dog>) {
        launch {
            val dao = DogDatabase(getApplication()).dogDao()
            dao.deleteAllDogs()
            val result = dao.insertAll(dogs = *dogs.toTypedArray())
            for (i in 0 until dogs.size) {
                dogs[i].uuid = result[i]
                println(result[i])
            }
            dogRetrieved(dogs)
        }
        prefHelper.saveUpdateTime(System.nanoTime())
    }

    override fun onCleared() {
        super.onCleared()
        disposable.clear()
    }
}