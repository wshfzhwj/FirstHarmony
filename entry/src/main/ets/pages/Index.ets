import router from '@ohos.router'
import systemDateTime from '@ohos.systemDateTime'

@Entry
@Component
struct Index {
  routesSettings: RouteSetting[] = [
    new RouteSetting('StorageLinkAPage', 'pages/StorageLinkAPage'),
    new RouteSetting('Diary', 'pages/diary/DiaryIndex', { msg: "hello world", id: "1" }),
    new RouteSetting('KvManagerPage', 'pages/KvManagerPage'),
    new RouteSetting('NetworkPage', 'pages/NetworkPage'),
  ];
  @State date: string = undefined

  onPageShow() {
    if (this.date == undefined) {
      systemDateTime.getDate().then((result) => {
        this.date = result.toDateString()
      })
    }
  }

  build() {
    Column({ space: 5 }) {
      Text(`页面列表`).fontSize(30).height(80)
      List({ space: 10 }) {
        ForEach(this.routesSettings, (item: RouteSetting, index) => {
          ListItem() {
            Row() {
              Text(`${index + 1}.`).fontSize(30).height(60)
              Blank()
              Text(`${item.title}`).fontSize(30).height(60)
            }
            .width('100%')
            .btnStyle()
            .onClick(() => {
              router.pushUrl({ url: item.url, params: item.params }, router.RouterMode.Standard, err => {
                if (err) {
                  console.log('路由失败.')
                }
              })
            })
          }
        })
      }
      // .onReachEnd(()=>{})
      .margin({ bottom: 10 })
    }
    .padding({ left: 20, right: 20 })
  }

  @Styles btnStyle() {
    .padding({ left: 20, right: 20 })
    .backgroundColor('#678')
    .borderRadius(50)
  }
}

class RouteSetting {
  title: string
  url: string
  params: Object

  constructor(title: string, url: string, params?: Object) {
    this.title = title
    this.url = url
    this.params = params
  }
}


class DataModelInfo {
  age: number;
}

class DataModel {
  id: number;
  info: DataModelInfo;
}




