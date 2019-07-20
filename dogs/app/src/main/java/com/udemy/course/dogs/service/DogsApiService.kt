package com.udemy.course.dogs.service

import com.udemy.course.dogs.BuildConfig.API_BASE_URL
import com.udemy.course.dogs.model.Dog
import io.reactivex.Single
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory

class DogsApiService {

    private val api = Retrofit.Builder()
        .baseUrl(API_BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
        .build()
        .create(DogApi::class.java)

    fun getDogs(): Single<List<Dog>> = api.getDogs()
}