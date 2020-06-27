import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  strict: true, // stateの値をmutation以外から変更できないように監視。本番環境では外す。
  state: {
    flash: null
  },
  mutations: {
    addInfo(state, payload) {
      state.flash = payload.info
    },
    deleteMessage(state) {
      state.flash = null
    }
  },
  actions: {
    timeoutFlash(context) {
      setTimeout(function () {
        context.commit('deleteMessage')
      }, 3000);
    }
  },
  getters: {
    presentFlash(state) {
      let flash = state.flash
      if(flash) {
        return flash.message
      } else {
        return null
      }
    }
  }
})
