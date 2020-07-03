<template>
<div class='wrapper'>
  <div class='container'>
    <div class='image'>
      <img class='img' v-bind:src="`data:image/${diary.ext};base64,${diary.image}`" v-if='diary.image'>
    </div>
    <div class='content'>
      {{diary.content}}
    </div>
    <input class='delete_image' type='button' value='削除する' v-on:click='deleteDiary'>
  </div>
</div>
</template>

<script>
import axios from 'axios'
export default {
  data: function() {
    return {
      diary: ''
    }
  },
  props: {
    id: Number
  },
  mounted() {
    let that = this;
    axios.get(`/api/diaries/${this.id}`).then(function(respons) {
      that.diary = respons.data;
    })
  },
  methods: {
    deleteDiary() {
      let that = this;
      if (confirm('削除しますか？')) {
        axios.delete(`/api/diaries/${this.id}`).then(function() {
          that.$router.push({
            name: 'diaries'
          })
          that.$store.commit('addInfo', {
            info: {
              message: '削除しました'
            }
          })
        })
      }
    }
  }
}
</script>

<style scoped>
.img {
  width: 20%;
}

.delete_image {
  color: rgb(74, 163, 255);
  border: none;
  border-bottom: solid 1px rgb(74, 163, 255);
  background-color: inherit;
  margin-top: 15px;
}
</style>
