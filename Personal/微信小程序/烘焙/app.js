//app.js
App({
  onLaunch: function () {
    
  },

  getSysInfo:function(cb) {
    var that = this;
    if (this.globalData.sysInfo){
      typeof cb == "function" && cb(this.globalData.sysInfo);
    }else {
      wx.getSystemInfo({
        success: function(res) {
          that.globalData.sysInfo = {"height": res.windowHeight, "width":res.windowWidth};
          typeof cb == "function" && cb(that.globalData.sysInfo);
        }
      })
    }
  },

    globalData:{
    sysInfo:null
  },
  
  "leftSection":[
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"},
    {"title":"最新", "image":"zuixin"}
    ],
})