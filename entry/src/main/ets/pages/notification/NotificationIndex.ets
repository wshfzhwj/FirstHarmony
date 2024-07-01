import commonEventManager from '@ohos.commonEventManager'
import promptAction from '@ohos.promptAction'
import notificationManager from '@ohos.notificationManager'
import wantAgent, { WantAgent } from '@ohos.app.ability.wantAgent'
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
export default struct NotificationIndex {
  @State result: string = 'nothing'
  @State isCheck: boolean = false
  private subscriber : commonEventManager.CommonEventSubscriber | null = null;

  createSubscriber() {
    let subInfo : commonEventManager.CommonEventSubscribeInfo = {
      events: ["some"]
    }

    commonEventManager.createSubscriber(subInfo, (err, subscriber : commonEventManager.CommonEventSubscriber) => {
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

  publish() {
    let options: commonEventManager.CommonEventPublishData ={
      code: 1,
      data: '发送的是公共事件数据',
    }

    commonEventManager.publish('some', options, (err) => {
      if (err) {
        console.log('提示：取消订阅错误 err = ', JSON.stringify(err))
      } else {
        console.log('提示：公共事件发布成功')
      }
    })

  }

  downloadTemplatePublish() {
    let notificationRequest: notificationManager.NotificationRequest = {
      id: 1,
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: 'test_title',
          text: 'test_text',
          additionalText: 'test_additionalText'
        }
      },
      // 构造进度条模板，name字段当前需要固定配置为downloadTemplate
      template: {
        name: 'downloadTemplate',
        data: { title: 'File Title', fileName: 'music.mp4', progressValue: 45 }
      }
    }
    // 发布通知
    notificationManager.publish(notificationRequest, (err) => {
      if (err) {
        console.error(`Failed to publish notification. Code is ${err.code}, message is ${err.message}`);
        return;
      }
      console.info('Succeeded in publishing notification.');
    });
  }

  /**
   * 场景一：创建拉起Ability的WantAgent的WantAgentInfo信息。
   * @returns wantAgentInfo operationType设置动作类型
   */
  createAbilityWantInfo(): wantAgent.WantAgentInfo {
    console.error(`[ANS] createAbilityWantInfo start`);
    // 通过WantAgentInfo的operationType设置动作类型。
    let wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          bundleName: 'com.example.myApplication',
          abilityName: 'EntryAbility',
          action: 'action1',
          entities: ['entity1'],
          uri: '',
          parameters: {}
        }
      ],
      operationType: wantAgent.OperationType.START_ABILITY,
      requestCode: 0,
      wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
    }
    return wantAgentInfo
  }

  /**
   * 场景二：创建发布公共事件的WantAgent的WantAgentInfo信息。
   * @returns wantAgentInfo
   */
  createAEventWantInfo(): wantAgent.WantAgentInfo {
    // wantAgentInfo
    let wantAgentInfo: wantAgent.WantAgentInfo = {
      wants: [
        {
          action: 'event_name', // 设置事件名。
          parameters: {},
        }
      ],
      operationType: wantAgent.OperationType.SEND_COMMON_EVENT,
      requestCode: 0,
      wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG],
    }
    return wantAgentInfo
  }

  createAbilityWantAgent(): Promise<WantAgent> {
    console.error(`[ANS] createAbilityWantAgent start`);
    return new Promise<WantAgent>((resolve, reject) => {
      wantAgent.getWantAgent(this.createAbilityWantInfo(), (err, data) => {
        if (err) {
          console.error('[ANS] getWantAgent err=' + JSON.stringify(err));
          reject()
        } else {
          console.info('[ANS] getWantAgent success');
          resolve(data)
        }
      });
    })
  }

  createEventWantAgent(): Promise<WantAgent> {
    return new Promise<WantAgent>((resolve, reject) => {
      wantAgent.getWantAgent(this.createAEventWantInfo(), (err, data) => {
        if (err) {
          console.error('[WantAgent]getWantAgent err=' + JSON.stringify(err));
          reject()
        } else {
          console.info('[WantAgent]getWantAgent success');
          resolve(data)
        }
      });
    })
  }

  async createNotificationRequest() {
    console.error(`[ANS] createNotificationRequest start`);
    let wantAgent = await this.createAbilityWantAgent()
    // 构造NotificationRequest对象
    let notificationRequest: notificationManager.NotificationRequest = {
      content: {
        notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: 'Test_Title',
          text: 'Test_Text',
          additionalText: 'Test_AdditionalText',
        },
      },
      id: 1,
      label: 'TEST',
      wantAgent: wantAgent,
    }
    console.error(`[ANS] createNotificationRequest return`);
    return notificationRequest
  }

  publishNotification(request: notificationManager.NotificationRequest) {
    // 通知发送
    notificationManager.publish(request, (err) => {
      if (err) {
        console.error(`[ANS] failed to publish, error[${err}]`);
        return;
      }
      console.info(`[ANS] publish success `);
    });
  }

  publishNotify(){
    let wantAgentObj:WantAgent; // 用于保存创建成功的wantAgent对象，后续使用其完成触发的动作。

    // 通过WantAgentInfo的operationType设置动作类型
    let wantAgentInfo:wantAgent.WantAgentInfo = {
      wants: [
        {
          deviceId: '',
          bundleName: 'com.example.myApplication',
          abilityName: 'EntryAbility',
          action: '',
          entities: [],
          uri: '',
          parameters: {}
        }
      ],
      operationType: wantAgent.OperationType.START_ABILITY,
      requestCode: 0,
      wantAgentFlags:[wantAgent.WantAgentFlags.CONSTANT_FLAG]
    };

    // 创建WantAgent
    wantAgent.getWantAgent(wantAgentInfo).then((data)=>{
      console.info('Succeeded in getting want agent.');
      wantAgentObj = data;
      let notificationRequest: notificationManager.NotificationRequest = {
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: 'Test_Title',
            text: 'Test_Text',
            additionalText: 'Test_AdditionalText',
          },
        },
        id: 6,
        label: 'TEST',
        wantAgent: wantAgentObj,
      }
      console.info(`wantAgentObj= ${wantAgentObj}`);
      notificationManager.publish(notificationRequest, (err) => {
        if (err) {
          console.error(`Failed to publish notification. Code is ${err.code}, message is ${err.message}`);
          return;
        }
        console.info('Succeeded in publishing notification.');
      });
      // 构造NotificationRequest对象
    }).catch((err:BusinessError) => {
        console.error(`Failed to get want agent. Code is ${err.code}, message is ${err.message}`);
        return;
    });
  }

  build() {
    Row() {
      Column() {
        Button('创建订阅者')
          .fontSize(39)
          .margin(20)
          .width('75%')
          .onClick(() => {
            this.createSubscriber()
          })

        Row() {
          Checkbox({ name: 'checkbox', group: 'checkboxGroup' })
            .select(this.isCheck)
            .width(40)
            .height(40)
            .onChange((value) => {
              this.isCheck = value
              if (value) {
                this.subscribe()
              } else {
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
          .onClick(() => {
            this.downloadTemplatePublish()
          })
        Button('发布代理提醒')
          .fontSize(39)
          .margin(20)
          .width('75%')
          .onClick(async () => {
            // pubReminder()
            // let request = await this.createNotificationRequest()
            // this.publishNotification(request)
            this.publishNotify()
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