package com.udemy.course.dogs.ui.view.fragment

import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.Navigation
import androidx.recyclerview.widget.LinearLayoutManager
import com.udemy.course.dogs.R
import com.udemy.course.dogs.ui.adapter.DogAdapter
import com.udemy.course.dogs.ui.viewmodel.ListViewModel
import kotlinx.android.synthetic.main.fragment_list.*

class ListFragment : Fragment() {

    private lateinit var viewModel: ListViewModel
    private var dogAdapter: DogAdapter = DogAdapter(arrayListOf())

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        setHasOptionsMenu(true)
        return inflater.inflate(R.layout.fragment_list, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel = ViewModelProviders.of(this).get(ListViewModel::class.java)
        viewModel.refresh()

        dogsList.apply {
            layoutManager = LinearLayoutManager(context)
            adapter = dogAdapter
        }

        observerViewModel()

        refreshLayout.setOnRefreshListener {
            listError.visibility = View.GONE
            dogsList.visibility = View.GONE
            loadingView.visibility = View.VISIBLE
            viewModel.refreshByPassCache()
            refreshLayout.isRefreshing = false
        }
    }

    override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
        inflater.inflate(R.menu.menu, menu)
        super.onCreateOptionsMenu(menu, inflater)
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        when (item.itemId) {
             R.id.prefSetting -> {
                 val settingFragment = ListFragmentDirections.actionSettingFragment()
                 view?.let { Navigation.findNavController(it).navigate(settingFragment) }
             }
        }
        return super.onOptionsItemSelected(item)
    }

    private fun observerViewModel() {
        viewModel.dogsLiveData.observe(this, Observer { dogs ->
            dogsList.visibility = View.VISIBLE
            dogAdapter.updateDogList(dogList = dogs)
        })

        viewModel.loadError.observe(this, Observer { isError ->
            isError?.let {
                listError.visibility = if (isError) View.VISIBLE else View.GONE
            }
        })

        viewModel.loading.observe(this, Observer { isLoading ->
            isLoading?.let {
                loadingView.visibility = if (it) View.VISIBLE else View.GONE

                if (isLoading) {
                    listError.visibility = View.GONE
                    dogsList.visibility = View.GONE
                }
            }
        })
    }

}
