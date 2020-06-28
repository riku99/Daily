<template>
  <div>
    <div v-if='current_list.error_message' class='error'>
      <p>{{current_list.error_message}}</p>
    </div>
    <div class='list_form_box'>
      <form>
        <label for='title'>Title</label>
        <input v-model="current_list.title" type="text" id='title' class='title_form'>
        <label for='content'>Content</label>
        <textarea v-model='current_list.content' type="text" id='content' class='content_form'/>
        <label for='priority'>Priority</label>
        <input v-model='current_list.priority' type="number" id='priority' class='priority_form'/>
        <input v-bind:value='button' type="button" v-on:click='click' class='list_button'/>
      </form>
  </div>
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
  input, textarea {
    display: block;
    margin-left: 10%;
    border: none;
    border-bottom: solid 1px rgb(227, 227, 227);
    outline: 0;
  }

  label {
    font-weight: bold;
    font-size: 24px;
    display: block;
    margin-top: 10%;
  }

  .list_form_box {
    height: 80%;
    width: 60%;
    margin: 0 auto;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -65%);
  }

  .title_form {
    width: 80%;
    height: 60px;
    font-size: 30px;
    color: rgb(84, 84, 84);
  }

  .content_form {
    width: 80%;
    height: 100px;
    font-size: 17px;
    resize: none;
    color: rgb(84, 84, 84);
  }

  .priority_form {
    margin-top: 5%;
    font-size: 30px;
    text-align: center;
    width: 20%;
  }

  .list_button {
    margin: 0 auto;
    margin-top: 3%;
    font-size: 20px;
    background-color: inherit;
    color: rgb(74, 163, 255);
    border: none;
  }
</style>
