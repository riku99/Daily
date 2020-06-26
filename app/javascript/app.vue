<template>
  <div>
    <router-link v-bind:to='{ name: "lists" }'>Lists</router-link>
    <router-link :to="{ name: 'new_list'}">Create</router-link>
    <div>
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
export default {
}
</script>

<style scoped>
</style>
