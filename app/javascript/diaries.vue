<template>
  <div class="wrapper">
    <div class="container">
      <transition-group tag="div" class="diaries" appear>
        <div
          v-for="diary in present_diaries"
          v-bind:key="diary.id"
          class="diary"
        >
          <div v-if="diary.image">
            <img v-bind:src="diary.image" class="diary_image" />
          </div>
          <router-link :to="{ name: 'diary', params: { id: diary.id } }">
            <div v-if="diary.title" class="diary_title">
              {{ diary.title }}
            </div>
          </router-link>
          <div class="diary_date">
            {{ diary.date }}
          </div>
        </div>
      </transition-group>
      <div class="pagenates">
        <div class="pagenate" v-for="count in pageCount">
          <input
            type="button"
            v-bind:value="count"
            v-on:click="changeDiaries(count)"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data: function() {
    return {
      diaries: [],
      present_diaries: [],
    };
  },
  computed: {
    pageCount() {
      let count = this.diaries.length / 6;
      let page_count = Math.ceil(count);
      if (page_count > 10) {
        return 10;
      } else {
        return page_count;
      }
    },
  },
  mounted() {
    let that = this;
    axios
      .get("/api/diaries")
      .then(function(response) {
        that.diaries = response.data;
      })
      .then(function() {
        if (that.diaries.length > 6) {
          that.present_diaries = that.diaries.slice(0, 6);
        } else {
          that.present_diaries = that.diaries;
        }
      });
  },
  methods: {
    changeDiaries(count) {
      this.present_diaries = this.diaries.slice(count * 6 - 6, count * 6);
    },
  },
};
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
  width: 30%;
  height: 50%;
  padding: 0% 7%;
}

.diary_image {
  height: 150px;
  width: 90%;
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

.pagenates {
  position: absolute;
  bottom: 3%;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
}

.pagenate input {
  background-color: inherit;
  border: none;
  font-size: 15px;
  border: solid 1px rgb(74, 163, 255);
  color: rgb(74, 163, 255);
  padding: 8px 13px;
}

.v-enter {
  transform: translateY(30px);
  opacity: 0;
}

.v-enter-active {
  transition-duration: 0.6s;
}

.v-enter-to {
  opacity: 1;
}

.v-leave-active {
  transition: 1s;
  display: none;
}
</style>
