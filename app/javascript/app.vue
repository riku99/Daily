<template>
  <div>
    <header>
      <h3>Daily</h3>
    </header>
    <div>
      <router-view></router-view>
      <transition name='flash'>
        <p v-if='flash' class='flash'>{{flash}}</p>
      </transition>
    </div>
    <footer>
      <div class='select'>
        <router-link v-bind:to='{ name: "lists" }'>やることリスト</router-link>
        <router-link :to="{ name: 'new_list'}">リスト作成</router-link>
        <router-link :to="{ name: 'new_diary' }">日記作成</router-link>
        <router-link :to="{ name: 'diaries' }">日記を読む</router-link>
      </div>
    </footer>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  computed: {
    flash() {
      if(this.$store.getters.presentFlash) {
        this.$store.dispatch('timeoutFlash')
      }
      return this.$store.getters.presentFlash
    }
  },
}
</script>

<style scoped>
header {
  width: 100%;
  height: 60px;
  background-color: inherit;
  border-bottom: solid 1px rgb(227, 227, 227);
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 10;
}

header h3 {
  position: absolute;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 27px;
  font-family: 'Skia-Regular_Condensed';
  color: #2c3e50;
}

footer {
  width: 100%;
  height: 60px;
  background-color: white;
  border-top: solid 1px rgb(227, 227, 227);
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  line-height: 60px;
  z-index: 10;
}

.flash {
  padding: 0% 10%;
  height: 40px;
  line-height: 40px;
  position: absolute;
  bottom: 10%;
  left: 50%;
  transform: translateX(-50%);
  border-radius: 25px;
  background-color: rgba(255, 191, 0, 0.8);
  color: white;
  font-weight: bold;
}

.flash-enter {
    transform: translateY();
    transform: translateX(-50%);
  }

.flash-enter-active {
    transition: 3s;
  }

.select {
  display: flex;
  justify-content: space-around;
  }

  .select a {
    color: #2c3e50;
    font-weight: bold;
  }

</style>
