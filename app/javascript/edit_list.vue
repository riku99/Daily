<template>
  <div class="">
    <list-form v-bind:list='list' button='Update' v-on:click-form='updateList'></list-form>
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
      list: ''
    };
  },
  props: {
    id: Number
  },
  mounted: function() {
    let that = this;
    axios.get(`/api/lists/${ this.id }`).then(function(response) {
      that.list = response.data
    })
  },
  methods: {
    updateList: function() {
      let that = this;
      axios.patch(`/api/lists/${ this.id }`, this.list).then(function(response) {
        if(response.data) {
          that.$set(that.list, 'error_message', response.data)
          console.log(that.list)
        } else {
          that.$router.push({ name: 'list', params: that.id })
        }
      })
    }
  }
}
</script>

<style lang="css" scoped>
</style>
