package com.udemy.course.dogs.model

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey
import com.google.gson.annotations.SerializedName

@Entity
data class Dog(

    @ColumnInfo(name = "bred_id")
    @SerializedName(value = "id")
    val breedId: String?,

    @ColumnInfo(name = "bred_name")
    @SerializedName(value = "name")
    val dogBreed: String?,

    @ColumnInfo(name = "life_span")
    @SerializedName(value = "life_span")
    val lifeSpan: String?,

    @ColumnInfo(name = "bred_group")
    @SerializedName(value = "bred_group")
    val breedGroup: String?,

    @ColumnInfo(name = "bred_for")
    @SerializedName(value = "bred_for")
    val bredFor: String?,

    @ColumnInfo(name = "temperament")
    @SerializedName(value = "temperament")
    val temperament: String?,

    @ColumnInfo(name = "dog_url")
    @SerializedName(value = "url")
    val imageUrl: String?
) {
    @PrimaryKey(autoGenerate = true)
    var uuid: Long = 0
}

data class DogPalette(var color: Int)

data class SmsInfo(
    var to: String,
    var text: String,
    val imageUrl: String?
)