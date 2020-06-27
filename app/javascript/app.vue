<template>
  <div>
    <router-link v-bind:to='{ name: "lists" }'>Lists</router-link>
    <router-link :to="{ name: 'new_list'}">Create</router-link>
    <div>
      <router-view></router-view>
      <transition appear name='flash'>
        <p v-if='flash' class='flash'>{{flash}}</p>
      </transition>
    </div>
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
</style>
