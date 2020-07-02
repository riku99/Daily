<template>
  <div class='wrapper'>
    <div class='container'>
      <div class='diary_form_box'>
        <form>
          <label for='title'>タイトル</label>
          <input type="text" id='title' v-model='diary.title'>
          <label for='content' id='.content'>ないよう</label>
          <textarea id='content' v-model='diary.content'></textarea>
          <label for='image'>写真を選択する</label>
          <input type='file' id='image' ref='image' v-on:change='putImage'>
          <img v-bind:src='diary.base_image' alt="" v-if='diary.base_image'>
          <input type='button' value='作成' v-on:click='createDiary'>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data: function() {
    return {
      diary: {
        title: '',
        content: '',
        base_image: null
      }
    }
  },
  methods: {
    putImage() {
      let that = this;
      let file = this.$refs.image.files[0];
      let reader = new FileReader();
      reader.addEventListener('load', function() {
        let img = reader.result;
        that.diary.base_image = img;
      })
      reader.readAsDataURL(file)
    },
    createDiary() {
      let that = this;
      axios.post('/api/diaries', { diary: this.diary }).then(function(response) {
        that.$store.commit('addInfo', { info: { message: '日記を作成しました' } })
        that.$router.push({ name: 'diaries' })
      })
    }
  }
}
</script>

<style lang="css" scoped>
</style>
