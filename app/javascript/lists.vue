<template>
  <div id="app">
    <transition-group>
      <div v-for="list in lists" v-bind:key='list.id' class='lists'>
        <p class='lists_title'>{{list.title}}</p>
        <p>{{list.priority}}</p>
        <p><router-link :to="{ name: 'list', params: { id: list.id } }">Content</router-link></p>
      </div>
    </transition-group>
    <button type="button" v-on:click='sortPriority'>優先順</button>
    <button type="button" v-on:click='sortDate'>新しく作成した順</button>
    <button type="button" v-on:click='sortOldate'>古く作成した順</button>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data: function () {
    return {
      lists: []
    }
  },
  mounted() {
    let that = this;  //Vueインスタンス内を参照するthisを代入。
    axios.get('/api/lists').then(function(response) {
      that.lists = response.data  //thisで指定すると、メソッドの呼び出し元、つまりaxiosオブジェクトのthisを参照してしまう。
                                  // アロー関数にした場合はthisはアロー関数が記述された'場所'によって決まるためthisでも問題ない。
    })
  },
  methods: {
    sortPriority() {
      this.lists.sort(function(a, b) {
        return a.priority - b.priority
      });
    },
    sortOldate() {
      this.lists.sort(function(a, b) {
        return new Date(a.created_at) - new Date(b.created_at)
      });
    },
    sortDate() {
      this.lists.sort(function(a, b) {
        return new Date(b.created_at) - new Date(a.created_at)
      })
    }
  }
}
</script>

<style scoped>
  .v-move {
    transition: 1s;
  }
</style>
