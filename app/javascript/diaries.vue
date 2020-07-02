<template>
<div class='wrapper'>
  <div class='container'>
    <transition-group tag='div' class='diaries' appear>
      <div v-for='diary in diaries' v-bind:key='diary.id' class='diary' v-bind:class='`diary_${diary.id}`'>
        <div v-if='diary.image'>
          <img v-bind:src="`data:image/${diary.ext};base64,${diary.image}`" class='diary_image'>
        </div>
        <div v-if='diary.title' class='diary_title'>
          {{diary.title}}
        </div>
        <div class='diary_date'>
          {{diary.date}}
        </div>
      </div>
    </transition-group>
  </div>
</div>
</template>

<script>
import axios from 'axios'
export default {
  data: function() {
    return {
      diaries: []
    }
  },
  mounted() {
    let that = this;
    axios.get('/api/diaries').then(function(response) {
      that.diaries = response.data;
    })
  }
}
</script>

<style scoped>
.diaries {
  width: 70%;
  height: 80%;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  margin: auto;
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}

.diary {
  width: 20%;
  height: 50%;
  padding-right: 2%;
}

.diary_image {
  height: 150px;
  width: 100%;
}

.diary_title {
  font-weight: bold;
  color: #2c3e50;
  font-size: 20px;
}

.diary_date {
  margin-top: 2%;
  font-size: 13px;
  color: rgb(84, 84, 84);
}

.tr {
  display: flex;
}

.v-enter {
  transform: translateY(20px);
  opacity: 0;
}

.v-enter-active {
  transition: 0.4s;
}

.v-enter-to {
  opacity: 1;
}

.diary_2 {
  transition-delay: 0.1s;
}

.diary_3 {
  transition-delay: 0.2s;
}

.diary_4 {
  transition-delay: 0.3s;
}

.diary_5 {
  transition-delay: 0.4s;
}

.diary_6 {
  transition-delay: 0.5s;
}

.diary_7 {
  transition-delay: 0.6s;
}

.diary_8 {
  transition-delay: 0.7s;
}

.diary_9 {
  transition-delay: 0.8s;
}

.diary_10 {
  transition: 0.9s;
}
</style>
