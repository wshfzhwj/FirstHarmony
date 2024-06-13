import commonEvent from '@ohos.commonEvent'
import commonEventManager from '@ohos.commonEventManager'
import prompt from '@ohos.prompt'
import promptAction from '@ohos.promptAction'
import { pubReminder } from '../../model/ReminderModel'

@Entry
@Component
export default struct NotificationIndex {
  @State result: string = 'nothing'
  @State isCheck: boolean = false
  private subscriber = null

  createSubscriber() {
    var subInfo = {
      events: ["some"]
    }

    commonEventManager.createSubscriber(subInfo, (err, subscriber) => {
      if (err) {
        console.log('提示:创建订阅者错误 err = ', JSON.stringify(err))
      } else {
        this.subscriber = subscriber
        this.result = '创建订阅者成功'
      }
    })
  }

  subscribe() {
    if (this.subscriber != null) {
      commonEventManager.subscribe(this.subscriber, (err, data) => {
        if (err) {
          console.log('提示：处理公共事件 err = ', JSON.stringify(err))
        } else {
          console.log('提示：处理公共事件 data = ', JSON.stringify(data))
          this.result = `接受内容： event = ${data.event}`
          this.result += `code = ${data.code},data = ${data.data}`
        }
      })
      this.result = '订阅成功'
    } else {
      promptAction.showToast({ message: '提示：请首先创建订阅者', duration: 3000 })
    }
  }

  unsubscribe() {
    if (this.subscriber != null) {
      commonEventManager.unsubscribe(this.subscriber, (err) => {
        if (err) {
          console.log('提示：取消订阅错误 err = ', JSON.stringify(err))
        } else {
          console.log('提示:已取消订阅')
          this.result = '取消订阅成功'
        }
      })
    }
  }
  publish(){
    var options = {
      code:1,
      data:'发送的是公共事件数据',
    }
    commonEventManager.publish('some',options,(err)=>{
      if(err){
        console.log('提示：取消订阅错误 err = ', JSON.stringify(err))
      }else{
        console.log('提示：公共事件发布成功')
      }
    })
  }


    build() {
      Row() {
        Column() {
          Button('创建订阅者')
            .fontSize(39)
            .margin(20)
            .width('75%')
            .onClick(()=>{
              this.createSubscriber()
            })

          Row(){
            Checkbox({name:'checkbox',group:'checkboxGroup'})
              .select(this.isCheck)
              .width(40)
              .height(40)
              .onChange((value)=>{
                this.isCheck = value
                if(value){
                  this.subscribe()
                }else{
                  this.unsubscribe()
                }
              })
            Text('订阅/取消订阅')
              .fontSize(30)
          }

          Button('发布公共事件')
            .fontSize(39)
            .margin(20)
            .width('75%')
            .onClick(()=>{
              this.publish()
            })
          Button('发布代理提醒')
            .fontSize(39)
            .margin(20)
            .width('75%')
            .onClick(()=>{
              pubReminder()
            })

          Text(this.result)
            .fontSize(30)
            .backgroundColor('#EEEEEE')

        }
        .width('100%')
      }
      .height('100%')
    }
  }