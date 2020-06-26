<template>
  <form>
    <label>Title</label>
    <input type="text" v-model='list.title'>
    <label>Content</label>
    <input type="text" v-model='list.content'>
    <label>Priority</label>
    <input type="number" v-model='list.priority'>
    <input type="button" value='Update' v-on:click='updateList'/>
  </form>
</template>

<script>
import axios from 'axios'

export default {
  data: function() {
    return {
      list: ''
    }
  },
  props: {
    id: Number
  },
  mounted: function() {
    let that = this;
    axios.get(`/api/lists/${ this.id }`).then(function(response) {
      that.list = response.data
      console.log(that.list)
    })
  },
  methods: {
    updateList: function() {
      let that = this;
      axios.patch(`/api/lists/${ this.id }`, this.list).then(function(response) {
        that.$router.push({ name: 'list', params: that.id })
      })
    }
  }
}
</script>

<style lang="css" scoped>
</style>
