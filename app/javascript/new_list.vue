<template>
  <div class='wrapper'>
    <div class='container'>
      <list-form v-bind:list='list' button='Create' v-on:click-form='createList'></list-form>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import ListForm from './list_form.vue'

export default {
  components: {
    ListForm
  },
  data: function() {
    return {
      list: {
        title: '',
        content: '',
        priority: '',
        error_message: ''
      }
    }
  },
  methods: {
    createList: function(e) {
      let that = this;
      axios.post('/api/lists', e).then(function(response) {
        if(response.data) {
          that.list.error_message = response.data
        } else {
          that.$store.commit('addInfo', {
            info: { message: '作成しました' }
          })
          that.$router.push({name: 'lists'})
        }
      })
    }
  }
}
</script>

<style scoped>
  
</style>
