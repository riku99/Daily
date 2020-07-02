import Vue from 'vue'
import Router from 'vue-router'
import Lists from '../lists.vue'
import List from '../list.vue'
import NewList from '../new_list.vue'
import EditList from '../edit_list.vue'
import NewDiary from '../new_diary.vue'
import Diaries from '../diaries.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
    path: '/lists',
    name: 'lists',
    component: Lists
  },
  {
    path: '/list/:id',
    name: 'list',
    component: List,
    props: routes => ({
      id: Number(routes.params.id)
    })
  },
  {
    path: '/lists/new',
    name: 'new_list',
    component: NewList
  },
  {
    path: '/lists/:id/edit/',
    name: 'edit_list',
    component: EditList,
    props: routes => ({
      id: Number(routes.params.id)
    })
  },
  {
    path: '/diaries/new',
    name: 'new_diary',
    component: NewDiary
  },
  {
    path: '/diaries',
    name: 'diaries',
    component: Diaries
  }
]
})
