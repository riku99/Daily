<template>
  <div>
    <p>{{list}}</p>
    <router-link :to="{ name: 'edit_list', params: { id: this.id } }">Edit</router-link>
    <input type="button" value="Delete" v-on:click='deleteList'/>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data: function() {
    return {
      list: []
    }
  },
  props: {
    id: Number
  },
  mounted() {
    let that = this;
    axios.get(`/api/lists/${ this.id }`).then(function(response) {
      that.list = response.data
    })
  },
  methods: {
    deleteList: function() {
      let that = this;
      axios.delete(`/api/lists/${ this.id }`).then(function(response) {
        console.log('ok')
        that.$router.push({ name: 'lists' })
      })
    }
  }
}
</script>

<style scoped>
</style>
