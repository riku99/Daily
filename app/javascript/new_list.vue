<template>
  <div>
    <form>
      <label>Title</label>
      <input v-model="list.title" type="text">
      <label>Content</label>
      <input v-model='list.content' type="text"/>
      <label>priority</label>
      <input v-model='list.priority' type="number"/>
      <input value='Create' type="button" v-on:click='createList'/>
    </form>
    <p>{{list.title}}</p>
    <p>{{list.content}}</p>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data: function() {
    return {
      list: {
        title: '',
        content: '',
        priority: ''
      }
    }
  },
  methods: {
    createList: function() {
      let that = this;
      axios.post('/api/lists', this.list).then(function(response) {
        console.log('ok')
        that.$router.push({name: 'lists'})
      })
    }
  }
}
</script>

<style lang="css" scoped>
</style>
