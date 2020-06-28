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
      <div class="">
        <router-link v-bind:to='{ name: "lists" }'>Lists</router-link>
        <router-link :to="{ name: 'new_list'}">Create</router-link>
      </div>
    </footer>
  </div>
</template>

<script>
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
}

header h3 {
  position: absolute;
  left: 50%;
  transform: translate(-50%, -50%);
  font-size: 27px;
  font-family: 'Skia-Regular_Condensed';
  color: rgb(32, 76, 208);
}

footer {
  width: 100%;
  height: 60px;
  background-color: inherit;
  border-top: solid 1px rgb(227, 227, 227);
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
}

  .flash-enter {
    transform: translateY(50px);
  }

  .flash-enter-active {
    transition: 0.2s;
  }
</style>
