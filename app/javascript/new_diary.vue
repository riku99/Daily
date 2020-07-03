<template>
  <div class='wrapper'>
    <div class='container'>
      <div v-if='diary.error_message' class='error'>
        <p>{{diary.error_message}}</p>
      </div>
      <div class='diary_form_box'>
        <form>
          <label for='title'>タイトル</label>
          <input type="text" id='title' class='diaty_title' v-model='diary.title'>
          <label for='content' id='.content'>ないよう</label>
          <textarea id='content' class='diary_content' v-model='diary.content'></textarea>
          <label for='image' class='image_label'>写真を選択する</label>
          <input type='file' id='image' class='diary_image_form' ref='image' v-on:change='putImage'>
          <img class='preview' v-bind:src='diary.base_image' v-if='diary.base_image' >
          <input type='button' class='submit' value='作成' v-on:click='createDiary'>
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
        base_image: null,
        error_message: ''
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
        if(response.data) {
          that.diary.error_message = response.data
        } else {
          that.$store.commit('addInfo', { info: { message: '日記を作成しました' } })
          that.$router.push({ name: 'diaries' })
        }
      })
    }
  }
}
</script>

<style scoped>
label {
  display: block;
  font-weight: bold;
  font-size: 20px;
  margin-top: 3%;
  color: #2c3e50;
}

.diary_form_box {
  text-align: center;
}

.diaty_title {
  margin-left: 3%;
  width: 30%;
  margin-top: 2%;
  border: none;
  border-bottom: solid 1px rgb(227, 227, 227);
  outline: 0;
  font-size: 25px;
  color: rgb(84, 84, 84);
}

.diary_content {
  margin-left: 3%;
  margin-top: 2%;
  border: none;
  border-bottom: solid 1px rgb(227, 227, 227);
  width: 30%;
  outline: 0;
  height: 70px;
  color: rgb(84, 84, 84);
}

.diary_image_form {
  display: none;
}

.image_label {
  font-size: 17px;
}

.preview {
  width: 10%;
  position: absolute;
  left: 30%;
}

.submit {
  background-color: inherit;
  border: none;
  margin-top: 8%;
  color: rgb(74, 163, 255);
  outline: 0;
}

</style>
