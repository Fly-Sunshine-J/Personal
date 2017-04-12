//index.js
//获取应用实例
var app = getApp()

Page({
  data: {
    leftSection:[],
    sysInfo:{},
  },
  
  onLoad:function(options){
    var that = this;
    app.getSysInfo(function(info){
      that.setData({
        sysInfo:info
      })
    })
    this.setData({
      leftSection:app.leftSection
    })
  },

})
