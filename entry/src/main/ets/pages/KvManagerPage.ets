import distributedData from '@ohos.data.distributedData'
import deviceManager from '@ohos.distributedHardware.deviceManager';
@Entry
@Component
struct KvManagerPage {
  @State message: string = 'Hello World'
  kvStore:distributedData.SingleKVStore = undefined
  kvManager:distributedData.KVManager = undefined
  @State value:string = undefined

  build() {
    Row() {
      Column() {
        Button('创建KVManager')
          .width(500)
          .height(80)
          .fontSize(50)
          .align(Alignment.Center)
          .backgroundColor('#AD9D8F')
          .fontColor('#FFFFFF')
          .borderRadius(10)
          .onClick((event: ClickEvent) => {
            try {
              const kvManagerConfig = {
                bundleName: 'com.saint.myapplication',
                userInfo: {
                  userId: '0',
                  userType: distributedData.UserType.SAME_USER_ID
                }
              }

              distributedData.createKVManager(kvManagerConfig, function (err, manager) {
                if (err) {
                  console.info("createKVManager err:" + JSON.stringify(err));
                  return;
                }
                console.info("xxxxxx---createKvManager success");
                this.kvManager = manager;
              });
            } catch (e) {
              console.info("xxxxxx--- An unexpected error occurred. Error:" + e);
            }
          })

        Button('获取/创建KVStore')
          .width(500)
          .height(80)
          .fontSize(50)
          .align(Alignment.Center)
          .backgroundColor('#AD9D8F')
          .fontColor('#FFFFFF')
          .borderRadius(10)
          .onClick((event: ClickEvent) => {
            try {
              const options = {
                createIfMissing: true,  //丢失了是否创建
                encrypt: false,         //是否加密
                backup: false,          //是否备份
                autoSync: false,        //是否自动同步
                kvStoreType: distributedData.KVStoreType.SINGLE_VERSION,//单版本数据库
                securityLevel: distributedData.SecurityLevel.S0//安全等级低一点比较好，等级越高，限制越多
              };

              this.kvManager.getKVStore('storeId332423423', options).then((store) => {
                console.info("xxxxxx---create/getKVStore success");
                this.kvStore = store as distributedData.SingleKVStore;
              });
            } catch (e) {
              console.info("xxxxxx---An unexpected error occurred. Error: " + e);
            }
          })

        Button('订阅分布式数据变化')
          .width(500)
          .height(80)
          .fontSize(50)
          .align(Alignment.Center)
          .backgroundColor('#AD9D8F')
          .fontColor('#FFFFFF')
          .borderRadius(10)
          .onClick((event: ClickEvent) => {
            this.kvStore.on('dataChange', distributedData.SubscribeType.SUBSCRIBE_TYPE_ALL,//分布式数据库订阅类型为全部
              function (data) {
                console.info("xxxxxx---dataChange:" + JSON.stringify(data));
              });
            console.info("xxxxxx---subscribe success");
          })

        Button('写入数据1')
          .width(500)
          .height(80)
          .fontSize(50)
          .align(Alignment.Center)
          .backgroundColor('#AD9D8F')
          .fontColor('#FFFFFF')
          .borderRadius(10)
          .onClick((event: ClickEvent) => {
            this.kvStore.put(this.key + "1", this.value + "1", function (err, data) {
              if (err != undefined) { //没成功
                console.info("xxxxxx---put error:" + JSON.stringify(err));
                return;
              }
              console.info("xxxxxx---put success, data: " + this.value + 1);
            })
          })

        Button('读取数据1')
          .width(500)
          .height(80)
          .fontSize(50)
          .align(Alignment.Center)
          .backgroundColor('#AD9D8F')
          .fontColor('#FFFFFF')
          .borderRadius(10)
          .onClick((event: ClickEvent) => {
            this.kvStore.get(this.key + "1", function (err, data) {
              console.info("xxxxxx---get success, data: " + data);
            })
          })

      }
      .width('100%')
    }
    .height('100%')
  }
}