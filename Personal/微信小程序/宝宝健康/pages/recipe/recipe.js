//index.js
//获取应用实例

var app = getApp()
Page({
  data:{
    showLoading: true,
    section:[],
  },
  onLoad:function(options){
    this.setData({
      section:app.recipeSection.section,
    })
  },
  onReady:function(){
    // 页面渲染完成
    var that = this
    setTimeout(function () {
      that.setData({
        showLoading: false
      })
    }, 1500)
  },
  onShow:function(){

  },
  onHide:function(){
    // 页面隐藏
  },
  onUnload:function(){
    // 页面关闭
  },
  viewDetial:function(e) {
    
  }
})