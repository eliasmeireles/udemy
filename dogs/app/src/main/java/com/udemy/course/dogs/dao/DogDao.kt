package com.udemy.course.dogs.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import com.udemy.course.dogs.model.Dog

@Dao
interface DogDao {

    @Insert
    suspend fun insertAll(vararg dogs: Dog): List<Long>

    @Query(value = "SELECT * FROM dog")
    suspend fun getAll(): List<Dog>

    @Query(value = "SELECT * FROM dog WHERE uuid = :dogId")
    suspend fun getDog(dogId: Int): Dog

    @Query(value = "DELETE FROM dog")
    suspend fun deleteAllDogs()

    @Query(value = "DELETE FROM dog WHERE uuid = :dogId")
    suspend fun deleteDog(dogId: Int)
}