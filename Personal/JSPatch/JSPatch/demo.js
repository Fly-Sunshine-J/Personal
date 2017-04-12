console.log("run  success")
require('SecondViewController,  UIColor')
defineClass('ViewController',['color'], {
            viewDidLoad: function() {
            /***增加新的属性color**/
                self.setColor(UIColor.greenColor())
                var titleText = self.titleText();
                console.log(titleText);
            /**如果oc实现了set方法，这里是不会成功的*/
                self.setTitleText("Test成功");
                console.log(self.titleText());
                self.changeColor(UIColor.grayColor())
            },
            
/**实例方法*/
            push:function(btn){
                console.log("btn click");
        
            self.view().setBackgroundColor(self.color());
            /**调用未覆盖前OC中的方法**/
            self.ORIGpush(btn);
            
            //[self.navigationController pushViewController:nil animated:YES]
            var second = SecondViewController.alloc().init();
            second.view().setBackgroundColor(UIColor.redColor());
            var weakSelf = self;
            second.setCallBack(block("NSString *", function(content){
                                     console.log(content)
                                     weakSelf.setTitle(content);
                                     }));
            self.navigationController().pushViewController_animated(second, true);
            },
            
            changeColor:function(color) {
                self.setColor(color);
            }
},
{
/**类方法*/
            instanceMethod: function() {
                console.log("覆盖后的类方法")
            }
            })

defineClass('SecondViewController', [], {
            
            
            
            }, {})




