<template>
  <div>
    <div v-if='current_list.error_message'>
      <p>{{current_list.error_message}}</p>
    </div>
    <form>
      <label for='title'>Title</label>
      <input v-model="current_list.title" type="text" id='title'>
      <label for='content'>Content</label>
      <input v-model='current_list.content' type="text" id='content'/>
      <label for='priority'>Priority</label>
      <input v-model='current_list.priority' type="number" id='priority'/>
      <input v-bind:value='button' type="button" v-on:click='click'/>
    </form>
  </div>
</template>

<script>
export default {
  props: [ 'list', 'button' ],
  data: function() {
    return {
      current_list: this.list
    };
  },
  watch: {
    list: function() {
      this.current_list = this.list;
    }
  },
  methods: {
    click: function() {
      this.$emit('click-form', this.current_list)
    },
  }
}
</script>

<style lang="css" scoped>
</style>
