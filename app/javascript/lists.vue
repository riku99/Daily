<template>
  <div>
    <div class='wrapper'>
      <div class='container'>
        <div class='order_button'>
          <button type="button" v-on:click='sortPriority' class='each_order_button'>優先順</button>
          <button type="button" v-on:click='sortDate' class='each_order_button'>新しく作成した順</button>
          <button type="button" v-on:click='sortOldate' class='each_order_button'>古く作成した順</button>
        </div>
        <div class='lists_box'>
          <transition-group>
            <div v-for="list in lists" v-bind:key='list.id' class='lists'>
              <router-link :to="{ name: 'list', params: { id: list.id } }">
                <p class='lists_title'>{{list.title}}</p>
              </router-link>
              <p class='priority'>{{list.priority}}</p>
            </div>
          </transition-group>
        </div>
      </div>
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
  .lists_box {
    margin-top: 3%;
    overflow: scroll;
    height: 600px;
  }

  .lists {
    width: 50%;
    margin: 0 auto;
    display: flex;
    justify-content: center;
    align-items: center;
    justify-content: space-between;
  }

  .lists_title {
    font-size: 28px;
    font-weight: bold;
    color: rgb(84, 84, 84);
    border-bottom: solid;
  }

  .priority {
    font-size: 28px;
    color: rgb(175, 175, 175);
  }

  .order_button {
    margin: 0 auto;
    margin-top: 3%;
    width: 40%;
    display: flex;
    justify-content: space-between;
  }

  .each_order_button {
    background-color: inherit;
    border: none;
    color: rgb(74, 163, 255);
    border-bottom: solid 1px rgb(74, 163, 255);
  }

  .v-move {
    transition: 1s;
  }
</style>
