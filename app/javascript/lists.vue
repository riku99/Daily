<template>
  <div id="app">
    <div v-for="list in lists">
      <p>{{list.title}}</p>
      <p>{{list.priority}}</p>
      <p><router-link :to="{ name: 'list', params: { id: list.id } }">Content</router-link></p>
    </div>
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
      console.log(response.data)
      that.lists = response.data  //thisで指定すると、メソッドの呼び出し元、つまりaxiosオブジェクトのthisを参照してしまう。
                                  // アロー関数にした場合はthisはアロー関数が記述された'場所'によって決まるためthisでも問題ない。
    })
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
