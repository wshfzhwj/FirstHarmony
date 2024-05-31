import router from '@ohos.router'

@Entry
@Component
struct StorageLinkAPage {
  @StorageLink('count1') indexCount1: number = 0//双向绑定
  @StorageLink('count2') indexCount2: number = 0//双向绑定
  private label: string = '单击'

  build() {
    Column({ space: 20 }) {
      Text('当前页面是 A Page').fontSize(30)
      Button(`${this.label}`)
        .onClick(() => {
          var temp = AppStorage.Get<number>('count1')
          AppStorage.Set<number>('count1', temp + 1)
          this.indexCount2++
          console.log("AppStorage ---" + AppStorage.Get<number>('count1').toString())
        })
      //使用成员变量
      Text(`indexCount1: ${this.indexCount1}`).fontSize(25);
      Text(`indexCount2: ${this.indexCount2}`).fontSize(25);
      //使用存储变量
      Text(`count1: ${AppStorage.Get<number>('count1').toString()}`).fontSize(25);
      Text(`count2: ${AppStorage.Get<number>('count2').toString()}`).fontSize(25);


      Button('跳转到next页面')
        .onClick(() => {
          router.pushUrl({ url: 'pages/StorageLinkBPage' })
        })

      Button('返回')
        .onClick(() => {
          router.back()
        })
    }.width('100%').padding(20)
    .backgroundColor(0xccFFcc)
  }
}