import router from '@ohos.router'
import systemDateTime from '@ohos.systemDateTime'

@Component
export struct HomeIndex{
  routesSettings: RouteSetting[] = [
    new RouteSetting('StorageLinkAPage', 'pages/storage/StorageLinkAPage'),
    new RouteSetting('Diary', 'pages/diary/DiaryIndex', { msg: "hello world", id: "1" }),
    new RouteSetting('KvManagerPage', 'pages/KvManagerIndex'),
    new RouteSetting('NetworkPage', 'pages/NetworkIndex'),
  ];

  @State date: string = undefined

  onPageShow() {
    if (this.date == undefined) {
      systemDateTime.getDate().then((result) => {
        this.date = result.toDateString()
      })
    }
  }

  build(){
    Column({ space: 5 }) {
      Text(`页面列表`)
        .fontSize(30)
        .height(80)
        .padding({ left: 5, right: 5 })
      List({ space: 10 }) {
        ForEach(this.routesSettings, (item: RouteSetting, index) => {
          ListItem() {
            Button(`${index + 1}.${item.title}`)
              .btnKvStyle()
              .onClick(() => {
                router.pushUrl({ url: item.url, params: item.params }, router.RouterMode.Standard, err => {
                  if (err) {
                    console.log('路由失败.')
                  }
                })
              })
          }
        })
      }.layoutWeight(1)
      // .onReachEnd(()=>{})
      .margin({ bottom: 10 })
    }.backgroundColor('#02bd79')
    .padding({ left: 20, right: 20 })
  }

  @Styles BtnStyle() {
    .padding({ left: 20, right: 20 })
    .backgroundColor('#678')
    .borderRadius(50)
  }

  @Styles TextBorder(){
    .border({
      style: BorderStyle.Solid,
      width: 1,
      color: Color.White,
      radius: 15
    })
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

@Extend(Button) function btnKvStyle() {
  .width('100%')
  .height(60)
  .fontSize(30)
  .align(Alignment.Center)
}