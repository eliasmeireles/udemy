package com.udemy.course.dogs.service

import com.udemy.course.dogs.model.Dog
import io.reactivex.Single
import retrofit2.http.GET

interface DogApi {

    @GET(value = "DevTides/DogsApi/master/dogs.json")
    fun getDogs(): Single<List<Dog>>
}