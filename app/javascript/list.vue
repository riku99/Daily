<template>
  <div>
    <div class='wrapper'>
      <div class='container'>
        <div>
          <p class='show_content'>{{list.content}}</p>
          <p>{{list.date}}</p>
        </div>
        <router-link :to="{ name: 'edit_list', params: { id: this.id } }" class='list_edit_link'>Edit</router-link>
        <input type="button" value="Delete" v-on:click='deleteList' class='list_delete'/>
      </div>
    </div>
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
      if (confirm('削除しますか?')) {
        axios.delete(`/api/lists/${ this.id }`).then(function(response) {
          that.$store.commit('addInfo', {
            info: { message: '削除しました' }
          })
          that.$router.push({ name: 'lists' })
        })
      }
    }
  }
}
</script>

<style scoped>
  p {
    color: rgb(84, 84, 84);
  }

  .list_edit_link, .list_delete {
    color: rgb(74, 163, 255);
    border: none;
    border-bottom: solid 1px rgb(74, 163, 255);
    font-size: 20px;
  }

  .list_delete {
    margin-left: 10%;
    background-color: inherit;
  }
</style>
